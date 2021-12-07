defmodule ElixirNewbie.BlogsTest do
  @moduledoc """
  Blogs Test
  """
  use ExUnit.Case

  import Mox


  alias ElixirNewbie.BlogPost
  alias ElixirNewbie.Blogs

  setup :set_mox_from_context
  setup :verify_on_exit!

  describe "Blogs" do
    test "get _ called twice with no changes should only call API once" do
      ElixirNewbie.MockBlogAPI
      |> expect(:get, fn -> [%BlogPost{}] end)

      {:ok, cache} = Blogs.start_link(name: :get)
      assert [%BlogPost{}] == Blogs.get(cache)
      assert [%BlogPost{}] == Blogs.get(cache)
    end

    test "get _ API raises error" do
      ElixirNewbie.MockBlogAPI
      |> expect(:get, fn -> [%BlogPost{}] end)
      |> expect(:get, fn -> raise "API ERROR" end)

      {:ok, cache} = Blogs.start_link(name: :get)
      assert [%BlogPost{}] == Blogs.get(cache)
      Process.send(cache, :hydrate, [])
      assert [%BlogPost{}] == Blogs.get(cache)
    end

    test "hydrate _ blog post added" do
      ElixirNewbie.MockBlogAPI
      |> expect(:get, fn -> [%BlogPost{}] end)
      |> expect(:get, fn -> [%BlogPost{}, %BlogPost{}] end)

      {:ok, cache} = Blogs.start_link(name: :get)
      assert [%BlogPost{}] == Blogs.get(cache)
      assert [%BlogPost{}] == Blogs.get(cache)
      Process.send(cache, :hydrate, [])
      assert [%BlogPost{}, %BlogPost{}] == Blogs.get(cache)
    end

    test "hydrate _ title changed" do
      ElixirNewbie.MockBlogAPI
      |> expect(:get, fn -> [%BlogPost{title: "original"}] end)
      |> expect(:get, fn -> [%BlogPost{title: "updated"}] end)

      {:ok, cache} = Blogs.start_link(name: :get)
      assert [%BlogPost{title: "original"}] == Blogs.get(cache)
      assert [%BlogPost{title: "original"}] == Blogs.get(cache)
      Process.send(cache, :hydrate, [])
      assert [%BlogPost{title: "updated"}] == Blogs.get(cache)
    end
  end
end
