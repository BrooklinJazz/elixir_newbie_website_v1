defmodule ElixirNewbieWeb.Live.Components.IconButton do
  use Surface.Component

  alias ElixirNewbieWeb.Live.Components.Icon
  slot default, required: true
  prop class, :css_class
  prop rounded, :boolean
  prop container_class, :css_class
  prop icon, :string, values!: [:left_arrow, :mail]
  prop click, :event
  prop hook, :string
  prop value, :string
  prop id, :string

  def render(assigns) do
    ~F"""
      <button
        id={@id}
        phx-hook={@hook}
        :on-click={@click}
        data-value={@value}
        class={
        "text-2xl text-white flex flex-1 items-center",
        @class
        }>
        <span class={
          "flex items-center justify-center w-16 h-16 mr-8",
          @rounded && "border-2 border-white rounded-full" || "",
          @container_class
        }>
           <Icon icon={@icon}/>
        </span>
        <#slot/>
      </button>
    """
  end
end
