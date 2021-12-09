defmodule ElixirNewbieWeb.Live.Components.Title do
  use Surface.Component
  prop class, :css_class
  slot default, required: true

  def render(assigns) do
    ~F"""
      <p class={"text-4xl leading-relaxed text-white", @class}><#slot/></p>
    """
  end
end
