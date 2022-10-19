defmodule ElixirNewbie.TwitterFeed do
  @moduledoc """
    A module to retrieve Tweets from Twitter in a friendly format for a feed.
  """
  alias ElixirNewbie.TwitterFeed.TwitterClientImpl
  alias ElixirNewbie.TwitterFeed.Tweet

  @default_hashtag "ElixirNewbie"

  @doc """
    Retrive last week tweets using #ElixirNewbie hashtag.

    Returns a list of Tweet struct for an empty list if no tweets are found.
  """
  def get_tweets() do
    twitter_client_impl().search_by_hashtag(@default_hashtag)
    |> to_tweets()
  end

  defp twitter_client_impl(),
    do: Application.get_env(:elixir_newbie, :twitter_client, TwitterClientImpl)

  defp to_tweets(%{data: tweets, includes: %{users: users}}) do
    Enum.map(tweets, fn tweet ->
      author = find_author(users, tweet.author_id)

      %Tweet{
        id: tweet.id,
        text: tweet.text,
        created_at: parse_date_from_iso8601(tweet.created_at),
        author_username: author.username,
        author_name: author.name,
        author_image: author.profile_image_url,
        author_verified: author.verified
      }
    end)
  end

  defp to_tweets(_), do: []

  defp find_author(users, author_id) do
    Enum.find(users, fn user ->
      user.id == author_id
    end)
  end

  defp parse_date_from_iso8601(date_iso) do
    {:ok, datetime, 0} = DateTime.from_iso8601(date_iso)
    datetime
  end
end
