defmodule ElixirNewbie.Repo do
  use Ecto.Repo,
    otp_app: :elixir_newbie,
    adapter: Ecto.Adapters.Postgres
end
