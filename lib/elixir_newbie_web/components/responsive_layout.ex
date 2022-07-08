defmodule ElixirNewbieWeb.Components.ResponsiveLayout do
  use Surface.Component

  prop class, :css_class
  prop scroll_id, :string
  prop spacing, :string, values!: ["full", "narrow"], default: "narrow"
  prop gap, :string, values!: ["none", "small", "large"], default: "small"
  prop cols, :integer, values!: [2, 3, 4]
  slot default, required: true

  def render(assigns) do
    ~F"""
    <section data-scroll-id={@scroll_id} class={
      "grid min-h-full py-12",
      @class,
      "px-12 md:px-24 xl:px-60": @spacing === "narrow",
      "px-6 md:px-8 xl:px-12": @spacing === "full",
      "gap-24": @gap === "large",
      "gap-12": @gap === "small",
      "sm:grid-cols-1 lg:grid-cols-2 sm:grid-rows-2 lg:grid-rows-1": @cols === 2,
      "grid lg:grid-cols-3 md:grid-cols-2 xs:grid-cols-1 gap-12": @cols === 3,
      "grid w-full min-h-full gap-12 sm:grid-cols-1 xl:grid-cols-4 lg:grid-cols-2": @cols === 4
    }>
      <#slot/>
    </section>
    """
  end
end

# <section data-scroll-id="all_episodes" class="grid grid-cols-2 gap-24 mx-24 md:grid-cols-2">
