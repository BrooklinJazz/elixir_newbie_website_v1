defmodule ElixirNewbieWeb.Components.Footer do
  @moduledoc """
  Footer component
  """
  use Surface.LiveComponent
  alias ElixirNewbieWeb.BlogList
  alias ElixirNewbieWeb.Endpoint
  alias ElixirNewbieWeb.HomeLive
  alias ElixirNewbieWeb.PodcastList
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~F"""
    <nav class="sticky bottom-0 flex flex-col md:hidden">
        <hr class="h-0.5 w-full border-0 navigation__hr bg-gradient-to-r from-primary to-secondary animate-gradient-x"/>
        <nav class="flex items-center justify-around text-white bg-background">
        <button :on-click="home" class="p-6">
          <i class="fas fa-home"/>
          <p>Home</p>
        </button>
        <button :on-click="blog" class="p-6">
          <i class="fas fa-blog"></i>
          <p>Blog</p>
        </button>
        <button :on-click="podcast" class="p-6">
          <i class="fas fa-podcast"></i>
          <p>Podcast</p>
        </button>
      </nav>
    </nav>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("home", _params, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(Endpoint, HomeLive))}
  end

  def handle_event("blog", _params, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(Endpoint, BlogList))}
  end

  def handle_event("podcast", _params, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(Endpoint, PodcastList))}
  end
end
