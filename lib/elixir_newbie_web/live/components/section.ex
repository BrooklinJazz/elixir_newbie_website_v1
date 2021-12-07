defmodule ElixirNewbieWeb.Live.Components.Section do
  use Surface.Component

  prop class, :css_class
  slot default, required: true

  def render(assigns) do
    ~F"""
    <section class={
      "grid mt-24 sm:grid-cols-1 lg:grid-cols-2 sm:grid-rows-2 lg:grid-rows-1 gap-y-24 xl:px-60 md:px-12 px-12 min-h-full",
      @class
    }>
      <#slot/>
    </section>
    """
  end
end
