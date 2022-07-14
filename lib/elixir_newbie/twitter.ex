defmodule ElixirNewbie.Twitter do
  @hashtag_elixir_newbie_url "https://api.twitter.com/2/tweets/search/recent?query=has%3Ahashtags%20%23ElixirNewbie&tweet.fields=created_at,author_id"
  def get() do
    token = Application.fetch_env!(:elixir_newbie, :twitter_api_key)

    {:ok, response} = HTTPoison.get(@hashtag_elixir_newbie_url, Authorization: "Bearer #{token}")
    %HTTPoison.Response{body: body} = response
    {:ok, map} = JSON.decode(body)
    %{"data" => data} = map
    data
  end

  def get_author(author_id) do
    token = Application.fetch_env!(:elixir_newbie, :twitter_api_key)

    {:ok, response} =
      HTTPoison.get("https://api.twitter.com/2/users/#{author_id}",
        Authorization: "Bearer #{token}"
      )

    %HTTPoison.Response{body: body} = response
    {:ok, map} = JSON.decode(body)
    %{"data" => data} = map
    data
  end
end
