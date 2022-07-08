defmodule ElixirNewbie.PodcastCacheTest do
  use ExUnit.Case, async: true
  alias ElixirNewbie.PodcastCache
  alias ElixirNewbie.PodcastFeed
  alias ElixirNewbie.PodcastEpisode

  def setup_cache(state_override \\ %{}) do
    PodcastCache.start_link(
      name: System.unique_integer() |> Integer.to_string() |> String.to_atom(),
      state_override: state_override
    )
  end

  describe "PodcastCache" do
    test "feed_info" do
      {:ok, pid} = setup_cache()

      assert %PodcastFeed{
               title: "Elixir Newbie",
               description: _
             } = PodcastCache.feed_info(pid)
    end

    test "all_episodes" do
      {:ok, pid} = setup_cache()
      assert [%PodcastEpisode{} = episode | _] = PodcastCache.all_episodes(pid)

      Enum.each(Map.from_struct(episode), fn {key, value} ->
        assert value, "#{key} is nil"
      end)
    end
  end
end
