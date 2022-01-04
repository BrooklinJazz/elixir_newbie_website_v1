defmodule ElixirNewbieWeb.Components.Icon do
  use Surface.Component

  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  prop class, :css_class
  prop icon, :atom

  @icons %{
    down_arrow: "M19 14l-7 7m0 0l-7-7m7 7V3",
    mail:
      "M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z",
    twitter:
      "M22 4.01c-1 .49-1.98.689-3 .99-1.121-1.265-2.783-1.335-4.38-.737S11.977 6.323 12 8v1c-3.245.083-6.135-1.395-8-4 0 0-4.182 7.433 4 11-1.872 1.247-3.739 2.088-6 2 3.308 1.803 6.913 2.423 10.034 1.517 3.58-1.04 6.522-3.723 7.651-7.742a13.84 13.84 0 0 0 .497 -3.753C20.18 7.773 21.692 5.25 22 4.009z",
    linkedin: "M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z",
    right_arrow: "M14 5l7 7m0 0l-7 7m7-7H3",
    left_arrow: "M10 19l-7-7m0 0l7-7m-7 7h18",
    search: "M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z",
    calendar:
      "M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z",
    clock: "M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z",
    chevron_down: "M19 9l-7 7-7-7",
    chevron_up: "M5 15l7-7 7 7",
    apple:
      "M9 7c-3 0-4 3-4 5.5 0 3 2 7.5 4 7.5 1.088-.046 1.679-.5 3-.5 1.312 0 1.5.5 3 .5s4-3 4-5c-.028-.01-2.472-.403-2.5-3-.019-2.17 2.416-2.954 2.5-3-1.023-1.492-2.951-1.963-3.5-2-1.433-.111-2.83 1-3.5 1-.68 0-1.9-1-3-1z",
    rss: "M6 5c7.18 0 13 5.82 13 13M6 11a7 7 0 017 7m-6 0a1 1 0 11-2 0 1 1 0 012 0z",
    google: "M17.788 5.108A9 9 0 1021 12h-8"
  }

  def draw_icon(icon) do
    @icons[icon]
  end

  def render(assigns) do
    ~F"""
      {#case @icon}
        {#match :spotify}
          <img class={"w-6 h-6 text-white", @class} src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/icons/spotify.svg")}/>
        {#match :apple}
          <svg xmlns="http://www.w3.org/2000/svg" class={"w-6 h-6", @class} fill="none" viewBox="0 0 24 24" stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round">
            <path stroke="none" d="M0 0h24v24H0z"/>
            <path d={draw_icon(@icon)} />
            <path d="M12 4a2 2 0 0 0 2 -2a2 2 0 0 0 -2 2" /><path stroke="none" d="M0 0h24v24H0z"/>
          </svg>
        {#match :linkedin}
          <svg xmlns="http://www.w3.org/2000/svg" class={"w-6 h-6", @class} fill="none" viewBox="0 0 24 24" stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round">
            <path d={draw_icon(@icon)}/>
            <rect x="2" y="9" width="4" height="12" />
            <circle cx="4" cy="4" r="2" />
          </svg>
        {#match _}
          <svg xmlns="http://www.w3.org/2000/svg" class={"w-6 h-6", @class} fill="none" viewBox="0 0 24 24" stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round">
            <path d={draw_icon(@icon)}/>
          </svg>
      {/case}
    """
  end
end
