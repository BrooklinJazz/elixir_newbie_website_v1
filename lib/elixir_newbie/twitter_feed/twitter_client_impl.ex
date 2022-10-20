defmodule ElixirNewbie.TwitterFeed.TwitterClientImpl do
  @moduledoc """
    Http Client for retrieving tweets from Twitter API.
  """
  alias HTTPoison
  alias Jason
  @behaviour ElixirNewbie.TwitterFeed.TwitterClientBehaviour

  @twitter_base_url Application.get_env(:elixir_newbie, TwitterClientImpl)[:twitter_base_url]
  @bearer_token Application.get_env(:elixir_newbie, TwitterClientImpl)[:bearer_token]

  @doc """
    Search recent tweets using a specified hashtag.
  """
  @impl ElixirNewbie.TwitterFeed.TwitterClientBehaviour
  def search_by_hashtag(hashtag) do
    HTTPoison.get(build_search_by_hashtag_url(hashtag), Authorization: "Bearer #{@bearer_token}")
    |> handle_response()
  end

  defp build_search_by_hashtag_url(hashtag) do
    search_recent_path =
      Application.get_env(:elixir_newbie, TwitterClientImpl)[:search_recent_path]

    search_fields = Application.get_env(:elixir_newbie, TwitterClientImpl)[:search_recent_fields]

    "#{@twitter_base_url}#{search_recent_path}%23#{hashtag}#{search_fields}"
  end

  defp handle_response({:ok, response}), do: Jason.decode!(response.body, keys: :atoms)

  defp handle_response(_), do: %{}
end
