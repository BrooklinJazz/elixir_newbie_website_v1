defmodule ElixirNewbieWeb.BlogShow do
  @moduledoc """
  Display List of Blogs
  """
  use Surface.LiveView
  alias ElixirNewbie.Blog
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Live.Components.Title
  alias ElixirNewbieWeb.Live.Components.SubTitle
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
      <section class={"mx-6 my-6 leading-loose text-white max-w-full lg:mx-60 md:mx-24"}>
        <Title>{@blog.title}</Title>
        <SubTitle class="italic">{@blog.description}</SubTitle>
        <img class="mt-4 rounded-2xl" src={@blog.cover_image}/>
        <figure class="makeup-blog">
        {raw @blog.body}
        </figure>
      </section>
    </Page>
    """
  end
end
