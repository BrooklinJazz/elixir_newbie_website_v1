defmodule ElixirNewbieWeb.HomeLive do
  @moduledoc """
  Home Page
  """
  use Surface.LiveView
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Live.Home.Landing
  alias ElixirNewbieWeb.Live.Home.About

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <Landing/>
      <About/>
    </Page>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, loading: !connected?(socket))}
  end
end
