defmodule Gardening.Plants.Plant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plants" do
    field :days_first_harvest, :integer
    field :days_germinate, :integer
    field :days_last_harvest, :integer
    field :days_transplant, :integer
    field :height_inches, :integer
    field :max_acidity_ph, :integer
    field :max_temp_f, :integer
    field :min_acidity_ph, :integer
    field :min_temp_f, :integer
    field :name, :string
    field :spread_inches, :integer
    field :zone, :integer
    belongs_to :sunlight, Gardening.Plants.Sunlight
    belongs_to :parent, Gardening.Plants.Plant
    has_many :children, Gardening.Plants.Plant, foreign_key: :parent_id

    timestamps()
  end

  @doc false
  def changeset(plant, attrs) do
    plant
    |> cast(attrs, [
      :name,
      :min_temp_f,
      :max_temp_f,
      :days_germinate,
      :days_transplant,
      :days_first_harvest,
      :days_last_harvest,
      :zone,
      :height_inches,
      :spread_inches,
      :min_acidity_ph,
      :max_acidity_ph,
      :sunlight_id,
      :parent_id,
    ])

    |> validate_required([:name])
  end
end
