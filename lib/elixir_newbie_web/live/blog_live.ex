defmodule ElixirNewbieWeb.BlogLive do
  use Surface.LiveView
  alias ElixirNewbieWeb.Components.{Page, Feed}
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias ElixirNewbie.Blogs
  alias Phoenix.PubSub

  @topic "update blogs"

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <Feed>
        <:items>
        <h2 class={
          "pb-4 pl-4 text-3xl text-white border-b-2 border-solid sm:pt-8 md:pt-0 border-primary "
          <> "hidden md:flex "
        } >Blog Posts</h2>
        {#for blog <- @blogs}
          <article
            :on-click={"set-active-blog"}
            phx-value-title={blog.title}
            class={
            "w-full h-20 flex pl-4 items-center border-b-2 border-solid border-primary cursor-pointer text-white "
            <> "border-secondary duration-300 ease-in-out hover:border-b-8 hover:text-secondary "
            <> "#{blog.title === @active_blog.title && "md:border-secondary md:border-b-8 md:text-secondary"} "
            <> "#{@selected_blog_on_mobile && "hidden md:flex"} "
            }>
            <h3 class="text-xl text-white">{blog.title}</h3>
          </article>
        {/for}
        </:items>
        <:active_item>
          <article class={
          "p-4 text-white bg-surface "
          <> "#{!@selected_blog_on_mobile && "hidden md:block"} "
          }>
          <h2 class="pb-4 text-3xl text-white">{@active_blog.title}</h2>
          <figure class="markdown">
            <img src={@active_blog.cover_image}/>
            {Blogs.as_highlighted_html(@active_blog)}
          </figure>
          </article>
        </:active_item>
      </Feed>
    </Page>
    """
  end

  def handle_event("set-active-blog", %{"title" => title}, socket) do
    {:noreply,
     push_patch(socket,
       to: Routes.live_path(socket, ElixirNewbieWeb.BlogLive, title: title)
     )}
  end

  def handle_params(%{"title" => title}, _url, socket) do
    %{blogs: blogs} = socket.assigns

    {:noreply,
     assign(socket,
       selected_blog_on_mobile: true,
       active_blog: Enum.find(blogs, &(&1.title === title))
     )}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def mount(%{"title" => title}, _session, socket) do
    PubSub.subscribe(ElixirNewbie.PubSub, @topic)
    blogs = Blogs.get()

    {:ok,
     assign(socket,
       blogs: blogs,
       selected_blog_on_mobile: true,
       active_blog: Enum.find(blogs, &(&1.title === title)),
       loading: !connected?(socket)
     )}
  end

  def mount(_params, _session, socket) do
    PubSub.subscribe(ElixirNewbie.PubSub, @topic)
    blogs = Blogs.get()

    {:ok,
     assign(socket,
       blogs: blogs,
       selected_blog_on_mobile: false,
       active_blog: List.first(blogs),
       loading: !connected?(socket)
     )}
  end

  def handle_info({:update_blogs, blogs}, socket),
    do: {:noreply, assign(socket, blogs: blogs)}
end
