defmodule ElixirNewbie.PodcastEpisode do
  @moduledoc """
  Podcast Episode Schema for casting Podcast API data into structs
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "podcast_episode" do
    field :title, :string
    field :description, :string
    field :audio_url, :string
    field :artwork_url, :string
    field :published_at, :utc_datetime
    field :duration, :integer
    field :season_number, :integer
    field :episode_number, :integer
    field :total_plays, :integer
  end

  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, [
      :title,
      :description,
      :audio_url,
      :artwork_url,
      :published_at,
      :duration,
      :season_number,
      :episode_number,
      :total_plays
    ])
  end

  def cast(params \\ %{}) do
    params |> changeset() |> apply_changes()
  end
end
