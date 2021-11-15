defmodule ElixirNewbie.Blogs do
  @moduledoc """
  Client Interface Functions for retrieving blogs.
  Handles Caching and Hydrating Blogs.
  """
  use GenServer

  alias ElixirNewbie.BlogAPI
  alias ElixirNewbie.Syntax
  alias Phoenix.HTML

  @hydrate_interval 1000 * 60 * 5

  def get(server \\ __MODULE__) do
    GenServer.call(server, {:get})
  end

  def as_highlighted_html(blog) do
    blog.body_markdown |> Earmark.as_html!() |> Syntax.highlight() |> HTML.raw()
  end

  def start_link(opts) do
    server_name = Access.get(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, [], name: server_name)
  end

  def init(_args) do
    :timer.send_interval(@hydrate_interval, self(), :hydrate)
    {:ok, %{blogs: BlogAPI.get()}}
  end

  def handle_call({:get}, _from, state) do
    {:reply, state.blogs, state}
  end

  def handle_info(:hydrate, state) do
    blogs =
      try do
        BlogAPI.get()
      rescue
        RuntimeError -> state.blogs
      end

    if state.blogs == blogs do
      {:noreply, state}
    else
      Phoenix.PubSub.broadcast(
        ElixirNewbie.PubSub,
        "update blogs",
        {:update_blogs, blogs}
      )

      {:noreply, %{state | blogs: blogs}}
    end
  end
end
