defmodule ElixirNewbie.PodcastAPI do
  @moduledoc """
  API for retrieving Podcast Episodes
  """
  alias ElixirNewbie.PodcastEpisode
  alias ElixirNewbie.PodcastFeed
  @rss_url "https://feeds.buzzsprout.com/1840381.rss"

  def all_episodes(json_feed) do
    episodes =
      json_feed.entries
      |> Enum.reverse()
      |> Enum.with_index(fn each, index ->
        %PodcastEpisode{
          title: each.title,
          description: each.description,
          duration: String.to_integer(each.itunes_duration),
          artwork_url: json_feed.image.url,
          audio_url: each.enclosure.url,
          published_at: Map.get(each, :"rss2:pubDate"),
          season_number: 1,
          episode_number: index + 1
        }
      end)

    {:ok, episodes}
  end

  def feed do
    with {:ok, %{body: xml}} <- HTTPoison.get(@rss_url),
         {:ok, json_feed} <- ElixirFeedParser.parse(xml),
         {:ok, episodes} <- all_episodes(json_feed) do
      {:ok,
       %PodcastFeed{
         title: json_feed.title,
         description: json_feed.description,
         episodes: episodes,
         image: json_feed.image.url
       }}
    end
  end

  def season_from_episode(episode_number) do
    if episode_number <= 15, do: 1, else: 2
  end
end
