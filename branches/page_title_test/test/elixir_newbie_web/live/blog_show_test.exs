defmodule ElixirNewbieWeb.BlogShowTest do
  use ElixirNewbieWeb.ConnCase, async: true

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest

  alias ElixirNewbieWeb.BlogShow
  alias ElixirNewbie.Stats
  alias ElixirNewbie.Blog

  describe "BlogShow" do
    test "mount - tracks a view", %{conn: conn} do
      [post | _] = Blog.all_posts()

      {:ok, _view, html} =
        live(conn, Routes.live_path(ElixirNewbieWeb.Endpoint, BlogShow, post.id))

      html =~ post.title

      assert {:ok, %{views: 1}} = Stats.for_post(post.id)
    end

    test "mount - blog title shows in browser tab", %{conn: conn} do
      conn = get(conn, "http://localhost:4000/blog/writing-tests-in-livebook")
      assert conn.assigns.page_title == "Writing Tests in Livebook."
    end
  end
end
