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
    {#for blog <- @blogs}
    <section class="blogs">
    <section class="blog-list">
    <div class="blog">
    <h2>{blog.title}</h2>
    {blog.body_html}
    </div>
    </section>
    </section>
    {/for}
    </Page>
    """
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

    {:ok, assign(socket, blogs: blogs_to_html(BlogCache.get()))}
  end

  def handle_info({:update_blogs, blogs}, socket),
    do: {:noreply, assign(socket, blogs: blogs_to_html(blogs))}
end
