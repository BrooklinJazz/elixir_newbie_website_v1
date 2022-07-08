defmodule ElixirNewbieWeb.PodcastList do
  @moduledoc """
  Display Podcast Episodes
  """
  use Surface.LiveView

  alias ElixirNewbie.Podcast
  alias ElixirNewbie.PodcastCache
  alias ElixirNewbieWeb.PodcastShow
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Components.Title
  alias ElixirNewbieWeb.Components.Icon
  alias ElixirNewbieWeb.Components.ResponsiveLayout
  alias ElixirNewbieWeb.Live.Home.Footer
  alias Surface.Components.LiveRedirect
  alias Surface.Components.Link
  alias ElixirNewbieWeb.Components.IconButton
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Phoenix.PubSub
  @topic "update episodes"

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
    <ResponsiveLayout gap="small" cols={2}>
     <article class="md:animate-fade-in">
       <Title>Listen to the Elixir Newbie Podcast</Title>
       <img class={"md:animate-fade-in w-3/4 my-12"} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/sound_wave_crop.png")}/>
       <IconButton id={:podcast_list_to_all_episodes} hook="ScrollOnClick" value={"all_episodes"} rounded={true} icon={:down_arrow}>Episodes Below</IconButton>
     </article>
     <article class="flex flex-col">
       <LiveRedirect to={Routes.live_path(ElixirNewbieWeb.Endpoint, PodcastShow, @latest_episode.season_number, @latest_episode.episode_number)}>
       <Title class="text-2xl italic">Latest Episode</Title>
       <p class="text-4xl leading-relaxed underline text-secondary">{@latest_episode.title}</p>
       </LiveRedirect>
       <figure class="leading-loose text-white podcast-description">{raw @latest_episode.description}</figure>
       <figure class="flex flex-col py-6 text-white md:flex-row">
          <p class="text-white md:ml-2">Season {@latest_episode.season_number}</p>
          <div class="flex mt-2 md:mt-0 md:ml-6">
            <Icon icon={:calendar}/>
            <p class="ml-2 text-white">{Calendar.strftime(@latest_episode.published_at, "%B %d %Y")}</p>
          </div>
          <div class="flex mt-2 md:mt-0 md:ml-6">
            <Icon class="" icon={:clock}/>
            <p class="ml-2 text-white">{div @latest_episode.duration, 60}:{rem @latest_episode.duration, 60}</p>
          </div>
       </figure>
       <figure>
         <audio class="w-full my-4" controls>
           <source src={@latest_episode.audio_url} type="audio/mpeg">
           Your browser does not support the audio element.
         </audio>
       </figure>
     </article>
     <article class="flex-wrap col-span-1 lg:col-span-2">
       <p class="text-white text-medium">Listen on your favorite platform</p>
       <figure class="flex flex-col flex-wrap justify-between my-6 lg:flex-row">
         <Link opts={target: "_blank"} to="https://podcasts.apple.com/us/podcast/elixir-newbie/id1587455457">
           <IconButton class="mt-8" rounded={true} icon={:apple}>Apple Podcasts</IconButton>
         </Link>
         <Link opts={target: "_blank"} to="https://podcasts.google.com/feed/aHR0cHM6Ly9mZWVkcy5idXp6c3Byb3V0LmNvbS8xODQwMzgxLnJzcw==">
           <IconButton class="mt-8" rounded={true} icon={:google}>Google Podcasts</IconButton>
         </Link>
         <Link opts={target: "_blank"} to="https://open.spotify.com/show/2VNf2tvHIjSxTXMY15qtdV">
           <IconButton class="mt-8" rounded={true} icon={:spotify}>Spotify</IconButton>
         </Link>
         <Link opts={target: "_blank"} to="https://feeds.buzzsprout.com/1840381.rss">
           <IconButton class="mt-8" rounded={true} icon={:rss}>RSS</IconButton>
         </Link>
       </figure>
     </article>
    </ResponsiveLayout>
    <ResponsiveLayout class="mt-24" gap="none" scroll_id={"all_episodes"} cols={1} spacing="full">
      <figure class="flex flex-col mb-12 md:items-center md:justify-between md:flex-row">
        {#for season <- @seasons}
          <p
            :on-click="select_season"
            phx-value-season={season}
            class={"mr-8 lg:mb-0 text-4xl cursor-pointer",
            "text-gray-200": season !== @season_number,
            "text-secondary": @season_number === season}>
            Season {season}
          </p>
        {/for}
        <button class="flex items-center justify-start mt-4 text-2xl text-white md:mt-0 md:justify-end lg:flex-none" :on-click="toggle_order">
        {#case @order}
          {#match :desc}
            Showing newest first
            <Icon class="ml-6 text-medium" icon={:chevron_down}/>
          {#match :asc}
            Showing oldest first
            <Icon class="ml-6 text-medium" icon={:chevron_up}/>
        {/case}
        </button>
      </figure>
      <hr/>
      {#for episode <- @episodes}
      <LiveRedirect class={"flex flex-col py-6", "transition duration-300 ease-in-out transform hover:bg-primary/[0.2]"} to={Routes.live_path(ElixirNewbieWeb.Endpoint, PodcastShow, episode.season_number, episode.episode_number)}>
        <article class="flex items-center">
          <img class="w-16 mr-8 rounded-lg" src={episode.artwork_url}/>
          <p class="text-2xl text-white">{episode.title}</p>
          <p class="ml-auto text-white">{format_episode_duration(episode.duration)}</p>
        </article>
      </LiveRedirect>
      <hr/>
      {/for}
    </ResponsiveLayout>
    <Footer id={:footer}/>
    </Page>
    """
  end

  def mount(_params, _session, socket) do
    PubSub.subscribe(ElixirNewbie.PubSub, @topic)
    episodes = Podcast.query_episodes(PodcastCache, order: :desc)
    seasons = Podcast.season_numbers(PodcastCache)

    {:ok,
     assign(socket,
       episodes: episodes,
       seasons: seasons,
       page_title: "Podcast",
       season_number: 1,
       order: :desc,
       latest_episode: hd(episodes),
       loading: !connected?(socket)
     )}
  end

  def handle_event("toggle_order", _params, socket) do
    order = if socket.assigns.order === :desc, do: :asc, else: :desc

    {:noreply, assign(socket, order: order) |> load_episodes()}
  end

  def handle_event("select_season", %{"season" => season_number}, socket) do
    season_number = String.to_integer(season_number)

    {:noreply, assign(socket, season_number: season_number) |> load_episodes()}
  end

  def load_episodes(socket) do
    %{season_number: season_number, order: order} = socket.assigns

    assign(
      socket,
      :episodes,
      Podcast.query_episodes(PodcastCache, season_number: season_number, order: order)
    )
  end

  defp format_episode_duration(episode_duration) do
    minutes = div(episode_duration, 60)
    seconds = String.pad_leading("#{rem(episode_duration, 60)}", 2, "0")
    "#{minutes}:#{seconds}"
  end

end
