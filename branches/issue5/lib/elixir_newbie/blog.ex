defmodule ElixirNewbie.Blog do
  alias ElixirNewbie.Blog.Post

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:elixir_newbie, "priv/posts/**/*.md"),
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  defp posts_and_drafts, do: @posts

  def all_posts(filters \\ []) do
    Enum.reduce(filters, posts_and_drafts(), fn
      {:search, value}, acc ->
        Enum.filter(acc, fn post ->
          String.contains?(String.downcase(post.title), String.downcase(value))
        end)

      {:selected_tags, []}, acc ->
        acc

      {:selected_tags, tags}, acc ->
        Enum.filter(acc, fn post -> common_in_list?(tags, post.tags) end)

      _, acc ->
        acc
    end)
    |> Enum.filter(fn each ->
      Date.compare(each.date, Date.utc_today()) in [:lt, :eq]
    end)
  end

  def common_in_list?(list_a, list_b) do
    Enum.any?(list_a, fn each -> each in list_b end)
  end

  def highlighted_posts(amount) do
    all_posts()
    |> Enum.take(amount)
  end

  def highlighted_posts(related_article_id, amount) do
    all_posts()
    |> Enum.reject(&(&1.id === related_article_id))
    |> Enum.take(amount)
  end

  def all_tags, do: @tags

  def get_post_by_id!(id) do
    Enum.find(all_posts(), &(&1.id == id)) ||
      raise NotFoundError, "post with id=#{id} not found"
  end
end
