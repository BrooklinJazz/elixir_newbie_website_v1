defmodule ElixirNewbieWeb.PodcastLive do
  use Surface.LiveView
  alias ElixirNewbieWeb.Components.{Page}
  alias ElixirNewbie.PodcastFeed

  def render(assigns) do
    ~F"""
    <Page>
    {#for episode <- @episodes}
      <audio controls>
        <source src={episode.audio_url} type="audio/mpeg">
        Your browser does not support the audio element.
      </audio>
    {/for}
    </Page>
    """
  end

  def mount(_params, _session, socket) do
    episodes = PodcastFeed.get()
    {:ok, assign(socket, episodes: episodes)}
  end
end
