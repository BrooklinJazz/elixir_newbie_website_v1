defmodule ElixirNewbieWeb.HomeLive do
  use Surface.LiveView
  alias ElixirNewbieWeb.Endpoint
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.PodcastLive
  alias ElixirNewbieWeb.BlogLive
  alias Surface.Components.LiveRedirect
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  # https://gist.github.com/BrooklinJazz/86b7ca1cd58db2012ca0f1c3a4aabd39.js
  data current_word, :integer, default: 0

  data words, :list,
    default: [
      "writing",
      "podcasting",
      "talks",
      "sharing",
      "creating",
      "hacking",
      "documenting",
      "video",
      "tutorials",
      "summarizing",
      "blogging",
      "speaking",
      "conversation",
      "recording",
      "audio",
      "open source",
      "book club",
      "meetups",
      "events",
      "hackathons"
    ]

  #        <img class="col-span-1 m-auto rounded-full" src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/profile.jpg")}/>
  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <section class="flex justify-center pt-8 md:px-20">
        <article class="w-2/4 col-span-1 animate-fade-in">
          <figure class="text-4xl text-white">
          Hi, I’m Brooklin Myers.<br/><br/>
          I help aspiring developers learn Elixir, and break into the programming industry.<br/><br/>
          I do that through <span class="text-primary">{Enum.at(@words, @current_word)}.</span>
          </figure>
          <figure class="flex justify-between pr-12 mt-8">
              <LiveRedirect
                to={Routes.live_path(Endpoint, BlogLive)}
                class={
                  "cursor-pointer py-4 text-2xl text-center text-white border-2 border-secondary rounded-full w-72 "
                  <> "transition duration-500 ease-in-out hover:border-primary transform hover:scale-110 hover:text-primary"
                }>
              Read the Blog
              </LiveRedirect>
              <LiveRedirect
                to={Routes.live_path(Endpoint, PodcastLive)}
                class={
                  "cursor-pointer py-4 text-2xl text-center text-white border-2 border-secondary rounded-full w-72 "
                  <> "transition duration-500 ease-in-out hover:border-primary transform hover:scale-110 hover:text-primary"
                }>
                Listen to the Podcast
              </LiveRedirect>
            </figure>
        </article>
      </section>
    </Page>
    """
  end

  def handle_info(:change_word, socket) do
    %{words: words, current_word: current_word} = socket.assigns

    if current_word >= length(words) - 1 do
      {:noreply, update(socket, :current_word, fn _ -> 0 end)}
    else
      {:noreply, update(socket, :current_word, &(&1 + 1))}
    end
  end

  def mount(_params, _session, socket) do
    :timer.send_interval(1000, self(), :change_word)
    {:ok, assign(socket, loading: !connected?(socket))}
  end
end
