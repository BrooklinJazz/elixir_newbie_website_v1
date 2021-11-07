defmodule ElixirNewbieWeb.PodcastLive do
  use Surface.LiveView
  alias ElixirNewbieWeb.Components.{Page, Feed}
  alias ElixirNewbie.PodcastAPI
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  data(months, :list,
    default: [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ]
  )

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <Feed>
      <:items>
        <h2 class={
          "pb-4 pl-4 text-3xl text-white border-b-2 border-solid sm:pt-8 md:pt-0 border-primary sm:hidden md:block "
          <> "hidden md:block"
        }>Podcast Episodes</h2>
        {#for episode <- @episodes}
          <article
          :on-click={"set-active-episode"}
          phx-value-episode-number={episode.episode_number}
          class={
            "w-full h-20 flex pl-4 items-center border-b-2 border-solid border-secondary cursor-pointer text-white "
            <> "border-secondary duration-300 ease-in-out hover:border-b-8 hover:text-secondary "
            <> "#{episode.title === @active_episode.title && "md:border-secondary md:border-b-8 md:text-secondary"} "
            <> "#{@selected_podcast_on_mobile && "hidden md:flex"} "
            }>
            <h3 class="text-xl">{episode.title}</h3>
          </article>
        {/for}
      </:items>
      <:active_item>
        <article
          class={
            "p-4 text-white bg-surface "
            <> "#{!@selected_podcast_on_mobile && "hidden md:block"} "
          }>
          <h2 class="pb-4 text-3xl text-white">{@active_episode.title}</h2>
          <figure class="podcast-description">
          {raw(@active_episode.description)}
          </figure>
          <audio class="w-full my-4" controls>
            <source src={@active_episode.audio_url} type="audio/mpeg">
            Your browser does not support the audio element.
          </audio>
          <p>{Enum.at(@months, @active_episode.published_at.month)} {@active_episode.published_at.day} {@active_episode.published_at.year}</p>
        </article>
      </:active_item>
      </Feed>
    </Page>
    """
  end

  def handle_event("set-active-episode", %{"episode-number" => episode_number}, socket) do
    {:noreply,
     push_patch(socket,
       to:
         Routes.live_path(socket, ElixirNewbieWeb.PodcastLive,
           episode: String.to_integer(episode_number)
         )
     )}
  end

  def handle_params(%{"episode" => episode}, _url, socket) do
    %{episodes: episodes} = socket.assigns

    {:noreply,
     assign(socket,
       selected_podcast_on_mobile: true,
       active_episode: Enum.at(episodes, -String.to_integer(episode))
     )}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def mount(%{"episode" => episode_number}, _session, socket) do
    episodes = PodcastAPI.get()

    {:ok,
     assign(socket,
       episodes: episodes,
       selected_podcast_on_mobile: true,
       active_episode:
         Enum.find(episodes, &(&1.episode_number === String.to_integer(episode_number))),
       loading: !connected?(socket)
     )}
  end

  def mount(_params, _session, socket) do
    episodes = PodcastAPI.get()

    {:ok,
     assign(socket,
       selected_podcast_on_mobile: false,
       episodes: episodes,
       active_episode: List.first(episodes),
       loading: !connected?(socket)
     )}
  end
end
