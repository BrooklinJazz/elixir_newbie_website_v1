defmodule ElixirNewbieWeb.Live.Home.Podcast do
  use Surface.LiveComponent
  alias ElixirNewbieWeb.Components.IconButton
  alias ElixirNewbieWeb.Components.Paragraph
  alias ElixirNewbieWeb.Components.ResponsiveLayout
  alias ElixirNewbieWeb.Components.SubTitle
  alias ElixirNewbieWeb.Components.Title
  alias ElixirNewbieWeb.PodcastList
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~F"""
      <ResponsiveLayout scroll_id="podcast" cols={2}>
        <article>
          <Title>Elixir Newbie</Title>
          <SubTitle>Podcast</SubTitle>
          <img class={"md:w-3/4 mt-12"} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/sound_wave_crop.png")}/>
          <Paragraph>A podcast about entering the Elixir industry. I document and share my experience to help other developers adopt Elixir.</Paragraph>
          <Paragraph>Elixir Newbie focuses on helping aspiring developers, beginner developers, and developers with a non-elixir background adopt Elixir.</Paragraph>
        </article>
        <article class="lg:flex lg:flex-col lg:items-end">
          <img class={"m-auto lg:m-0 w-3/4"} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/magic_microphone.png")}/>
          <IconButton click="to_podcast" class="mt-12" rounded={true} icon={:right_arrow}>All Episodes</IconButton>
        </article>
      </ResponsiveLayout>
    """
  end

  def handle_event("to_podcast", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, PodcastList))}
  end
end
