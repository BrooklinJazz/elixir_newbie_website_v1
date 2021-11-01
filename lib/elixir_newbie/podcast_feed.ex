defmodule ElixirNewbie.PodcastAPI do
  alias ElixirNewbie.PodcastEpisode
  @feed_url "https://www.buzzsprout.com/api/1840381/episodes.json"
  def get do
    token = Application.fetch_env!(:elixir_newbie, :rss_token)

    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           HTTPoison.get(
             @feed_url,
             Authorization: "Bearer #{token}",
             "Content-Type": "application/json"
           ),
         {:ok, episodes} <- JSON.decode(body) do
      episodes
      |> Enum.map(&PodcastEpisode.cast/1)
      |> Enum.filter(&(DateTime.compare(&1.published_at, DateTime.utc_now()) === :lt))
    end
  end
end
