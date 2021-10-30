defmodule ElixirNewbieWeb.ComingSoonLive do
  use Surface.LiveView
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~F"""

    <section class="h-screen w-screen bg-black flex flex-col justify-center items-center">
    <img class="animate-pulse w-1/5" src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/brand.png")}/>
    <h1 class="animate-pulse text-4xl text-white">coming soon!</h1>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
