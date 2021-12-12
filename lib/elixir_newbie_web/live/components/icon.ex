defmodule ElixirNewbieWeb.Live.Components.Icon do
  use Surface.Component

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
    search: "M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
  }

  def draw_icon(icon) do
    @icons[icon]
  end

  def render(assigns) do
    ~F"""
    <svg xmlns="http://www.w3.org/2000/svg" class={"w-6 h-6", @class} fill="none" viewBox="0 0 24 24" stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round">
      <path d={draw_icon(@icon)}/>
      {#if @icon == :linkedin}
          <rect x="2" y="9" width="4" height="12" />
          <circle cx="4" cy="4" r="2" />
      {/if}
      </svg>
    """
  end
end
