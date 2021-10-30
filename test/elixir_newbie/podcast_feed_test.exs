defmodule ElixirNewbie.PodcastFeedTest do
  use ExUnit.Case
  alias ElixirNewbie.PodcastFeed
  alias ElixirNewbie.PodcastEpisode

  @tag :prod
  test "get" do
    assert [%PodcastEpisode{} | _] = PodcastFeed.get()
  end
end
