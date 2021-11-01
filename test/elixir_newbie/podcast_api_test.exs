defmodule ElixirNewbie.PodcastAPITest do
  use ExUnit.Case
  alias ElixirNewbie.PodcastAPI
  alias ElixirNewbie.PodcastEpisode

  @tag :prod
  test "get" do
    assert [%PodcastEpisode{} | _] = PodcastAPI.get()
  end
end
