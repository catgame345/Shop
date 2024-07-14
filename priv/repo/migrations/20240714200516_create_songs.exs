defmodule Shop.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :name, :string
      add :image, :string

      timestamps(type: :utc_datetime)
    end
  end
end
