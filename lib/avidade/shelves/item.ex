defmodule Avidade.Shelves.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @permitted_params ~w(missing_since image_url description good_until)

  @primary_key false
  schema "items" do
    field(:id, :string, primary_key: true)
    field(:good_until, :date)
    field(:missing_since, :naive_datetime)
    field(:description, :string)
    field(:image_url, :string)
    belongs_to(:shelf, Avidade.Shelves.Shelf, primary_key: true)
  end

  def changeset(item, params) do
    item
    |> cast(params, @permitted_params)
  end
end
