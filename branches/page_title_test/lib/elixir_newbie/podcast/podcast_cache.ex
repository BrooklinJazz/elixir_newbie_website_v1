defmodule ElixirNewbie.PodcastCache do
  @moduledoc """
  Client Interface Functions for Podcast.
  Handles Caching and Hydrating Podcast Episodes.
  """
  use GenServer
  require Logger

  alias ElixirNewbie.PodcastAPI

  @update_interval 1000 * 60 * 60

  def start_link(opts) do
    server_name = Access.get(opts, :name, __MODULE__)
    init_state = Access.get(opts, :state_override, %{})
    GenServer.start_link(__MODULE__, init_state, name: server_name)
  end

  def init(init_state) do
    :timer.send_interval(@update_interval, self(), :update)
    {:ok, Map.merge(update_cache(), init_state)}
  end

  defp update_cache(previous_state \\ %{}) do
    case PodcastAPI.feed() do
      {:ok, feed} ->
        %{feed_info: Map.delete(feed, :episodes), episodes: feed.episodes}

      _ ->
        Logger.error("Cache Failed To Update")
        previous_state
    end
  end

  def all_episodes(server) do
    GenServer.call(server, {:episodes})
  end

  def feed_info(server \\ __MODULE__) do
    GenServer.call(server, {:feed_info})
  end

  def handle_call({:episodes}, _from, state) do
    {:reply, state.episodes, state}
  end

  def handle_call({:feed_info}, _from, state) do
    {:reply, state.feed_info, state}
  end

  def handle_info(:update, state) do
    {:noreply, update_cache(state)}
  end
end
