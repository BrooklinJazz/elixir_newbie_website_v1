defmodule ElixirNewbieWeb.HomeLive do
  @moduledoc """
  Home Page
  """
  use Surface.LiveView
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Live.Home.About
  alias ElixirNewbieWeb.Live.Home.Blog
  alias ElixirNewbieWeb.Live.Home.Footer
  alias ElixirNewbieWeb.Live.Home.Landing
  alias ElixirNewbieWeb.Live.Home.Podcast

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <Landing id={:landing}/>
      <About/>
      <Podcast id={:podcast}/>
      <Blog id={:blog}/>
      <Footer id={:footer} />
    </Page>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Home", loading: !connected?(socket))}
  end
end
