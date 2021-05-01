defmodule Gardening.PlantsTest do
  use Gardening.DataCase

  alias Gardening.Plants

  describe "plants" do
    alias Gardening.Plants.Plant

    @valid_attrs %{days_first_harvest: 42, days_germinate: 42, days_last_harvest: 42, days_transplant: 42, height_inches: 42, max_acidity_ph: 42, max_temp_f: 42, min_acidity_ph: 42, min_temp_f: 42, name: "some name", spread_inches: 42, zone: 42}
    @update_attrs %{days_first_harvest: 43, days_germinate: 43, days_last_harvest: 43, days_transplant: 43, height_inches: 43, max_acidity_ph: 43, max_temp_f: 43, min_acidity_ph: 43, min_temp_f: 43, name: "some updated name", spread_inches: 43, zone: 43}
    @invalid_attrs %{days_first_harvest: nil, days_germinate: nil, days_last_harvest: nil, days_transplant: nil, height_inches: nil, max_acidity_ph: nil, max_temp_f: nil, min_acidity_ph: nil, min_temp_f: nil, name: nil, spread_inches: nil, zone: nil}

    def plant_fixture(attrs \\ %{}) do
      {:ok, plant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Plants.create_plant()

      plant
    end

    test "list_plants/0 returns all plants" do
      plant = plant_fixture()
      assert Plants.list_plants() == [plant]
    end

    test "get_plant!/1 returns the plant with given id" do
      plant = plant_fixture()
      assert Plants.get_plant!(plant.id) == plant
    end

    test "create_plant/1 with valid data creates a plant" do
      assert {:ok, %Plant{} = plant} = Plants.create_plant(@valid_attrs)
      assert plant.days_first_harvest == 42
      assert plant.days_germinate == 42
      assert plant.days_last_harvest == 42
      assert plant.days_transplant == 42
      assert plant.height_inches == 42
      assert plant.max_acidity_ph == 42
      assert plant.max_temp_f == 42
      assert plant.min_acidity_ph == 42
      assert plant.min_temp_f == 42
      assert plant.name == "some name"
      assert plant.spread_inches == 42
      assert plant.zone == 42
    end

    test "create_plant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Plants.create_plant(@invalid_attrs)
    end

    test "update_plant/2 with valid data updates the plant" do
      plant = plant_fixture()
      assert {:ok, %Plant{} = plant} = Plants.update_plant(plant, @update_attrs)
      assert plant.days_first_harvest == 43
      assert plant.days_germinate == 43
      assert plant.days_last_harvest == 43
      assert plant.days_transplant == 43
      assert plant.height_inches == 43
      assert plant.max_acidity_ph == 43
      assert plant.max_temp_f == 43
      assert plant.min_acidity_ph == 43
      assert plant.min_temp_f == 43
      assert plant.name == "some updated name"
      assert plant.spread_inches == 43
      assert plant.zone == 43
    end

    test "update_plant/2 with invalid data returns error changeset" do
      plant = plant_fixture()
      assert {:error, %Ecto.Changeset{}} = Plants.update_plant(plant, @invalid_attrs)
      assert plant == Plants.get_plant!(plant.id)
    end

    test "delete_plant/1 deletes the plant" do
      plant = plant_fixture()
      assert {:ok, %Plant{}} = Plants.delete_plant(plant)
      assert_raise Ecto.NoResultsError, fn -> Plants.get_plant!(plant.id) end
    end

    test "change_plant/1 returns a plant changeset" do
      plant = plant_fixture()
      assert %Ecto.Changeset{} = Plants.change_plant(plant)
    end
  end
end
