defmodule ElixirNewbieWeb.HomeLive do
  @moduledoc """
  Home Page
  """
  use Surface.LiveView
  alias ElixirNewbieWeb.BlogLive
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Endpoint
  alias ElixirNewbieWeb.PodcastLive
  alias ElixirNewbieWeb.Router.Helpers, as: Routes
  alias Surface.Components.LiveRedirect
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
      <section class="flex justify-center h-full mt-12">
        <article class="md:w-3/4 lg:w-3/5 animate-fade-in">
          <figure class="text-3xl text-white md:text-4xl">
          <p class="mt-12">Hi, I’m Brooklin Myers.</p>
          <p class="mt-12">I help aspiring developers learn Elixir, and break into the programming industry.</p>
          <p class="mt-12">I do that through <span class="text-primary">{Enum.at(@words, @current_word)}.</span></p>
          </figure>
          <figure class="flex hidden mt-12 md:flex">
              <LiveRedirect
                to={Routes.live_path(Endpoint, BlogLive)}
                class={
                  "cursor-pointer py-4 text-2xl text-center text-white border-2 border-secondary rounded-full w-72 "
                  <> " transition duration-500 ease-in-out transform hover:scale-110  "
                  <> " mr-12"
                }>
              Read the Blog
              </LiveRedirect>
              <LiveRedirect
                to={Routes.live_path(Endpoint, PodcastLive)}
                class={
                  "cursor-pointer py-4 text-2xl text-center text-white border-2 border-secondary rounded-full w-72 "

                  <> " transition duration-500 ease-in-out transform hover:scale-110 "
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
