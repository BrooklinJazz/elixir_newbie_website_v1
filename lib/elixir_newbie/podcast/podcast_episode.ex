defmodule ElixirNewbie.PodcastEpisode do
  @moduledoc """
  Podcast Episode
  """
  @enforce_keys [
    :title,
    :description,
    :audio_url,
    :artwork_url,
    :published_at,
    :duration,
    :season_number,
    :episode_number
  ]

  defstruct @enforce_keys ++ []
end
