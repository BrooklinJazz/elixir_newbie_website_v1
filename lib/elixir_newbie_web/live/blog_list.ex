defmodule ElixirNewbieWeb.BlogList do
  @moduledoc """
  Display List of Blogs
  """
  use Surface.LiveView
  alias ElixirNewbie.Blog
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Live.Components.BlogCard
  alias ElixirNewbieWeb.Live.Components.ResponsiveLayout
  alias ElixirNewbieWeb.Live.Components.Icon
  alias ElixirNewbieWeb.Live.Home.Footer
  alias Surface.Components.Form
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.TextInput

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
        <Form for={:filter} change="filter" class="flex flex-wrap text-white xl:flex-nowrap" opts={autocomplete: "off"}>
          <Field name="search" class="flex items-center h-16 px-8 py-4 border-2 border-gray-600 rounded-full focus-within:border-secondary w-96">
            <Icon icon={:search} class="text-gray-400"/>
            <TextInput opts={placeholder: "Search", autofocus: true} class="flex-grow h-8 p-4 placeholder-gray-400 bg-transparent outline-none focus-within:text-secondary" value={@search}/>
            <p>{length(@blogs)}</p>
          </Field>
          <figure class="flex flex-wrap mt-4 xl:mt-0 xl:ml-4">
            {#for tag <- @tags}
              <p :on-click="toggle-tag" phx-value-tag={tag} class={"flex items-center h-8 mb-4 px-6 mr-6 rounded-full cursor-pointer", "bg-secondary": tag in @selected_tags, "bg-secondary/[0.3]": tag not in @selected_tags}>{tag}</p>
            {/for}
          </figure>
        </Form>
      </section>
      <ResponsiveLayout cols={3} spacing="full">
        {#for blog <- @blogs}
          <BlogCard blog={blog} />
        {/for}
      </ResponsiveLayout>
      <Footer id={:footer}/>
    </Page>
    """
  end
end
