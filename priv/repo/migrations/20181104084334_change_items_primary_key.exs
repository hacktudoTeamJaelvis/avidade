defmodule Avidade.Repo.Migrations.ChangeItemsPrimaryKey do
  use Ecto.Migration

  def change do
    execute("ALTER TABLE items DROP CONSTRAINT items_pkey")
    execute("ALTER TABLE items ADD PRIMARY KEY (shelf_id, id)")
  end
end
