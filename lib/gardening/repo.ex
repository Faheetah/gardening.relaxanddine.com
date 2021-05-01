defmodule Gardening.Repo do
  use Ecto.Repo,
    otp_app: :gardening,
    adapter: Ecto.Adapters.Postgres
end
