defmodule ElixirNewbieWeb.Live.Home.Footer do
  use Surface.LiveView

  alias ElixirNewbie.Blog
  alias ElixirNewbie.Podcast
  alias ElixirNewbie.PodcastCache

  alias ElixirNewbieWeb.BlogList
  alias ElixirNewbieWeb.BlogShow
  alias ElixirNewbieWeb.Endpoint
  alias ElixirNewbieWeb.Components.Paragraph
  alias ElixirNewbieWeb.Components.ResponsiveLayout
  alias ElixirNewbieWeb.Components.Title
  alias ElixirNewbieWeb.Components.IconButton
  alias ElixirNewbieWeb.PodcastList
  alias ElixirNewbieWeb.PodcastShow
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  alias Surface.Components.LiveRedirect

  def render(assigns) do
    ~F"""
    <ResponsiveLayout class="py-12 mt-24 bg-black" spacing={"full"} cols={4}>
        <article class="flex flex-col">
          <Title class="text-center">Elixir Newbie</Title>
          <Paragraph>Elixir Newbie is dedicated to helping new developers grow. The Elixir Newbie website is a blog, a podcast, and a collection of my favourite resources.</Paragraph>
        </article>
        <article class="flex flex-col">
          <Title class="text-center">Resources</Title>
          <Paragraph>If you’re new to Elixir, here’s a quick collection of some of my favourite tools and resources from the elixir community.</Paragraph>
          <Paragraph>Pretty much shout outs to some folks & projects I admire.</Paragraph>
          <ul class="w-full mt-6 text-xl leading-relaxed underline list-disc list-inside text-secondary">
            <li><a target="_blank" href="https://elixirschool.com/en/">Elixir School</a></li>
            <li><a target="_blank" href="https://exercism.org/tracks/elixir">Exercism.io</a></li>
            <li><a target="_blank" href="https://joyofelixir.com/">Joy Of Elixir</a></li>
            <li><a target="_blank" href="https://alchemist.camp/">Alchemist Camp</a></li>
            <li><a target="_blank" href="https://elixircasts.io/">Elixir Casts</a></li>
          </ul>
        </article>
        <article class="flex flex-col">
          <Title class="text-center">Podcast</Title>
          <ul class="w-full text-xl leading-relaxed underline list-disc list-inside text-secondary">
            {#for episode <- @highlighted_episodes}
              <li class="mt-6">
                <LiveRedirect
                  to={Routes.live_path(ElixirNewbieWeb.Endpoint, PodcastShow, episode.season_number, episode.episode_number)}>
                  {episode.title}
                </LiveRedirect>
              </li>
            {/for}
          </ul>
          <IconButton click="to_podcast" rounded={true} icon={:right_arrow} class={"mt-6"}>More Episodes</IconButton>
        </article>
        <article class="flex flex-col">
          <Title class="text-center">Blog</Title>
          <ul class="w-full text-xl leading-relaxed underline list-disc list-inside text-secondary">
            {#for blog <- @highlighted_blogs}
              <li class="mt-6">
                <LiveRedirect
                  to={Routes.live_path(Endpoint, BlogShow, blog.id)}>
                  {blog.title}
                </LiveRedirect>
              </li>
            {/for}
          </ul>
          <IconButton click="to_blog" id={"footer-button"} rounded={true} icon={:right_arrow} class={"mt-6"}>More Articles</IconButton>
        </article>
      </ResponsiveLayout>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       highlighted_episodes: Podcast.highlighted_episodes(PodcastCache),
       highlighted_blogs: Blog.highlighted_posts(6)
     )}
  end

  def handle_event("to_blog", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, BlogList))}
  end

  def handle_event("to_podcast", _, socket) do
    {:noreply, push_redirect(socket, to: Routes.live_path(socket, PodcastList))}
  end
end
