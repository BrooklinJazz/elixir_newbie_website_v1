defmodule ElixirNewbieWeb.Components.IconButton do
  use Surface.Component

  alias ElixirNewbieWeb.Components.Icon
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
        "text-lg md:text-2xl text-white w-max-content items-center flex group ",
        @class,
        "flex flex-row-reverse": @reverse,
        }>
        <div class={
          "flex items-center justify-center w-16 h-16 shrink-0 min-w-16",
          "transition duration-300 ease-in-out transform group-hover:scale-110 group-hover:opacity-50",
          @container_class,
          "border-2 border-white rounded-full": @rounded,
          "mr-2 md:mr-8": !@reverse,
          "ml-2 md:ml-8": @reverse,
        }>
           <Icon icon={@icon}/>
        </div>
        <#slot/>
      </button>
    """
  end
end
