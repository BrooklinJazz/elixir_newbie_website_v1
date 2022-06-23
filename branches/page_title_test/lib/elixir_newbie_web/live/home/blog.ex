defmodule ElixirNewbieWeb.Live.Home.Blog do
  use Surface.LiveComponent
  alias ElixirNewbieWeb.BlogList
  alias ElixirNewbieWeb.Components.IconButton
  alias ElixirNewbieWeb.Components.ResponsiveLayout
  alias ElixirNewbieWeb.Components.SubTitle
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~F"""
      <ResponsiveLayout cols={2}>
        <article>
          <SubTitle>I love sharing what I know.</SubTitle>
          <SubTitle class="mt-12">Learn Elixir with a friendly and approachable tone.</SubTitle>
          <IconButton click="to_blog" class="mt-12" rounded={true} icon={:right_arrow}>All Blogs</IconButton>
        </article>
        <article class="lg:flex lg:flex-col lg:items-end">
          <img class={"w-1/2 m-auto lg:m-0 md:w-3/5"} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/magic_books.png")}/>
        </article>
      </ResponsiveLayout>
    """
  end

  def handle_event("to_blog", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, BlogList))}
  end
end
