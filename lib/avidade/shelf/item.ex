defmodule Avidade.Shelf.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @permitted_params ~w(missing_since image_url description good_until)

  @primary_key {:id, :string, []}
  schema "items" do
    field(:good_until, :date)
    field(:missing_since, :naive_datetime)
    field(:description, :string)
    field(:image_url, :string)
  end

  def changeset(item, params) do
    item
    |> cast(params, @permitted_params)
  end
end
