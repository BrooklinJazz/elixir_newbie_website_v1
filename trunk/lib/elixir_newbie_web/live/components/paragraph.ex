defmodule ElixirNewbieWeb.Live.Components.Paragraph do
  use Surface.Component

  slot default, required: true

  def render(assigns) do
    ~F"""
      <p class="mt-8 text-2xl leading-relaxed text-white"><#slot/></p>
    """
  end
end
