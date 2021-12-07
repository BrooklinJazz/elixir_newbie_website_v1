defmodule ElixirNewbieWeb.Live.Home.Footer do
  use Surface.LiveView
  alias ElixirNewbieWeb.Live.Components.Paragraph
  alias ElixirNewbieWeb.Live.Components.Title
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Surface.Components.LiveRedirect
  alias ElixirNewbieWeb.Endpoint
  alias ElixirNewbieWeb.PodcastLive
  alias ElixirNewbieWeb.BlogLive

  def render(assigns) do
    ~F"""
      <section class="grid w-full min-h-full gap-24 mt-24 mb-24 sm:grid-cols-1 lg:grid-cols-4 sm:grid-rows-4 lg:grid-rows-1 sm:px-8 md:px-12">
        <article class="flex flex-col items-center">
          <Title>Elixir Newbie</Title>
          <Paragraph>Elixir Newbie is dedicated to helping new developers grow. The Elixir Newbie website is a blog, a podcast, and a collection of my favourite resources.</Paragraph>
        </article>
        <article class="flex flex-col items-center">
          <Title>Resources</Title>
          <Paragraph>If you’re new to Elixir, here’s a quick collection of some of my favourite tools and resources from the elixir community.</Paragraph>
          <Paragraph>Pretty much shout outs to some folks & projects I admire.</Paragraph>
          <ul class="w-full mt-6 text-xl leading-relaxed text-white underline list-disc list-inside">
            <li><a target="_blank" href="https://elixirschool.com/en/">Elixir School</a></li>
            <li><a target="_blank" href="https://exercism.org/tracks/elixir">Exercism.io</a></li>
            <li><a target="_blank" href="https://joyofelixir.com/">Joy Of Elixir</a></li>
            <li><a target="_blank" href="https://alchemist.camp/">Alchemist Camp</a></li>
            <li><a target="_blank" href="https://elixircasts.io/">Elixir Casts</a></li>
          </ul>
        </article>
        <article class="flex flex-col items-center">
          <Title>Podcast</Title>
          <ul class="w-full mt-6 text-xl leading-relaxed text-white underline list-disc list-inside">
            {#for episode <- @highlighted_episodes}
              <li>
                <LiveRedirect
                  to={Routes.live_path(Endpoint, PodcastLive)}>
                  {episode.title}
                </LiveRedirect>
              </li>
            {/for}
          </ul>
        </article>
        <article class="flex flex-col items-center">
          <Title>Blog</Title>
          <ul class="w-full mt-6 text-xl leading-relaxed text-white underline list-disc list-inside">
            {#for article <- @highlighted_blogs}
              <li>
                <LiveRedirect
                  to={Routes.live_path(Endpoint, BlogLive)}>
                  {article.title}
                </LiveRedirect>
              </li>
            {/for}
          </ul>
        </article>
      </section>
    """
  end

  def mount(_params, _session, socket) do
    # TODO, create real highlighted episodes
    {:ok,
     assign(socket,
       highlighted_episodes:
         Enum.map(1..12, fn index -> %{title: "Example Episode #{index} Title"} end),
       highlighted_blogs: Enum.map(1..12, fn index -> %{title: "Example Blog #{index} Title"} end)
     )}
  end
end
