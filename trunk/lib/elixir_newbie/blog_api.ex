defmodule ElixirNewbie.BlogAPI do
  @moduledoc """
  API for retrieving Blogs.
  """
  @callback all() :: [ElixirNewbie.Post]

  def all, do: impl().all()
  defp impl, do: Application.get_env(:elixir_newbie, :blog_api, ElixirNewbie.DevToAPI)
end

defmodule ElixirNewbie.DevToAPI do
  @moduledoc """
  Fetches Data from the DevToApi.
  Should Never Be Used Directly, only through the BlogAPI module
  """
  alias ElixirNewbie.Post
  @feed_url "https://dev.to/api/articles/me/published"

  def all do
    get_json()
    |> Enum.map(&Post.cast/1)
    |> Enum.filter(& &1.published)
  end

  defp get_json do
    api_key = Application.fetch_env!(:elixir_newbie, :blog_api_key)

    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           HTTPoison.get(@feed_url, [{"api-key", api_key}]),
         {:ok, blog_posts} <- JSON.decode(body) do
      blog_posts
    end
  end
end
