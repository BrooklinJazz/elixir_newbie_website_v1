defmodule ElixirNewbie.BlogAPI do
  @callback get() :: [ElixirNewbie.BlogPost]

  def get(), do: impl().get()
  defp impl, do: Application.get_env(:elixir_newbie, :blog_api, ElixirNewbie.DevToAPI)
end

defmodule ElixirNewbie.DevToAPI do
  alias ElixirNewbie.BlogPost
  @feed_url "https://dev.to/api/articles/me/published"

  def get do
    get_json()
    |> Enum.map(&BlogPost.cast/1)
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
