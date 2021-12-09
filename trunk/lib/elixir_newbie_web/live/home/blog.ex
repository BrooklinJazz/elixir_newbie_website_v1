defmodule ElixirNewbieWeb.Live.Home.Blog do
  use Surface.LiveComponent
  alias ElixirNewbieWeb.BlogLive
  alias ElixirNewbieWeb.Live.Components.IconButton
  alias ElixirNewbieWeb.Live.Components.Section
  alias ElixirNewbieWeb.Live.Components.SubTitle
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~F"""
      <Section>
        <article>
          <SubTitle>I love sharing what I know.</SubTitle>
          <SubTitle class="mt-12">Learn Elixir with a friendly and approachable tone.</SubTitle>
          <IconButton click="to_blog" class="mt-12" rounded={true} icon={:right_arrow}>All Articles</IconButton>
        </article>
        <article class="lg:flex lg:flex-col lg:items-end">
          <img class={"animage-fade-in w-1/2 m-auto lg:m-0 md:w-3/5"} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/magic_books.png")}/>
        </article>
      </Section>
    """
  end

  def handle_event("to_blog", _, socket) do
    {:noreply, redirect(socket, to: Routes.live_path(socket, BlogLive))}
  end
end
