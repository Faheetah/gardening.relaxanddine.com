defmodule GardeningWeb.PlantController do
  use GardeningWeb, :controller

  alias Gardening.Plants
  alias Gardening.Plants.Plant

  def index(conn, _params) do
    plants = Plants.list_plants()
    render(conn, "index.html", plants: plants)
  end

  def new(conn, _params) do
    changeset = Plants.change_plant(%Plant{})

    sunlight = Plants.list_sunlight()
    |> Enum.map(fn s -> {s.type, s.id} end)

    render(conn, "new.html", changeset: changeset, parent: nil, sunlight: sunlight)
  end

  def create(conn, %{"plant" => plant_params}) do
    case Plants.create_plant(plant_params) do
      {:ok, plant} ->
        conn
        |> put_flash(:info, "Plant created successfully.")
        |> redirect(to: Routes.plant_path(conn, :show, plant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    plant = Plants.get_plant!(id)
    render(conn, "show.html", plant: plant)
  end

  def edit(conn, %{"id" => id}) do
    plant = Plants.get_plant!(id)
    changeset = Plants.change_plant(plant)

    sunlight = Plants.list_sunlight()
    |> Enum.map(fn s -> {s.type, s.id} end)

    sunlight = [{"", nil} | sunlight]

    parent = case plant.parent do
      nil -> ""
      p -> p.name
    end

    render(conn, "edit.html", plant: plant, changeset: changeset, parent: parent, sunlight: sunlight)
  end

  def update(conn, %{"id" => id, "plant" => plant_params}) do
    parent = Plants.get_plant_by_name(plant_params["parent"])
    plant = Plants.get_plant!(id)
    plant_params =
      case parent do
        nil ->
          plant_params
          |> Map.put("parent_id", nil)
        "" ->
          plant_params
          |> Map.put("parent_id", nil)
        _ ->
          plant_params
          |> Map.put("parent_id", parent.id)
      end
      |> IO.inspect

    case Plants.update_plant(plant, plant_params) do
      {:ok, plant} ->
        conn
        |> put_flash(:info, "Plant updated successfully.")
        |> redirect(to: Routes.plant_path(conn, :show, plant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", plant: plant, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    plant = Plants.get_plant!(id)
    {:ok, _plant} = Plants.delete_plant(plant)

    conn
    |> put_flash(:info, "Plant deleted successfully.")
    |> redirect(to: Routes.plant_path(conn, :index))
  end
end
