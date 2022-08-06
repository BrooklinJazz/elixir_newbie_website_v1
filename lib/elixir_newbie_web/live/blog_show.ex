defmodule ElixirNewbieWeb.BlogShow do
  @moduledoc """
  Display List of Blogs
  """
  use Surface.LiveView

  alias ElixirNewbie.Blog
  alias ElixirNewbie.Stats

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

    if connected?(socket), do: Stats.view(blog.id)

    {:ok,
     assign(socket,
       page_title: blog.title,
       blog: blog,
       highlighted_blogs: Blog.highlighted_posts(blog.id, 6),
       loading: !connected?(socket)
     )}
  end

  def handle_event("to_blog", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, BlogList))}
  end

  def render(assigns) do
    # <section>
    # <img class="p-1 w-20 h-20 rounded-full ring-2 ring-gray-300 dark:ring-gray-500" src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/authors/#{@blog.profile_picture}")}/>
    # <span class="float-left text-2xl text-slate-700 font-bold leading-normal mb-1">{@blog.author_name}</span>
    # <span class="float-left font-light leading-relaxed text-slate-600 mb-4"> {@blog.author_description}</span>
    # <p class="mt-2 text-gray-300 float-left  mr-2 text-slate-400 opacity-75"> {Calendar.strftime(NaiveDateTime.new!(@blog.date, Time.utc_now()), "%B %d %Y")} </p>
    # </section>

    ~F"""
    <Page loading={@loading}>
    <section class={"mx-6 my-6 leading-loose text-white max-w-full lg:mx-60 md:mx-24"}>

      <div class="flex">
        <img class="p-1 w-20 h-20 rounded-full ring-2 ring-gray-300 dark:ring-gray-500" src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/authors/#{@blog.profile_picture}")}/>
        <div class="pl-4">
          <p>{@blog.author_name}</p>
          <p>{@blog.author_description}</p>
        </div>
      </div>

      <Title class="mb-4">{@blog.title}</Title>
      <SubTitle class="mb-4 italic">{@blog.description}</SubTitle>
      <p>{Calendar.strftime(NaiveDateTime.new!(@blog.date, Time.utc_now()), "%B %d %Y")}</p>

        <img class="mb-4 rounded-2xl" src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/posts/#{@blog.cover_image}")}/>
        {#if @blog.livebook_url}
        <a href={@blog.livebook_url}>
          <img src="https://livebook.dev/badge/v1/black.svg" alt="Run in Livebook" />
        </a>
        {/if}
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
