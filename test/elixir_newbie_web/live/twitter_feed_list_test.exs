defmodule ElixirNewbieWeb.TwitterFeedListTest do
  use ElixirNewbieWeb.ConnCase, async: true

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  import Mox

  alias ElixirNewbie.TwitterClientFixtures
  alias ElixirNewbieWeb.TwitterFeedList

  describe "Twitter Feed" do
    test "mount - page title shows in browser tab", %{conn: conn} do
      expect(TwitterBehaviourMock, :search_by_hashtag, 2, fn args ->
        assert args == "ElixirNewbie"

        []
      end)

      conn = get(conn, "http://localhost:4000/twitter")
      assert conn.assigns.page_title =~ "Twitter Feed"
    end

    test "render tweet cards when tweets are found", %{conn: conn} do
      expect(TwitterBehaviourMock, :search_by_hashtag, 2, fn args ->
        assert args == "ElixirNewbie"

        TwitterClientFixtures.valid_tweets()
      end)

      {:ok, _view, html} = live(conn, Routes.live_path(ElixirNewbieWeb.Endpoint, TwitterFeedList))

      valid_tweets = TwitterClientFixtures.valid_tweets()

      Enum.each(valid_tweets.data, fn tweet ->
        assert html =~ "tweetcard_#{tweet.id}"
      end)
    end

    test "shows a message when no tweets are found", %{conn: conn} do
      expect(TwitterBehaviourMock, :search_by_hashtag, 2, fn args ->
        assert args == "ElixirNewbie"

        []
      end)

      {:ok, _view, html} = live(conn, Routes.live_path(ElixirNewbieWeb.Endpoint, TwitterFeedList))

      assert html =~ "No tweets found!"
    end
  end
end
