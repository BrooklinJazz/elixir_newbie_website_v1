defmodule ElixirNewbie.TwitterFeedTest do
  use ExUnit.Case
  doctest ElixirNewbie.TwitterFeed
  import Mox
  alias ElixirNewbie.TwitterFeed
  alias ElixirNewbie.TwitterClientFixtures
  alias ElixirNewbie.TwitterFeed.Tweet

  describe "get_tweets/0" do
  end

  test "returns an empty list when no tweets are found" do
    expect(TwitterBehaviourMock, :search_by_hashtag, fn args ->
      assert args == "ElixirNewbie"

      %{}
    end)

    assert [] = TwitterFeed.get_tweets()
  end

  test "returns a list of Tweet struct" do
    expect(TwitterBehaviourMock, :search_by_hashtag, fn args ->
      assert args == "ElixirNewbie"

      TwitterClientFixtures.valid_tweets()
    end)

    TwitterFeed.get_tweets()
    |> Enum.each(fn x ->
      assert %Tweet{} = x
    end)
  end
end
