defmodule Gardening.Plants.Sunlight do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sunlight" do
    field :description, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(sunlight, attrs) do
    sunlight
    |> cast(attrs, [:type, :description])
    |> validate_required([:type, :description])
  end
end
