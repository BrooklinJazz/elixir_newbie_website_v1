defmodule ElixirNewbieWeb.Live.Home.Landing do
  use Surface.Component
  alias ElixirNewbieWeb.BlogLive
  alias ElixirNewbieWeb.Endpoint
  alias ElixirNewbieWeb.Live.Components.IconButton
  alias ElixirNewbieWeb.PodcastLive
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Surface.Components.LiveRedirect

  def render(assigns) do
    ~F"""
      <section class="grid pt-24 sm:grid-cols-1 lg:grid-cols-2 sm:grid-rows-2 lg:grid-rows-1 gap-y-24 xl:px-60 sm:px-8 md:px-12">
        <article class="flex flex-col text-white animate-fade-in">
          <h1 class="text-5xl">Hi, I'm Brooklin</h1>
          <h2 class="mt-8 text-4xl leading-relaxed ">I help people adopt Elixir and grow as developers</h2>
          <h2 class="mt-8 text-4xl leading-relaxed">by documenting and sharing my experience in the Elixir industry</h2>
          <LiveRedirect
            to={Routes.live_path(Endpoint, BlogLive)}
            class={
              "text-4xl border-2 p-8 rounded-full bg-white text-black mt-8 cursor-pointer font-medium "
              <> " transition duration-500 ease-in-out transform hover:scale-105 "
            }>
              Read the Blog
          </LiveRedirect>
          <LiveRedirect
            to={Routes.live_path(Endpoint, PodcastLive)}
            class={
              "text-4xl border-2 p-8 rounded-full border-white text-white font-medium mt-8 cursor-pointer "
              <> " transition duration-500 ease-in-out transform hover:scale-105 "
            }>
            Listen to the Podcast
          </LiveRedirect>
        </article>
        <article class="flex flex-col items-center">
            <img
              class={
                "animage-fade-in md:w-3/4"
              }
              src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/magic_home_swirls.png")}/>
        <IconButton rounded={true} icon={:down_arrow}>Learn More</IconButton>
        </article>
      </section>
    """
  end
end
