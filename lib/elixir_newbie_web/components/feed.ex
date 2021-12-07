defmodule ElixirNewbieWeb.Components.Feed do
  @moduledoc """
  Generic Reusable Feed Component for Blogs and Podcasts
  """
  use Surface.Component
  slot active_item, required: true
  slot items, required: true

  def render(assigns) do
    ~F"""
    <section class={
      "grid md:grid-cols-5 md:grid-rows-1 md:px-20 md:pt-4 md:gap-x-10 "
      <> "sm:grid-cols-2"
    }>
      <section class="md:pt-4 md:col-span-2 sm:col-span-1 bg-surface animate-fade-down">
        <#slot name="items" />
      </section>
      <section class="overflow-hidden md:overflow-none sm:max-w-full md:col-span-3 sm:col-span-1 bg-surface">
        <#slot name="active_item" />
      </section>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
