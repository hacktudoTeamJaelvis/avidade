defmodule AvidadeWeb.ShelfController do
  use AvidadeWeb, :controller

  def update(conn, params) do
    params
    |> parse_params()
    |> Avidade.Shelf.update_shelf()

    json(conn, %{status: :ok})
  end

  defp parse_params(params) do
    params
    |> Enum.map(fn {k, v} -> {k, parse_item_state(v)} end)
    |> Enum.into(%{})
  end

  defp parse_item_state(params) do
    %{image_url: Map.get(params, "image_url")}
  end
end
