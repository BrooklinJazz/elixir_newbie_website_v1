defmodule ElixirNewbie.Podcast do
  alias ElixirNewbie.PodcastCache

  def query_episodes(cache, filters \\ []) do
    episodes = PodcastCache.all_episodes(cache)

    Enum.reduce(filters, episodes, fn
      {:season_number, season_number}, acc ->
        Enum.filter(acc, &(&1.season_number === season_number))

      {:order, order}, acc ->
        Enum.sort_by(acc, & &1.episode_number, order)
    end)
  end

  def highlighted_episodes(cache, amount \\ 5) do
    PodcastCache.all_episodes(cache) |> Enum.take(amount)
  end

  def season_numbers(cache) do
    PodcastCache.all_episodes(cache)
    |> Enum.map(& &1.season_number)
    |> Enum.uniq()
  end
end
