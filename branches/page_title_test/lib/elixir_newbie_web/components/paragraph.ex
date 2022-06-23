defmodule ElixirNewbieWeb.Components.Paragraph do
  use Surface.Component

  slot default, required: true
  prop class, :css_class

  def render(assigns) do
    ~F"""
      <p class={"mt-8 text-xl leading-relaxed text-white", @class}><#slot/></p>
    """
  end
end
