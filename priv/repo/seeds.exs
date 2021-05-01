# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Gardening.Repo.insert!(%Gardening.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

[
  %{type: "full sun", description: "At least six hours of direct sunlight per day"},
  %{type: "dappled sun", description: "A mix of direct and indirect sunlight consistently throughout the day"},
  %{type: "partial shade", description: "Three to six hours of direct sunlight per day"},
  %{type: "full shade", description: "Less than three hours of direct sunlight per day"},
]
|> Enum.each(fn attrs ->
  %Gardening.Plants.Sunlight{}
  |> Gardening.Plants.Sunlight.changeset(attrs)
  |> Gardening.Repo.insert!()
end)
