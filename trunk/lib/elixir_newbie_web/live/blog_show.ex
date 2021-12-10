defmodule ElixirNewbieWeb.BlogShow do
  @moduledoc """
  Display List of Blogs
  """
  use Surface.LiveView
  alias ElixirNewbie.Blog
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def mount(%{"id" => id}, _session, socket) do
    blog = Blog.get_post_by_id!(id)

    {:ok,
     assign(socket,
       blog: blog,
       loading: !connected?(socket)
     )}
  end

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <section class="mx-6 my-6 leading-loose text-white lg:mx-60 md:mx-24">
        {@blog.title}
        {raw @blog.body}
      </section>
    </Page>
    """
  end
end
