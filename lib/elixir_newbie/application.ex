defmodule ElixirNewbie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ElixirNewbie.Repo,
      # Start the Telemetry supervisor
      ElixirNewbieWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ElixirNewbie.PubSub},
      # Start the Endpoint (http/https)
      ElixirNewbieWeb.Endpoint,
      # Start a worker by calling: ElixirNewbie.Worker.start_link(arg)
      {ElixirNewbie.BlogCache, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirNewbie.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirNewbieWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end