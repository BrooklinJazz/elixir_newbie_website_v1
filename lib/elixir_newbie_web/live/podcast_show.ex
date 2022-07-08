defmodule ElixirNewbieWeb.PodcastShow do
  @moduledoc """
  Display Podcast Episodes
  """
  use Surface.LiveView

  alias ElixirNewbie.Podcast
  alias ElixirNewbie.PodcastCache

  alias ElixirNewbieWeb.PodcastShow
  alias ElixirNewbieWeb.PodcastList
  alias ElixirNewbieWeb.Live.Home.Footer
  alias ElixirNewbieWeb.Components.ResponsiveLayout
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Components.Title
  alias ElixirNewbieWeb.Components.Icon
  alias ElixirNewbieWeb.Components.IconButton
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Phoenix.PubSub
  @topic "update episodes"

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <ResponsiveLayout>
        <IconButton click="to_podcast" rounded={true} icon={:left_arrow}>Back To Episodes</IconButton>
        <article class="flex flex-col text-white">
          <Title class="mb-8">{@episode.title}</Title>
          <figure class="leading-loose text-md podcast-description">{raw @episode.description}</figure>
          <figure class="flex py-6">
            <Icon icon={:calendar}/>
            <p class="ml-2 text-white">{Calendar.strftime(@episode.published_at, "%B %d %Y")}</p>
            <p class="ml-4 text-white md:ml-12">Season {@episode.season_number}</p>
            <Icon class="ml-12" icon={:clock}/>
            <p class="ml-2 text-white">{div @episode.duration, 60}:{rem @episode.duration, 60}</p>
          </figure>
          <figure>
            <audio class="w-full my-4" controls>
              <source src={@episode.audio_url} type="audio/mpeg">
              Your browser does not support the audio element.
            </audio>
          </figure>
          <figure class="grid grid-cols-2 mt-6">

            <IconButton click="previous" rounded={true} icon={:left_arrow}>Previous</IconButton>
            <IconButton click="next" reverse={true} rounded={true} icon={:right_arrow}>Next</IconButton>
          </figure>
        </article>
      </ResponsiveLayout>
      <Footer id={:footer}/>
    </Page>
    """
  end

  def handle_event("to_podcast", _params, socket) do
    {:noreply,
     push_redirect(socket,
       to:
         Routes.live_path(
           ElixirNewbieWeb.Endpoint,
           PodcastList
         )
     )}
  end

  def handle_event("previous", _params, socket) do
    %{previous_episode: previous_episode} = socket.assigns

    {:noreply,
     push_redirect(socket,
       to:
         Routes.live_path(
           ElixirNewbieWeb.Endpoint,
           PodcastShow,
           previous_episode.season_number,
           previous_episode.episode_number
         )
     )}
  end

  def handle_event("next", _params, socket) do
    %{next_episode: next_episode} = socket.assigns

    {:noreply,
     push_redirect(socket,
       to:
         Routes.live_path(
           ElixirNewbieWeb.Endpoint,
           PodcastShow,
           next_episode.season_number,
           next_episode.episode_number
         )
     )}
  end

  def mount(
        %{"season_number" => season_number, "episode_number" => episode_number},
        _session,
        socket
      ) do
    PubSub.subscribe(ElixirNewbie.PubSub, @topic)

    [first_episode | _] = episodes = Podcast.query_episodes(PodcastCache, order: :asc)
    [last_episode] = Enum.take(episodes, -1)

    current_episode_index =
      episodes
      |> Enum.find_index(fn each ->
        each.season_number === String.to_integer(season_number) &&
          each.episode_number === String.to_integer(episode_number)
      end)

    current_episode = Enum.at(episodes, current_episode_index)
    previous_episode = Enum.at(episodes, current_episode_index - 1) || last_episode
    next_episode = Enum.at(episodes, current_episode_index + 1) || first_episode

    {:ok,
     assign(socket,
       page_title: current_episode.title,
       episode: current_episode,
       previous_episode: previous_episode,
       next_episode: next_episode,
       loading: !connected?(socket)
     )}
  end
end
