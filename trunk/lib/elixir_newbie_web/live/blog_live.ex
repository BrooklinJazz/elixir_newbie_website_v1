defmodule ElixirNewbieWeb.BlogLive do
  @moduledoc """
  Display List of Blogs
  """
  use Surface.LiveView
  alias ElixirNewbie.Blogs
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Live.Components.Icon
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Phoenix.PubSub
  alias Surface.Components.Form
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.TextInput
  alias Surface.Components.Form.Label

  @topic "update blogs"

  def handle_event("filter", %{"filter" => %{"search" => search}}, socket) do
    # TODO IMPLEMENT SEARCH
    {:noreply, socket}
  end

  def mount(_params, _session, socket) do
    PubSub.subscribe(ElixirNewbie.PubSub, @topic)
    blogs = Blogs.all()

    {:ok,
     assign(socket,
       blogs: blogs,
       selected_blog_on_mobile: false,
       active_blog: List.first(blogs),
       loading: !connected?(socket),
       search: ""
     )}
  end

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <section class="mx-12 my-6">
        <Form for={:filter} change="filter" class="text-white" opts={autocomplete: "off"}>
        <Field name="search" class="flex items-center px-8 py-4 border-2 border-gray-600 rounded-full focus-within:border-secondary w-96">
          <Icon icon={:search} class="text-gray-400"/>
          <TextInput opts={placeholder: "Search", autofocus: true} class="flex-grow h-8 p-4 placeholder-gray-400 bg-transparent outline-none focus-within:text-secondary" value={@search}/>
          <p>{length(@blogs)}</p>
        </Field>
        </Form>
      </section>
      <section class="grid gap-12 px-12 lg:grid-cols-3 md:grid-cols-2 xs:grid-cols-1">
      {#for blog <- @blogs}
        <article class="text-white">
        <img class="object-contain w-full bg-black rounded-lg h-60 max-h-60" src={Routes.static_path(ElixirNewbieWeb.Endpoint, blog.cover_image || "/images/default.png")}/>
        <p class="mt-6 text-2xl leading-relaxed">{blog.title}</p>
        <p class="mt-2 text-base italic leading-relaxed">{blog.subtitle}</p>
        <p class="mt-2 text-base leading-relaxed">{blog.description}</p>
        <p class="mt-2 text-gray-300">{Calendar.strftime(NaiveDateTime.new!(blog.published_at, Time.utc_now()), "%B %d %Y")}</p>
        </article>
      {/for}
      </section>
    </Page>
    """
  end

  # def handle_event("set-active-blog", %{"slug" => slug}, socket) do
  #   {:noreply,
  #    push_patch(socket,
  #      to: Routes.live_path(socket, ElixirNewbieWeb.BlogLive, slug: slug)
  #    )}
  # end

  # def handle_params(%{"slug" => slug}, _url, socket) do
  #   %{blogs: blogs} = socket.assigns

  #   {:noreply,
  #    assign(socket,
  #      selected_blog_on_mobile: true,
  #      active_blog: Enum.find(blogs, &(&1.slug === slug))
  #    )}
  # end

  # def handle_params(_params, _url, socket) do
  #   {:noreply, socket}
  # end

  # def mount(%{"slug" => slug}, _session, socket) do
  #   PubSub.subscribe(ElixirNewbie.PubSub, @topic)
  #   blogs = Blogs.all()

  #   {:ok,
  #    assign(socket,
  #      blogs: blogs,
  #      selected_blog_on_mobile: true,
  #      active_blog: Enum.find(blogs, &(&1.slug === slug)),
  #      loading: !connected?(socket)
  #    )}
  # end
end
