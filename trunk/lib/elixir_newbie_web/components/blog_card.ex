defmodule ElixirNewbieWeb.Components.BlogCard do
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
          <figure class="overflow-hidden h-90">
            <img class="w-auto rounded-lg" src={Routes.static_path(ElixirNewbieWeb.Endpoint, "/images/posts/#{@blog.cover_image}")}/>
          </figure>
          <p class="mt-6 text-2xl leading-relaxed capitalize">{@blog.title}</p>
          <p class="mt-2 text-base leading-relaxed capitalize">{@blog.description}</p>
          <p class="mt-2 text-gray-300">{Calendar.strftime(NaiveDateTime.new!(@blog.date, Time.utc_now()), "%B %d %Y")}</p>
       </article>
     </LiveRedirect>
    """
  end
end
