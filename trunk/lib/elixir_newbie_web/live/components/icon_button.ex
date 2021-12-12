defmodule ElixirNewbieWeb.Live.Components.IconButton do
  use Surface.Component

  alias ElixirNewbieWeb.Live.Components.Icon
  slot default, required: true
  prop class, :css_class
  prop rounded, :boolean
  prop reverse, :boolean
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
        "text-2xl text-white w-max-content items-center flex group ",
        @class,
        "flex flex-row-reverse": @reverse,
        }>
        <span class={
          "flex items-center justify-center w-16 h-16",
          "transition duration-300 ease-in-out transform group-hover:scale-110 group-hover:opacity-50",
          @container_class,
          "border-2 border-white rounded-full": @rounded,
          "mr-8": !@reverse,
          "ml-8": @reverse,
        }>
           <Icon icon={@icon}/>
        </span>
        <#slot/>
      </button>
    """
  end
end
