defmodule ElixirNewbie.BlogTest do
  use ExUnit.Case, async: true
  alias ElixirNewbie.Blog
  alias ElixirNewbie.Blog.Post

  describe "Blog" do
    test "all_posts/0" do
      all_posts = Blog.all_posts()
      assert Enum.any?(all_posts)

      Enum.each(all_posts, fn each ->
        assert %Post{} = each
        assert each.title
        assert each.description
        assert each.date
        assert Enum.any?(each.tags)
      end)
    end
  end
end
