defmodule GardeningWeb.PlantControllerTest do
  use GardeningWeb.ConnCase

  alias Gardening.Plants

  @create_attrs %{days_first_harvest: 42, days_germinate: 42, days_last_harvest: 42, days_transplant: 42, height_inches: 42, max_acidity_ph: 42, max_temp_f: 42, min_acidity_ph: 42, min_temp_f: 42, name: "some name", spread_inches: 42, zone: 42}
  @update_attrs %{days_first_harvest: 43, days_germinate: 43, days_last_harvest: 43, days_transplant: 43, height_inches: 43, max_acidity_ph: 43, max_temp_f: 43, min_acidity_ph: 43, min_temp_f: 43, name: "some updated name", spread_inches: 43, zone: 43}
  @invalid_attrs %{days_first_harvest: nil, days_germinate: nil, days_last_harvest: nil, days_transplant: nil, height_inches: nil, max_acidity_ph: nil, max_temp_f: nil, min_acidity_ph: nil, min_temp_f: nil, name: nil, spread_inches: nil, zone: nil}

  def fixture(:plant) do
    {:ok, plant} = Plants.create_plant(@create_attrs)
    plant
  end

  describe "index" do
    test "lists all plants", %{conn: conn} do
      conn = get(conn, Routes.plant_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Plants"
    end
  end

  describe "new plant" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.plant_path(conn, :new))
      assert html_response(conn, 200) =~ "New Plant"
    end
  end

  describe "create plant" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.plant_path(conn, :create), plant: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.plant_path(conn, :show, id)

      conn = get(conn, Routes.plant_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Plant"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.plant_path(conn, :create), plant: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Plant"
    end
  end

  describe "edit plant" do
    setup [:create_plant]

    test "renders form for editing chosen plant", %{conn: conn, plant: plant} do
      conn = get(conn, Routes.plant_path(conn, :edit, plant))
      assert html_response(conn, 200) =~ "Edit Plant"
    end
  end

  describe "update plant" do
    setup [:create_plant]

    test "redirects when data is valid", %{conn: conn, plant: plant} do
      conn = put(conn, Routes.plant_path(conn, :update, plant), plant: @update_attrs)
      assert redirected_to(conn) == Routes.plant_path(conn, :show, plant)

      conn = get(conn, Routes.plant_path(conn, :show, plant))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, plant: plant} do
      conn = put(conn, Routes.plant_path(conn, :update, plant), plant: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Plant"
    end
  end

  describe "delete plant" do
    setup [:create_plant]

    test "deletes chosen plant", %{conn: conn, plant: plant} do
      conn = delete(conn, Routes.plant_path(conn, :delete, plant))
      assert redirected_to(conn) == Routes.plant_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.plant_path(conn, :show, plant))
      end
    end
  end

  defp create_plant(_) do
    plant = fixture(:plant)
    %{plant: plant}
  end
end
