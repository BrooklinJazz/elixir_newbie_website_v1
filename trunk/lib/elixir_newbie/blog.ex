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

  def all_posts, do: @posts

  def all_posts(filters) do
    Enum.reduce(filters, all_posts(), fn
      {:search, value}, acc ->
        Enum.filter(acc, fn post ->
          String.contains?(String.downcase(post.title), String.downcase(value))
        end)

      {:selected_tags, []}, acc ->
        acc

      {:selected_tags, tags}, acc ->
        Enum.filter(acc, fn post -> Enum.any?(post.tags, fn tag -> tag in tags end) end)

      _, acc ->
        acc
    end)
  end

  def all_tags, do: @tags

  def get_post_by_id!(id) do
    Enum.find(all_posts(), &(&1.id == id)) ||
      raise NotFoundError, "post with id=#{id} not found"
  end
end
