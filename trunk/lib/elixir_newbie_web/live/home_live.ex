defmodule ElixirNewbieWeb.HomeLive do
  use Surface.LiveView
  alias ElixirNewbieWeb.Components.{Page}

  def render(assigns) do
    ~F"""
    <Page>Home Placeholder</Page>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
