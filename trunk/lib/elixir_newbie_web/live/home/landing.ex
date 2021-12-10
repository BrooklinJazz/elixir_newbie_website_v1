defmodule ElixirNewbieWeb.Live.Home.Landing do
  use Surface.LiveComponent
  alias ElixirNewbieWeb.BlogList
  alias ElixirNewbieWeb.Endpoint
  alias ElixirNewbieWeb.Live.Components.IconButton
  alias ElixirNewbieWeb.Live.Components.Title
  alias ElixirNewbieWeb.Live.Components.SubTitle
  alias ElixirNewbieWeb.Live.Components.Section
  alias ElixirNewbieWeb.PodcastLive
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Surface.Components.LiveRedirect

  def render(assigns) do
    ~F"""
    <Section>
        <article class="flex flex-col text-white animate-fade-in">
          <Title>Hi, I'm Brooklin</Title>
          <SubTitle class="mt-12">Welcome to Elixir Newbie, where I help people adopt Elixir and grow as developers</SubTitle>
          <SubTitle class="mt-6">I do this by documenting and sharing my experience in the Elixir industry</SubTitle>
          <LiveRedirect
            to={Routes.live_path(Endpoint, BlogList)}
            class={
              "text-3xl border-2 p-6 rounded-full bg-white text-black mt-8 cursor-pointer font-medium "
              <> " transition duration-500 ease-in-out transform hover:scale-105 "
            }>
              Read the Blog
          </LiveRedirect>
          <LiveRedirect
            to={Routes.live_path(Endpoint, PodcastLive)}
            class={
              "text-3xl border-2 p-6 rounded-full border-white text-white font-medium mt-8 cursor-pointer "
              <> " transition duration-500 ease-in-out transform hover:scale-105 "
            }>
            Listen to the Podcast
          </LiveRedirect>
        </article>
        <article class="flex flex-col items-center lg:items-end">
            <img
              class={
                "animage-fade-in md:w-3/4"
              }
              src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/magic_home_swirls.png")}/>
        <IconButton id="landing learn more" hook="ScrollTo" value="about" class="mt-12 lg:mt-0" rounded={true} icon={:down_arrow}>Learn More</IconButton>
        </article>
      </Section>
    """
  end
end
