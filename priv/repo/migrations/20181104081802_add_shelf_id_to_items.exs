defmodule Avidade.Repo.Migrations.AddShelfIdToItems do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add(:shelf_id, references(:shelves))
    end
  end
end
