defmodule ElixirNewbie.BlogCacheTest do
  use ExUnit.Case
  alias ElixirNewbie.BlogCache
  alias ElixirNewbie.BlogPost
  import Mox
  setup :set_mox_from_context
  setup :verify_on_exit!

  describe "BlogCache" do
    test "get only calls API once" do
      ElixirNewbie.MockBlogAPI
      |> expect(:get, fn -> [%BlogPost{}] end)

      {:ok, cache} = BlogCache.start_link(name: :get)
      assert [%BlogPost{}] == BlogCache.get(cache)
      assert [%BlogPost{}] == BlogCache.get(cache)
    end

    test "get - API raises error" do
      ElixirNewbie.MockBlogAPI
      |> expect(:get, fn -> [%BlogPost{}] end)
      |> expect(:get, fn -> raise "API ERROR" end)

      {:ok, cache} = BlogCache.start_link(name: :get)
      assert [%BlogPost{}] == BlogCache.get(cache)
      Process.send(cache, :hydrate, [])
      assert [%BlogPost{}] == BlogCache.get(cache)
    end

    test "hydrate _ blog post added" do
      ElixirNewbie.MockBlogAPI
      |> expect(:get, fn -> [%BlogPost{}] end)
      |> expect(:get, fn -> [%BlogPost{}, %BlogPost{}] end)

      {:ok, cache} = BlogCache.start_link(name: :get)
      assert [%BlogPost{}] == BlogCache.get(cache)
      assert [%BlogPost{}] == BlogCache.get(cache)
      Process.send(cache, :hydrate, [])
      assert [%BlogPost{}, %BlogPost{}] == BlogCache.get(cache)
    end

    test "hydrate _ title changed" do
      ElixirNewbie.MockBlogAPI
      |> expect(:get, fn -> [%BlogPost{title: "original"}] end)
      |> expect(:get, fn -> [%BlogPost{title: "updated"}] end)

      {:ok, cache} = BlogCache.start_link(name: :get)
      assert [%BlogPost{title: "original"}] == BlogCache.get(cache)
      assert [%BlogPost{title: "original"}] == BlogCache.get(cache)
      Process.send(cache, :hydrate, [])
      assert [%BlogPost{title: "updated"}] == BlogCache.get(cache)
    end
  end
end
