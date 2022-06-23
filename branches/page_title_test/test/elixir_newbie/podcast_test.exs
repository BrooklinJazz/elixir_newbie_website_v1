defmodule ElixirNewbie.PodcastTest do
  use ExUnit.Case, async: true
  alias ElixirNewbie.Podcast
  alias ElixirNewbie.PodcastCache

  def setup_cache(state_override \\ %{}) do
    PodcastCache.start_link(
      name: System.unique_integer() |> Integer.to_string() |> String.to_atom(),
      state_override: state_override
    )
  end

  describe "Podcast" do
    test "query_episodes by season" do
      {:ok, pid} = setup_cache(%{episodes: [%{season_number: 1}, %{season_number: 2}]})
      assert [%{season_number: 1}] = Podcast.query_episodes(pid, season_number: 1)
    end

    test "query_episodes order" do
      {:ok, pid} = setup_cache()
      episodes = Podcast.query_episodes(pid)
      ascending_episodes = Podcast.query_episodes(pid, order: :asc)
      descending_episodes = Podcast.query_episodes(pid, order: :desc)

      Enum.with_index(ascending_episodes, fn episode, index ->
        assert episode.episode_number === index + 1
      end)

      Enum.with_index(descending_episodes, fn episode, index ->
        assert episode.episode_number === length(episodes) - index
      end)
    end

    test "highlighted_episodes" do
      {:ok, pid} = setup_cache()
      amount = Enum.random(1..10)
      episodes = Podcast.highlighted_episodes(pid, amount)

      assert length(episodes) === amount
    end
  end
end
