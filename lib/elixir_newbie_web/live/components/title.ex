defmodule ElixirNewbieWeb.Live.Components.Title do
  use Surface.Component

  slot default, required: true

  def render(assigns) do
    ~F"""
      <p class="text-4xl leading-relaxed text-white"><#slot/></p>
    """
  end
end