defmodule ElixirNewbieWeb.BlogLive do
  use Surface.LiveView
  alias ElixirNewbieWeb.Components.{Page, Feed}
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias ElixirNewbie.Blogs
  alias Phoenix.PubSub

  @topic "update blogs"

  def render(assigns) do
    ~F"""
    <Page>
      <Feed>
        <:items>
        <h2 class="pb-4 pl-4 text-3xl text-white border-b-2 border-solid border-primary">All Blog Posts</h2>
        {#for blog <- @blogs}
          <article
            :on-click={"set-active-blog"}
            phx-value-title={blog.title}
            class={
            "w-full h-20 flex justify-center items-center border-b-2 border-solid border-primary "
            <> "transition duration-300 ease-in-out hover:bg-primary "
            <> "#{blog.title === @active_blog.title && "bg-primary"}"
            }>
            <h3 class="text-xl text-white">{blog.title}</h3>
          </article>
        {/for}
        </:items>
        <:active_item>
          <article class="p-4 markdown bg-surface">
            <h2 class="pb-4">{@active_blog.title}</h2>
            <img src={@active_blog.cover_image}/>
            {Blogs.as_highlighted_html(@active_blog)}
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
    {:noreply, assign(socket, active_blog: Enum.find(blogs, &(&1.title === title)))}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def mount(%{"title" => title}, _session, socket) do
    PubSub.subscribe(ElixirNewbie.PubSub, @topic)
    blogs = Blogs.get()
    {:ok, assign(socket, blogs: blogs, active_blog: Enum.find(blogs, &(&1.title === title)))}
  end

  def mount(_params, _session, socket) do
    PubSub.subscribe(ElixirNewbie.PubSub, @topic)
    blogs = Blogs.get()
    {:ok, assign(socket, blogs: blogs, active_blog: List.first(blogs))}
  end

  def handle_info({:update_blogs, blogs}, socket),
    do: {:noreply, assign(socket, blogs: blogs)}
end
