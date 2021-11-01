defmodule ElixirNewbieWeb.PodcastLive do
  use Surface.LiveView
  alias ElixirNewbieWeb.Components.{Page, Feed}
  alias ElixirNewbie.PodcastAPI
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  data months, :list,
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

  def render(assigns) do
    ~F"""
    <Page>
      <Feed>
      <:items>
        {#for episode <- @episodes}
          <article
          :on-click={"set-active-episode"}
          phx-value-title={episode.title}
          class={
            "w-full h-20 flex pl-4 items-center border-b-2 border-solid border-primary cursor-pointer "
            <> "transition duration-300 ease-in-out hover:bg-primary "
            <> "#{episode.title === @active_episode.title && "bg-primary"} "
            }>
            <h3 class="text-xl text-white">{episode.title}</h3>
          </article>
        {/for}
      </:items>
      <:active_item>
        <article class="p-4 text-white bg-surface">
          <h2 class="pb-4 text-3xl text-white">{@active_episode.title}</h2>
          {raw(@active_episode.description)}
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

  def handle_event("set-active-episode", %{"title" => title}, socket) do
    %{episodes: episodes} = socket.assigns
    episode = Enum.find_index(episodes, fn each -> each.title === title end)

    {:noreply,
     push_patch(socket,
       to: Routes.live_path(socket, ElixirNewbieWeb.PodcastLive, episode: episode)
     )}
  end

  def handle_params(%{"episode" => episode}, _url, socket) do
    %{episodes: episodes} = socket.assigns
    {:noreply, assign(socket, active_episode: Enum.at(episodes, -String.to_integer(episode)))}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def mount(%{"episode" => episode}, _session, socket) do
    episodes = PodcastAPI.get()

    {:ok,
     assign(socket,
       episodes: episodes,
       active_episode: Enum.at(episodes, -String.to_integer(episode))
     )}
  end

  def mount(_params, _session, socket) do
    episodes = PodcastAPI.get()

    {:ok, assign(socket, episodes: episodes, active_episode: List.first(episodes))}
  end
end
