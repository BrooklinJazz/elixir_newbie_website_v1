defmodule ElixirNewbie.Twitter do
  @token Application.fetch_env!(:elixir_newbie, :twitter_api_key)
  @tweets_url "https://api.twitter.com/2/tweets/search/recent?query=has%3Ahashtags%20%23ElixirNewbie&tweet.fields=created_at,author_id"
  def get_tweets() do
    tweets = authorized_get(@tweets_url)

    Enum.map(tweets, fn %{"id" => id, "author_id" => author_id} = tweet ->
      author = get_author(author_id)

      tweet
      |> Map.put("author", author)
      |> Map.put("tweet_url", "https://twitter.com/#{author["username"]}/status/#{id}")
    end)
  end

  def get_author(author_id) do
    author =
      authorized_get(
        "https://api.twitter.com/2/users/#{author_id}?user.fields=profile_image_url,username"
      )

    Map.put(author, "author_url", "https://twitter.com/#{author["username"]}")
  end

  defp authorized_get(url) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(url, Authorization: "Bearer #{@token}")

    {:ok, %{"data" => data}} = JSON.decode(body)

    data
  end
end
