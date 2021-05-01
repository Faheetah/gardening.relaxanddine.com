defmodule Gardening.Repo.Migrations.CreateSunlight do
  use Ecto.Migration

  def change do
    create table(:sunlight) do
      add :type, :string
      add :description, :string

      timestamps()
    end

  end
end
