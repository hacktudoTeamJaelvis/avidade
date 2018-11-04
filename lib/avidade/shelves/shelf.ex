defmodule Avidade.Shelves.Shelf do
  use Ecto.Schema

  schema "shelves" do
    field(:owner_name, :string)
    field(:owner_phone, :string)
    field(:lat, :float)
    field(:long, :float)
  end
end
