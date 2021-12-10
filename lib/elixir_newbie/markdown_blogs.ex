defmodule ElixirNewbie.MarkdownBlogs do
  alias ElixirNewbie.Post

  defp display_drafts,
    do: Application.get_env(:elixir_newbie, :display_drafts, false)

  def all do
    File.ls!("priv/posts")
    |> Enum.map(&compile/1)
    |> Enum.sort_by(fn each -> each.published_at end)
    |> Enum.filter(fn each ->
      IO.inspect(display_drafts(), label: "SHOULD DISPLAY")
      display_drafts() || each.published
    end)
  end

  def compile(file) do
    [frontmatter, markdown] =
      Path.join(["priv/posts", file])
      |> File.read!()
      |> String.split(~r/\n-{3,}\n/, parts: 2)

    [parsed] = :yamerl_constr.string(frontmatter)

    Enum.reduce(parsed, %{}, fn
      {'tags', tags}, acc ->
        Map.put(acc, "tags", tags |> to_string() |> String.split(","))

      {'published_at', iso}, acc ->
        date = iso |> to_string() |> Date.from_iso8601!()
        Map.put(acc, "published_at", date)

      {key, value}, acc ->
        Map.put(acc, to_string(key), to_string(value))
    end)
    |> Map.put("markdown", markdown)
    |> Map.put("slug", String.replace(file, ~r/\.md$/, ""))
    |> Post.cast()
  end
end
