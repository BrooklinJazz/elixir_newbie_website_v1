defmodule ElixirNewbie.Twitter do
  @hashtag_elixir_newbie_url "https://api.twitter.com/2/tweets/search/recent?query=has%3Ahashtags%20%23ElixirNewbie&tweet.fields=created_at,author_id"
  def get() do
    token = Application.fetch_env!(:elixir_newbie, :twitter_api_key)

    {:ok, response} = HTTPoison.get(@hashtag_elixir_newbie_url, Authorization: "Bearer #{token}")

    %HTTPoison.Response{body: body} = response
    {:ok, map} = JSON.decode(body)

    %{"data" => tweets} = map

    Enum.map(tweets, fn %{"id" => id, "author_id" => author_id} = tweet ->
      author = get_author(author_id)

      Map.put(tweet, "author", author)
      |> Map.put("tweet_url", "https://twitter.com/#{author["username"]}/status/#{id}")
    end)
  end

  def get_author(author_id) do
    token = Application.fetch_env!(:elixir_newbie, :twitter_api_key)

    {:ok, response} =
      HTTPoison.get(
        "https://api.twitter.com/2/users/#{author_id}?user.fields=profile_image_url,username",
        Authorization: "Bearer #{token}"
      )

    %HTTPoison.Response{body: body} = response
    {:ok, map} = JSON.decode(body)
    %{"data" => author} = map
    %{"username" => username} = author
    Map.put(author, "author_url", "https://twitter.com/#{username}")
  end
end
