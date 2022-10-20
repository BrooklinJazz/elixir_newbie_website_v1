defmodule ElixirNewbieWeb.TwitterFeedList do
  @moduledoc """
    Display last week tweets using #ElixirNewbie hashtag.
  """

  use Surface.LiveView
  alias ElixirNewbie.TwitterFeed
  alias ElixirNewbieWeb.Components.TweetCard
  alias ElixirNewbieWeb.Components.Title
  alias ElixirNewbieWeb.Components.SubTitle
  alias ElixirNewbieWeb.Live.Home.Footer
  alias ElixirNewbieWeb.Components.Page
  alias ElixirNewbieWeb.Components.ResponsiveLayout

  def mount(_params, _session, socket) do
    tweets = TwitterFeed.get_tweets()

    {:ok,
     assign(socket,
       page_title: "Twitter Feed",
       tweets: tweets,
       loading: !connected?(socket)
     )}
  end

  def render(assigns) do
    ~F"""
    <Page loading={@loading}>
      <ResponsiveLayout>
        <article class="flex flex-col">
          <Title>Latest from #ElixirNewbie on Twitter</Title>
        </article>
      </ResponsiveLayout>
      <ResponsiveLayout>
        {#if @tweets == []}
          <SubTitle>No tweets found!</SubTitle>
        {#else}
          {#for tweet <- @tweets}
            <TweetCard
              id={tweet.id}
              author_name={tweet.author_name}
              author_username={tweet.author_username}
              author_picture={tweet.author_image}
              author_verified={tweet.author_verified}
              created_at={tweet.created_at}
              text={tweet.text}>
            </TweetCard>
          {/for}
        {/if}
        </ResponsiveLayout>
      <Footer id={:footer}/>
    </Page>
    """
  end
end
