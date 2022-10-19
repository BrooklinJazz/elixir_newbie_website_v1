defmodule ElixirNewbieWeb.Components.TweetCard do
  use Surface.Component
  prop id, :string, required: true
  prop author_name, :string, required: true
  prop author_username, :string, required: true
  prop author_picture, :string, required: false
  prop author_verified, :boolean, required: false
  prop created_at, :datetime, required: false
  prop text, :string, required: false

  def render(assigns) do
    ~F"""
      <div id={"tweetcard_#{@id}"}>
        <a href={"https://twitter.com/#{@author_username}/status/#{@id}"} target="_blank">
          <div class="flex flex-row mb-8">
          {#unless is_nil(@author_picture)}
            <div class="basis-1/4 mr-3">
              <img src={@author_picture} class="rounded-full border-solid border-2 h-[48px] w-[48px]">
            </div>
          {/unless}
            <div class="lify-between text-sm">
              <div>
                <span class="text-white font-bold">{@author_name}</span>
                <span class="text-gray-300"> @{@author_username}</span>
              </div>
              <div class="text-white">
                {Calendar.strftime(@created_at, "%I:%M %p · %B %d, %Y")}
              </div>
            </div>
          </div>
          <div class="text-white">{@text}</div>
          </a>
      </div>
      <hr>
    """
  end
end
