defmodule ElixirNewbieWeb.Components.SubTitle do
  use Surface.Component

  prop class, :css_class
  slot default, required: true

  def render(assigns) do
    ~F"""
      <p class={"text-xl md:text-2xl lg:text-3xl leading-relaxed text-white ", @class}><#slot/></p>
    """
  end
end
