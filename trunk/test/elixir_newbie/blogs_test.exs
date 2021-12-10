defmodule ElixirNewbie.BlogsTest do
  @moduledoc """
  Blogs Test
  """
  use ExUnit.Case

  import Mox

  alias ElixirNewbie.Post
  alias ElixirNewbie.Blogs

  setup :set_mox_from_context
  setup :verify_on_exit!

  describe "Blogs" do
    test "all _ caches response" do
      {:ok, cache} = Blogs.start_link(name: :all)
      assert [%Post{}] == Blogs.all(cache)
      assert [%Post{}] == Blogs.all(cache)
    end

    test "all _ filters by title" do
      {:ok, cache} = Blogs.start_link(name: :all)
      assert [%Post{}] == Blogs.all(cache)
      assert [%Post{}] == Blogs.all(cache)
    end

    test "all _ API raises error" do

      {:ok, cache} = Blogs.start_link(name: :all)
      assert [%Post{}] == Blogs.all(cache)
      Process.send(cache, :hydrate, [])
      assert [%Post{}] == Blogs.all(cache)
    end

    test "hydrate _ blog post added" do
      ElixirNewbie.MockBlogAPI
      |> expect(:all, fn -> [%Post{}] end)
      |> expect(:all, fn -> [%Post{}, %Post{}] end)

      {:ok, cache} = Blogs.start_link(name: :all)
      assert [%Post{}] == Blogs.all(cache)
      assert [%Post{}] == Blogs.all(cache)
      Process.send(cache, :hydrate, [])
      assert [%Post{}, %Post{}] == Blogs.all(cache)
    end

    test "hydrate _ title changed" do
      ElixirNewbie.MockBlogAPI
      |> expect(:all, fn -> [%Post{title: "original"}] end)
      |> expect(:all, fn -> [%Post{title: "updated"}] end)

      {:ok, cache} = Blogs.start_link(name: :all)
      assert [%Post{title: "original"}] == Blogs.all(cache)
      assert [%Post{title: "original"}] == Blogs.all(cache)
      Process.send(cache, :hydrate, [])
      assert [%Post{title: "updated"}] == Blogs.all(cache)
    end
  end
end
