defmodule ElixirNewbieWeb.PodcastShowTest do
  use ElixirNewbieWeb.ConnCase, async: true

  test "mount - podcast title shows in browser tab", %{conn: conn} do
    conn = get(conn, "http://localhost:4000/podcast/1/17")
    assert conn.assigns.page_title == "Ep 17: Phoenix Deployment Handbook w/ Jack Gray"
  end
end
