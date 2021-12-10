defmodule ElixirNewbieWeb.BlogList do
  @moduledoc """
  Display List of Blogs
  """
  use Surface.LiveView
  alias ElixirNewbie.Blog
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Live.Components.Icon
  alias ElixirNewbieWeb.BlogShow
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Surface.Components.Form
  alias Surface.Components.LiveRedirect
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.TextInput
  alias Surface.Components.Form.Label

  def mount(_params, _session, socket) do
    blogs = Blog.all_posts()
    tags = Blog.all_tags()

    {:ok,
     assign(socket,
       blogs: blogs,
       tags: tags,
       #  TODO ensure default selected tags
       selected_tags: [],
       selected_blog_on_mobile: false,
       active_blog: List.first(blogs),
       loading: !connected?(socket),
       search: ""
     )}
  end

  def handle_event("filter", %{"filter" => %{"search" => search}}, socket) do
    {:noreply, socket |> assign(:search, search) |> load_blogs()}
  end

  def handle_event("toggle-tag", %{"tag" => tag}, socket) do
    %{selected_tags: selected_tags} = socket.assigns

    selected_tags =
      if tag in selected_tags,
        do: Enum.reject(selected_tags, &(&1 === tag)),
        else: [tag | selected_tags]

    {:noreply,
     socket
     |> assign(:selected_tags, selected_tags)
     |> load_blogs()}
  end

  def load_blogs(socket) do
    %{search: search, selected_tags: selected_tags} = socket.assigns
    socket |> assign(:blogs, Blog.all_posts(search: search, selected_tags: selected_tags))
  end

  # TODO ensure images are not stretching.
  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <section class="mx-12 my-6">
        <Form for={:filter} change="filter" class="flex text-white" opts={autocomplete: "off"}>
        <Field name="search" class="flex items-center px-8 py-4 border-2 border-gray-600 rounded-full focus-within:border-secondary w-96">
          <Icon icon={:search} class="text-gray-400"/>
          <TextInput opts={placeholder: "Search", autofocus: true} class="flex-grow h-8 p-4 placeholder-gray-400 bg-transparent outline-none focus-within:text-secondary" value={@search}/>
          <p>{length(@blogs)}</p>
          </Field>
          {#for tag <- @tags}
            <p :on-click="toggle-tag" phx-value-tag={tag} class={"flex items-center h-8 px-6 ml-6 rounded-full cursor-pointer", "bg-secondary": tag in @selected_tags, "bg-secondary/[0.3]": tag not in @selected_tags}>{tag}</p>
          {/for}
        </Form>
      </section>
      <section class="grid gap-12 px-12 lg:grid-cols-3 md:grid-cols-2 xs:grid-cols-1">
      {#for blog <- @blogs}
        <LiveRedirect
          to={Routes.live_path(ElixirNewbieWeb.Endpoint, BlogShow, blog.id)}
        >
          <article class="text-white">
          <img class="w-full bg-black rounded-lg h-60 max-h-60" src={blog.cover_image || Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/default.png")}/>
          <p class="mt-6 text-2xl leading-relaxed">{blog.title}</p>
          <p class="mt-2 text-base leading-relaxed">{blog.description}</p>
          <p class="mt-2 text-gray-300">{Calendar.strftime(NaiveDateTime.new!(blog.date, Time.utc_now()), "%B %d %Y")}</p>
          </article>
        </LiveRedirect>
      {/for}
      </section>
    </Page>
    """
  end
end
