defmodule ElixirNewbieWeb.BlogLive do
  use Surface.LiveView
  alias ElixirNewbieWeb.Components.{Page}
  alias ElixirNewbie.{BlogCache, Syntax}
  import Phoenix.HTML, only: [raw: 1]
  # require Makeup.Styles.HTML.StyleMap
  # alias Makeup.Styles.HTML.StyleMap
  # StyleMap.abap_style()
  alias Phoenix.PubSub
  @topic "update blogs"
  def render(assigns) do
    ~F"""
    <Page>
    <section class="blogs">
      <section class="blog-index">
        <h2 class="text-3xl text-white pb-4 pl-4 border-b-2 border-solid border-primary">All Blog Posts</h2>
        {#for blog <- @blogs}
          <article
            :on-click={"set_active_blog"}
            phx-value-title={blog.title}
            class={
            "w-full h-20 flex justify-center items-center border-b-2 border-solid border-primary "
            <> "transition duration-300 ease-in-out hover:bg-primary "
            <> "#{blog.title === @active_blog.title && "bg-primary"}"
            }>
            <h3 class="text-xl text-white">{blog.title}</h3>
          </article>
        {/for}
      </section>
      <section class="blog-list">
        <div class="blog">
          <h2>{@active_blog.title}</h2>
          {@active_blog.body_html}
        </div>
      </section>
    </section>
    </Page>
    """
  end

  def handle_event("set_active_blog", %{"title" => title}, socket) do
    %{blogs: blogs} = socket.assigns

    {:noreply,
     assign(socket,
       active_blog: Enum.find(blogs, fn each -> each.title === title end)
     )}
  end

  def blogs_to_html(blogs) do
    Enum.map(blogs, fn each ->
      Map.put(
        each,
        :body_html,
        each.body_markdown |> Earmark.as_html!() |> Syntax.highlight() |> raw
      )
    end)
  end

  def mount(_params, _session, socket) do
    PubSub.subscribe(ElixirNewbie.PubSub, @topic)
    blogs = blogs_to_html(BlogCache.get())
    {:ok, assign(socket, blogs: blogs, active_blog: List.first(blogs))}
  end

  def handle_info({:update_blogs, blogs}, socket),
    do: {:noreply, assign(socket, blogs: blogs_to_html(blogs))}
end
