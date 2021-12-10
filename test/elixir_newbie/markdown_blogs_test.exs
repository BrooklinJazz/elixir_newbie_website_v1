defmodule ElixirNewbie.MarkdownBlogsTest do
  use ExUnit.Case
  alias ElixirNewbie.MarkdownBlogs
  alias ElixirNewbie.Post

  describe "MarkdownBlogs" do
    test "all" do
      date = Date.from_iso8601!("2021-12-01")

      assert %Post{
               title: "Template",
               subtitle: "Subtitle",
               description: "Description",
               published: false,
               published_at: ^date,
               cover_image: nil,
               tags: ["elixir", "phoenix", "testing"],
               markdown: _
             } =
               MarkdownBlogs.all()
               |> Enum.find(fn each -> each.title === "Template" end)
    end
  end
end
