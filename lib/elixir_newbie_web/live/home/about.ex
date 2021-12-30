defmodule ElixirNewbieWeb.Live.Home.About do
  use Surface.Component
  alias ElixirNewbieWeb.Components.Paragraph
  alias ElixirNewbieWeb.Components.ResponsiveLayout
  alias ElixirNewbieWeb.Components.IconButton
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~F"""
      <ResponsiveLayout scroll_id={"about"} cols={2}>
        <article class="items-center xs:flex xs:flex-col sm:block">
          <img
            class={"md:w-3/4 m-auto lg:m-0"}
            src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/dragons.png")}/>
          <IconButton icon={:linkedin} class={"mt-12"}>Brooklin Myers</IconButton>
          <IconButton icon={:mail}>brooklin@elixirnewbie.com</IconButton>
          <IconButton icon={:twitter}>@BrooklinJMyers</IconButton>
          <IconButton id={:about_to_podcast} hook="ScrollOnClick" value="podcast" rounded={true} icon={:down_arrow} class={"mt-24"}>What I Make</IconButton>
        </article>
        <article>
          <Paragraph>I love programming as much as I do dungeons & dragons.</Paragraph>
          <Paragraph>I started programming when I found out that Wizard wasn't a viable career path (still trying) and programming was the next best thing.</Paragraph>
          <Paragraph>We learn arcane languages, cast spells, and create magic (hopefully the good kind).</Paragraph>
          <Paragraph>I also love teaching and sharing what I know. I believe in creating a supportive environment on any team or project I take part in where everyone can learn and grow together.</Paragraph>
          <Paragraph>I write, I podcast, and I play way too much rocket league.</Paragraph>
          <Paragraph>I'm available for collaboration, technical writing, and Elixir dev work.</Paragraph>
        </article>
      </ResponsiveLayout>
    """
  end
end
