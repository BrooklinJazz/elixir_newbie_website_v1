defmodule ElixirNewbie.TwitterTest do
  use ExUnit.Case, async: true
  alias ElixirNewbie.Twitter

  test "get/0" do
    assert [
             %{
               "id" => tweet_id,
               "text" => _,
               "created_at" => _,
               "tweet_url" => tweet_url,
               "author" => %{
                 "id" => _,
                 "username" => username,
                 "name" => _,
                 "profile_image_url" => _,
                 "author_url" => author_url
               }
             }
             | _
           ] = Twitter.get()

    assert author_url == "https://twitter.com/#{username}"
    assert tweet_url == "https://twitter.com/#{username}/status/#{tweet_id}"
  end
end
