defmodule Shop.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :image, :string
      add :product, :string
      add :price, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
