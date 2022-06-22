defmodule ElixirNewbie.PodcastAPITest do
  use ExUnit.Case, async: true
  alias ElixirNewbie.PodcastAPI
  alias ElixirNewbie.PodcastEpisode
  alias ElixirNewbie.PodcastFeed

  test "feed" do
    assert {:ok,
            %PodcastFeed{
              title: "Elixir Newbie",
              description: _,
              episodes: [%PodcastEpisode{} | _]
            }} = PodcastAPI.feed()
  end

  test "season_from_episode_number" do
    Enum.each(1..15, fn each ->
      assert PodcastAPI.season_from_episode(each) === 1
    end)

    assert PodcastAPI.season_from_episode(Enum.random(16..100)) === 2
  end
end
