defmodule ElixirNewbieWeb.Live.Components.BlogCard do
  use Surface.Component
  alias ElixirNewbieWeb.BlogShow
  alias Surface.Components.LiveRedirect
  alias ElixirNewbieWeb.Router.Helpers, as: Routes

  prop blog, :map, required: true

  def render(assigns) do
    ~F"""
       <LiveRedirect
       to={Routes.live_path(ElixirNewbieWeb.Endpoint, BlogShow, @blog.id)}
     >
       <article class="text-white">
         <img class="w-full bg-black rounded-lg object-fit h-60 max-h-60" src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/posts/#{@blog.cover_image}")}/>
         <p class="mt-6 text-2xl leading-relaxed capitalize">{@blog.title}</p>
         <p class="mt-2 text-base leading-relaxed capitalize">{@blog.description}</p>
         <p class="mt-2 text-gray-300">{Calendar.strftime(NaiveDateTime.new!(@blog.date, Time.utc_now()), "%B %d %Y")}</p>
       </article>
     </LiveRedirect>
    """
  end
end
