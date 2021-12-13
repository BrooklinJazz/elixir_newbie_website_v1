defmodule ElixirNewbieWeb.Components.Title do
  use Surface.Component
  prop class, :css_class
  prop color, :css_class, default: "text-white"
  slot default, required: true

  def render(assigns) do
    ~F"""
      <p class={"text-2xl md:text-3xl lg:text-4xl leading-relaxed", @color, @class}><#slot/></p>
    """
  end
end
