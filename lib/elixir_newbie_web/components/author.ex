defmodule ElixirNewbieWeb.Components.Author do
  use Surface.Component
  prop author_name, :string, required: true
  prop blog_date, :string, required: true
  prop author_picture, :string, required: false

  def render(assigns) do
    ~F"""
      <div class="flex flex-row mb-8">
      {#unless is_nil(@author_picture)}
        <div class="basis-1/4 mr-3">
          <img src={@author_picture} class="rounded-full border-solid border-2 h-[48px] w-[48px]">
        </div>
      {/unless}
        <div class="basis-3/4 flex flex-col justify-between text-sm">
          <div>{@author_name}</div>
          <div class="text-gray-300">
            {Calendar.strftime(NaiveDateTime.new!(@blog_date, Time.utc_now()), "%B %d %Y")}
          </div>
        </div>
      </div>
    """
  end
end
