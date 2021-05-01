defmodule Gardening.Repo.Migrations.CreatePlants do
  use Ecto.Migration

  def change do
    create table(:plants) do
      add :name, :string
      add :min_temp_f, :integer
      add :max_temp_f, :integer
      add :days_germinate, :integer
      add :days_transplant, :integer
      add :days_first_harvest, :integer
      add :days_last_harvest, :integer
      add :zone, :integer
      add :height_inches, :integer
      add :spread_inches, :integer
      add :min_acidity_ph, :integer
      add :max_acidity_ph, :integer
      add :sunlight_id, references(:sunlight, on_delete: :nothing)

      timestamps()
    end

    create index(:plants, [:sunlight_id])
  end
end
