defmodule ElixirNewbieWeb.PageController do
  use ElixirNewbieWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
