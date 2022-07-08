defmodule ElixirNewbieWeb.Components.Navigation do
  @moduledoc """
  Navigation Header
  """
  use Surface.LiveComponent

  alias ElixirNewbieWeb.BlogList
  alias ElixirNewbieWeb.Endpoint
  alias ElixirNewbieWeb.HomeLive
  alias ElixirNewbieWeb.Components.Icon
  alias ElixirNewbieWeb.PodcastList
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Surface.Components.LiveRedirect

  def render(assigns) do
    ~F"""
    <nav class="flex flex-col w-full">
      <nav class="sticky top-0 flex w-full h-12 md:pr-12 z-[100] bg-background items-center justify-center md:justify-start">
        <img
          :on-click="home"
          class={
            "cursor-pointer h-12 hover:opacity-75",
            "transition duration-300 ease-in-out transform hover:scale-105"}
          src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/brand.png")}
        />
        <LiveRedirect
          class={
          "text-2xl text-gray-300 ml-8",
          "hidden md:block ",
          "link-underline hover:text-white"
          }
          label="Podcast"
          to={Routes.live_path(Endpoint, PodcastList)}
        />
        <LiveRedirect
          class={
          "text-2xl text-gray-300 ml-8",
          "hidden md:block ",
          "link-underline hover:text-white"
          }
          label="Blog"
          to={Routes.live_path(Endpoint, BlogList)}
        />
        <a
          href="https://twitter.com/BrooklinJMyers"
          target="_blank"
          class={
            "ml-auto mr-12 text-white",
            "transition duration-300 ease-in-out transform hover:scale-125 hover:text-twitter",
            "hidden md:block"
        }>
          <Icon icon={:twitter}/>
        </a>
        <a
          href="https://www.linkedin.com/in/brooklinmyers/"
          target="_blank"
          class={
            "text-white",
            "transition duration-300 ease-in-out transform hover:scale-125 hover:text-linkedin",
            "hidden md:block"
        }>
          <Icon icon={:linkedin}/>
        </a>
      </nav>
      <hr class="h-0.5 w-full border-0 navigation__hr bg-gradient-to-r from-primary to-secondary animate-gradient-x"/>
    </nav>
    """
  end

  def handle_event("home", _params, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(Endpoint, HomeLive))}
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
