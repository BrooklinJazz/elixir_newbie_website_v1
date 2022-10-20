defmodule ElixirNewbie.TwitterFeed.TwitterClientBehaviour do
  @moduledoc """
    Define a set of functions that communicates with Twitter.
  """
  alias ElixirNewbie.TwitterFeed.Tweet

  @doc """
    Search recent tweets using a specified hashtag.
  """
  @callback search_by_hashtag(String.t()) :: [%Tweet{}]
end
