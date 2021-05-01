defmodule GardeningWeb.PageController do
  use GardeningWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
