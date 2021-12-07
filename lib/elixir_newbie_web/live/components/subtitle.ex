defmodule ElixirNewbieWeb.Live.Components.SubTitle do
  use Surface.Component

  prop class, :css_class
  slot default, required: true

  def render(assigns) do
    ~F"""
      <p class={"text-2xl leading-relaxed text-white ", @class}><#slot/></p>
    """
  end
end
