defmodule ElixirNewbieWeb.ComingSoonLive do
  @moduledoc """
  Coming Soon Component used only in production to block access to the site.
  """
  use Surface.LiveView
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~F"""

    <section class="flex flex-col items-center justify-center w-screen h-screen bg-black">
    <img class="w-1/5 animate-pulse" src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/brand.png")}/>
    <h1 class="text-4xl text-white animate-pulse">coming soon!</h1>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
