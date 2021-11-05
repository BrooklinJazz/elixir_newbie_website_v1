defmodule ElixirNewbieWeb.HomeLive do
  use Surface.LiveView
  alias ElixirNewbieWeb.Components.{Page}
  # https://gist.github.com/BrooklinJazz/86b7ca1cd58db2012ca0f1c3a4aabd39.js
  def render(assigns) do
    ~F"""
    <Page>Home Placeholder</Page>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
