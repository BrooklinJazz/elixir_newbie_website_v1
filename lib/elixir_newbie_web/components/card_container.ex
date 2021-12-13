defmodule ElixirNewbieWeb.Components.CardContainer do
  use Surface.Component
  slot default, required: true

  def render(assigns) do
    ~F"""
      <section class="grid gap-12 px-12 lg:grid-cols-3 md:grid-cols-2 xs:grid-cols-1">
        <#slot/>
      </section>
    """
  end
end
