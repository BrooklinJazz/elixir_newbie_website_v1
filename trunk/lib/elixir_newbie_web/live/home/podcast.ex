defmodule ElixirNewbieWeb.Live.Home.Podcast do
  use Surface.LiveComponent
  alias ElixirNewbieWeb.Live.Components.IconButton
  alias ElixirNewbieWeb.Live.Components.Paragraph
  alias ElixirNewbieWeb.Live.Components.Section
  alias ElixirNewbieWeb.Live.Components.SubTitle
  alias ElixirNewbieWeb.Live.Components.Title
  alias ElixirNewbieWeb.PodcastLive
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~F"""
      <Section scroll_id="podcast">
        <article>
          <Title>Elixir Newbie</Title>
          <SubTitle>Podcast</SubTitle>
          <img class={"animage-fade-in md:w-3/4 mt-12"} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/sound_wave_crop.png")}/>
          <Paragraph>A podcast about entering the Elixir industry. I document and share my experience to help other developers adopt Elixir.</Paragraph>
          <Paragraph>Elixir Newbie focuses on helping aspiring developers, beginner developers, and developers with a non-elixir background adopt Elixir.</Paragraph>
        </article>
        <article class="lg:flex lg:flex-col lg:items-end">
          <img class={"animage-fade-in w-1/2 m-auto lg:m-0 md:w-3/5"} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/magic_microphone.png")}/>
          <IconButton click="to_podcast" class="mt-12" rounded={true} icon={:right_arrow}>All Episodes</IconButton>
        </article>
      </Section>
    """
  end

  def handle_event("to_podcast", _, socket) do
    # TODO this cannot push_patch because the given path does not point to the current root.
    # likely could solve this by moving this handle event to Home Live, but that muddies up the code.
    # leaving this as a redirect for now.
    {:noreply, redirect(socket, to: Routes.live_path(socket, PodcastLive))}
  end
end
