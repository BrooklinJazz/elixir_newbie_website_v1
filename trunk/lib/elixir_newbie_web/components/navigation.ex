defmodule ElixirNewbieWeb.Components.Navigation do
  use Surface.LiveComponent
  alias Surface.Components.LiveRedirect
  alias ElixirNewbieWeb.BlogLive
  alias ElixirNewbieWeb.PodcastLive
  alias ElixirNewbieWeb.HomeLive
  alias ElixirNewbieWeb.Endpoint
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~F"""
    <nav class="navigation">
      <img
        :on-click="home"
        class={
          "navigation__brand cursor-pointer "
          <> "transition duration-300 ease-in-out transform hover:scale-110"
        }
        src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/brand.png")}/>
      <LiveRedirect
        class={
          "navigation__link navigation__link--podcast text-white"
          <> " border-primary duration-300 ease-in-out hover:border-b-4 hover:border-t-4 hover:text-secondary"
        }
        label="Podcast"
        to={Routes.live_path(Endpoint, PodcastLive)}
        />
      <LiveRedirect
        class={
          "navigation__link navigation__link--blog text-white"
          <> " border-primary duration-300 ease-in-out hover:border-b-4 hover:border-t-4 hover:text-secondary"
        }
        label="Blog"
        to={Routes.live_path(Endpoint, BlogLive)}
       />
      <a
        href="https://twitter.com/BrooklinJMyers"
        target="_blank"
        class={
          "fab fa-twitter navigation__icon navigation__icon--twitter "
          <> "transition duration-300 ease-in-out transform hover:scale-110"
          }/>
      <a
        href="https://www.linkedin.com/in/brooklinmyers/"
        target="_blank"
        class={
          "fab fa-linkedin-in navigation__icon navigation__icon--linkedin "
          <> "transition duration-300 ease-in-out transform hover:scale-110"
        }/>
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
