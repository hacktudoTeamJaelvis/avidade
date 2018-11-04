defmodule Avidade.Repo.Migrations.CreateShelvesTable do
  use Ecto.Migration

  def change do
    create table(:shelves) do
      add(:owner_name, :string)
      add(:owner_phone, :string)
      add(:lat, :float)
      add(:long, :float)
    end
  end
end
