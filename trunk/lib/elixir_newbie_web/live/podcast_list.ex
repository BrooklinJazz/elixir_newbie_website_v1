defmodule ElixirNewbieWeb.PodcastList do
  @moduledoc """
  Display Podcast Episodes
  """
  use Surface.LiveView

  alias ElixirNewbie.Podcast
  alias ElixirNewbieWeb.PodcastShow
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Live.Components.Title
  alias ElixirNewbieWeb.Live.Components.Icon
  alias ElixirNewbieWeb.Live.Components.ResponsiveLayout
  alias ElixirNewbieWeb.Live.Home.Footer
  alias Surface.Components.LiveRedirect
  alias ElixirNewbieWeb.Live.Components.IconButton
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Phoenix.PubSub
  @topic "update episodes"

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
    <ResponsiveLayout gap="small" cols={2}>
      <article class="animate-fade-in">
        <Title>Listen to the Elixir Newbie Podcast</Title>
        <img class={"animate-fade-in md:w-3/4 my-12"} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/sound_wave_crop.png")}/>
        <IconButton hook="ScrollTo" value={"all_episodes"} rounded={true} icon={:down_arrow}>Episodes Below</IconButton>
      </article>
      <article class="flex flex-col text-white">
        <LiveRedirect to={Routes.live_path(ElixirNewbieWeb.Endpoint, PodcastShow, @latest_episode.season_number, @latest_episode.episode_number)}>
        <Title class="text-2xl italic">Latest Episode</Title>
        <Title class="mb-8">{@latest_episode.title}</Title>
        </LiveRedirect>
        <figure class="leading-loose text-md podcast-description">{raw @latest_episode.description}</figure>
        <figure class="flex py-6">
          <Icon icon={:calendar}/>
          <p class="ml-2 text-white">{Calendar.strftime(@latest_episode.published_at, "%B %d %Y")}</p>
          <p class="ml-12 text-white">Season {@latest_episode.season_number}</p>
          <Icon class="ml-12" icon={:clock}/>
          <p class="ml-2 text-white">{div @latest_episode.duration, 60}:{rem @latest_episode.duration, 60}</p>
        </figure>
        <figure>
          <audio class="w-full my-4" controls>
            <source src={@latest_episode.audio_url} type="audio/mpeg">
            Your browser does not support the audio element.
          </audio>
        </figure>
      </article>
    </ResponsiveLayout>
    <ResponsiveLayout scroll_id={"all_episodes"} cols={2} spacing="full">
      {#for episode <- @episodes}
        <article class="flex flex-col text-white">
          <LiveRedirect to={Routes.live_path(ElixirNewbieWeb.Endpoint, PodcastShow, episode.season_number, episode.episode_number)}>
          <Title class="mb-8">{episode.title}</Title>
          </LiveRedirect>
          <figure class="leading-loose text-md podcast-description">{raw episode.description}</figure>
          <figure class="flex py-6 mt-auto">
            <Icon icon={:calendar}/>
            <p class="ml-2 text-white">{Calendar.strftime(episode.published_at, "%B %d %Y")}</p>
            <p class="ml-12 text-white">Season {episode.season_number}</p>
            <Icon class="ml-12" icon={:clock}/>
            <p class="ml-2 text-white">{div episode.duration, 60}:{rem episode.duration, 60}</p>
          </figure>
          <figure>
            <audio class="w-full my-4" controls>
              <source src={episode.audio_url} type="audio/mpeg">
              Your browser does not support the audio element.
            </audio>
          </figure>
        </article>
      {/for}
    </ResponsiveLayout>
    <Footer id={:footer}/>
    </Page>
    """
  end

  def mount(_params, _session, socket) do
    PubSub.subscribe(ElixirNewbie.PubSub, @topic)
    [latest_episode | episodes] = Podcast.get()

    {:ok,
     assign(socket,
       episodes: episodes,
       latest_episode: latest_episode,
       loading: !connected?(socket)
     )}
  end
end
