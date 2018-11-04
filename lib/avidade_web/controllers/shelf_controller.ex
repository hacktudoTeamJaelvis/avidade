defmodule AvidadeWeb.ShelfController do
  use AvidadeWeb, :controller

  def update(conn, %{"id" => raw_id}) do
    case Integer.parse(raw_id) do
      {id, ""} ->
        parsed_params = parse_params(conn.body_params)
        Avidade.Shelves.update_shelf(id, parsed_params)

        json(conn, %{status: :ok})

      _ ->
        resp(conn, 400, "")
    end
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
