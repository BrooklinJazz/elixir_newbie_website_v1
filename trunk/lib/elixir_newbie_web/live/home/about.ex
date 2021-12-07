defmodule ElixirNewbieWeb.Live.Home.About do
  use Surface.Component
  alias ElixirNewbieWeb.Live.Components.Paragraph
  alias ElixirNewbieWeb.Live.Components.IconButton
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~F"""
      <section class="grid lg:pt-48 sm:grid-cols-1 lg:grid-cols-2 sm:grid-rows-2 lg:grid-rows-1 gap-y-24 xl:px-60 sm:px-8 md:px-12">
        <article>
          <img
            class={
            "animage-fade-in md:w-3/4"
            }
            src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/dragons.png")}/>
        <IconButton icon={:linkedin} class={"mt-12"}>Brooklin Myers</IconButton>
        <IconButton icon={:mail}>brooklin@elixirnewbie.com</IconButton>
        <IconButton icon={:twitter}>@BrooklinJMyers</IconButton>
        <IconButton rounded={true} icon={:down_arrow} class={"mt-24"}>What I Make</IconButton>
        </article>
        <article>
          <Paragraph>I love programming as much as I do dungeons and dragons.</Paragraph>
          <Paragraph>I started programming when I found out that Wizard wasn't a viable career path (still trying) and programming was the next best thing.</Paragraph>
          <Paragraph>We learn arcane languages, cast spells, and create magic (hopefully the good kind).</Paragraph>
          <Paragraph>I also love teaching and sharing what I know. I believe in creating a supportive environment on any team or project I take part in where everyone can learn and grow together.</Paragraph>
          <Paragraph>I write, I podcast, and I play way too much rocket league.</Paragraph>
          <Paragraph>I'm available for collaboration, technical writing, and Elixir dev work.</Paragraph>
        </article>
      </section>
    """
  end
end
