defmodule ElixirNewbieWeb.Components.Feed do
  use Surface.Component
  slot active_item, required: true
  slot items, required: true

  def render(assigns) do
    ~F"""
    <section class="grid grid-cols-5 grid-rows-1 px-20 pt-4 gap-x-10">
      <section class="col-span-2 pt-4 bg-surface">
        <#slot name="items" />
      </section>
      <section class="col-span-3">
        <#slot name="active_item" />
      </section>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
