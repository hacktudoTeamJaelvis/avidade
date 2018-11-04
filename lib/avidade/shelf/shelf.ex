defmodule Avidade.Shelf do
  alias Avidade.{Repo, Shelf.Item}

  def update_shelf(shelf_state) do
    Repo.transaction(fn ->
      items = Repo.all(Item)
      new_items = new_items(items, shelf_state)
      items_to_delete = items_to_delete(items, shelf_state)
      updated_items = updated_items(items, shelf_state, items_to_delete)

      Enum.each(new_items, &Repo.insert!/1)
      Enum.each(items_to_delete, &Repo.delete!/1)
      Enum.each(updated_items, &Repo.update!/1)
    end)
  end

  defp new_items(items, shelf_state) do
    existing_ids =
      items
      |> Enum.map(& &1.id)
      |> MapSet.new()

    shelf_state
    |> Enum.filter(fn {id, _} -> !MapSet.member?(existing_ids, id) end)
    |> Enum.map(fn {id, params} -> Item.changeset(%Item{id: id}, params) end)
  end

  defp items_to_delete(items, shelf_state) do
    ids_on_shelf =
      shelf_state
      |> Enum.map(&elem(&1, 0))
      |> MapSet.new()

    items
    |> Enum.filter(&is_nil(&1.description))
    |> Enum.filter(&(!MapSet.member?(ids_on_shelf, &1.id)))
  end

  defp updated_items(items, shelf_state, items_to_delete) do
    now = NaiveDateTime.utc_now()

    deleted_ids =
      items_to_delete
      |> Enum.map(& &1.id)
      |> MapSet.new()

    items
    |> Enum.filter(&(!MapSet.member?(deleted_ids, &1.id)))
    |> Enum.map(&update_item(&1, Map.get(shelf_state, &1.id), now))
  end

  defp update_item(item, state, now) do
    import Ecto.Changeset

    params =
      if state do
        Map.merge(state, %{missing_since: nil})
      else
        %{missing_since: now}
      end

    Item.changeset(item, params)
  end
end
