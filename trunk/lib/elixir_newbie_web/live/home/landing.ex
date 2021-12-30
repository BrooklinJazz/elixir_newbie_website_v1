defmodule ElixirNewbieWeb.Live.Home.Landing do
  use Surface.LiveComponent
  alias ElixirNewbieWeb.BlogList
  alias ElixirNewbieWeb.Endpoint
  alias ElixirNewbieWeb.Components.IconButton
  alias ElixirNewbieWeb.Components.Title
  alias ElixirNewbieWeb.Components.SubTitle
  alias ElixirNewbieWeb.Components.ResponsiveLayout
  alias ElixirNewbieWeb.PodcastList
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Surface.Components.LiveRedirect

  def render(assigns) do
    ~F"""
      <ResponsiveLayout cols={2}>
        <article class="flex flex-col text-white">
          <Title>Hi, I'm Brooklin</Title>
          <SubTitle class="mt-12">Welcome to Elixir Newbie, where I help people adopt Elixir and grow as developers</SubTitle>
          <SubTitle class="mt-6">I do this by documenting and sharing my experience in the Elixir industry</SubTitle>
          <LiveRedirect
            to={Routes.live_path(Endpoint, BlogList)}
            class={
              "text-2xl md:text-3xl border-2 p-6 rounded-full bg-white text-black mt-8 cursor-pointer ",
                "transition duration-500 border-2 border-white ease-in-out hover:ring-2 hover:ring-white hover:ring-offset-2 hover:ring-offset-background hover:border-transparent"
              }>
              Read the Blog
              </LiveRedirect>
              <LiveRedirect
              to={Routes.live_path(Endpoint, PodcastList)}
              class={
                " text-2xl md:text-3xl p-6 rounded-full mt-8 cursor-pointer",
                "transition duration-500 hover:bg-background border-2 border-white ease-in-out hover:ring-2 hover:ring-white hover:ring-offset-2 hover:ring-offset-background hover:border-transparent"
            }>
            Hear the Podcast
          </LiveRedirect>
        </article>
        <article class="flex flex-col items-center lg:items-end animate-fade-in">
          <img class={"animate-fade-in lg:w-full w-3/4"} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/magic_home_swirls.png")}/>
          <IconButton id={:landing_learn_more} hook="ScrollOnClick" value="about" class="mt-12 lg:mt-0" rounded={true} icon={:down_arrow}>Learn More</IconButton>
        </article>
      </ResponsiveLayout>
    """
  end
end
