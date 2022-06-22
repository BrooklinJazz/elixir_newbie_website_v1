defmodule ElixirNewbieWeb.BlogList do
  @moduledoc """
  Display List of Blogs
  """
  use Surface.LiveView
  alias ElixirNewbie.Blog
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Components.BlogCard
  alias ElixirNewbieWeb.Components.ResponsiveLayout
  alias ElixirNewbieWeb.Components.IconButton
  alias ElixirNewbieWeb.Components.Icon
  alias ElixirNewbieWeb.Components.Title
  alias ElixirNewbieWeb.Live.Home.Footer
  alias Surface.Components.Form
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.TextInput
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  import Phoenix.LiveView.Helpers

  def mount(_params, _session, socket) do
    blogs = Blog.all_posts()
    tags = Blog.all_tags()

    {:ok,
     assign(socket,
       blogs: blogs,
       tags: tags,
       page_title: "Blog",
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

  def handle_event("scroll", _params, socket) do
    {:noreply, socket}
  end

  def load_blogs(socket) do
    %{search: search, selected_tags: selected_tags} = socket.assigns
    socket |> assign(:blogs, Blog.all_posts(search: search, selected_tags: selected_tags))
  end

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <ResponsiveLayout gap="none" cols={2} spacing="narrow">
        <article class="flex flex-col">
          <Title>Learn Elixir with a Friendly and Approachable Tone</Title>
          <Form for={:filter} change="filter" submit={"scroll"} class="flex flex-col mt-12" opts={id: "search-blogs", autocomplete: "off", "phx-hook": "ScrollOnSubmit", "data-value": "all_blogs"}>
              <Field name="search" class="flex items-center w-full px-8 border-2 border-gray-600 rounded-full focus-within:border-secondary">
                <Icon icon={:search} class="text-gray-400"/>
                <TextInput opts={placeholder: "Search", autofocus: true} class="flex-grow w-0 h-8 p-4 py-8 text-white placeholder-gray-400 bg-transparent outline-none focus-within:text-secondary" value={@search}/>
                <p class="text-white">{length(@blogs)}</p>
              </Field>
          </Form>
          <IconButton id={:blog_list_to_all_blogs} reverse={true} class="mt-6" hook="ScrollOnClick" value={"all_blogs"} rounded={true} icon={:down_arrow}>See Results</IconButton>
          <figure class="flex flex-wrap mt-12">
          {#for tag <- @tags}
            <p :on-click="toggle-tag" phx-value-tag={tag} class={"flex items-center h-8 mb-4 px-6 mr-6 rounded-full cursor-pointer", "bg-secondary": tag in @selected_tags, "bg-secondary/[0.3]": tag not in @selected_tags}>{String.replace(tag, "_", " ")}</p>
          {/for}
          </figure>
        </article>
        <figure>
          <img class={"animate-fade-in m-auto w-3/4 my-12"} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/magic_books.png")}/>
        </figure>
      </ResponsiveLayout>
      <ResponsiveLayout class="mt-12" scroll_id={"all_blogs"} cols={3} spacing="full">
        {#for blog <- @blogs}
          <BlogCard blog={blog} />
        {/for}
      </ResponsiveLayout>
      <Footer id={:footer}/>
    </Page>
    """
  end
end
