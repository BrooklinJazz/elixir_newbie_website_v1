defmodule ElixirNewbie.PodcastFeed do
  @moduledoc """
  Podcast Feed
  """
  @enforce_keys [:episodes, :title, :description, :image]
  defstruct @enforce_keys
end
