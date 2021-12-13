defmodule ElixirNewbieWeb.BlogShow do
  @moduledoc """
  Display List of Blogs
  """
  use Surface.LiveView
  alias ElixirNewbie.Blog
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Components.Title
  alias ElixirNewbieWeb.BlogList
  alias ElixirNewbieWeb.Components.BlogCard
  alias ElixirNewbieWeb.Components.CardContainer
  alias ElixirNewbieWeb.Components.IconButton
  alias ElixirNewbieWeb.Live.Home.Footer
  alias ElixirNewbieWeb.Components.SubTitle
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def mount(%{"id" => id}, _session, socket) do
    blog = Blog.get_post_by_id!(id)

    {:ok,
     assign(socket,
       blog: blog,
       highlighted_blogs: Enum.take(Blog.all_posts(), 6),
       loading: !connected?(socket)
     )}
  end

  def handle_event("to_blog", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, BlogList))}
  end

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <section class={"mx-6 my-6 leading-loose text-white max-w-full lg:mx-60 md:mx-24"}>
        <Title>{@blog.title}</Title>
        <SubTitle class="italic">{@blog.description}</SubTitle>
        <img class="mt-4 rounded-2xl" src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/posts/#{@blog.cover_image}")}/>
        <figure class="makeup-blog">
        {raw @blog.body}
        </figure>
      </section>
      <section class={"my-24"}>
        <CardContainer>
          {#for blog <- @highlighted_blogs}
            <BlogCard blog={blog}/>
          {/for}
        </CardContainer>
        <IconButton click="to_blog" class="mt-12 ml-16" rounded={true} icon={:left_arrow}>Back to All Blogs</IconButton>
      </section>
      <Footer id={:footer}/>
    </Page>
    """
  end
end
