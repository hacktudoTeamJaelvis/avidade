defmodule Avidade.Repo.Migrations.CreateItemsTable do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add(:id, :string, primary_key: true)
      add(:good_until, :date)
      add(:missing_since, :naive_datetime)
      add(:description, :text)
      add(:image_url, :text)
    end
  end
end
