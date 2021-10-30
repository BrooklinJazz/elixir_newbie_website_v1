defmodule ElixirNewbieWeb.Components.Page do
  use Surface.Component
  alias ElixirNewbieWeb.Components.{Footer, Navigation}
  slot(default, required: true)

  def render(assigns) do
    ~F"""
    <section class="page">
      <Navigation id={:navigation}/>
      <section class="content">
        <#slot/>
      </section>
      <Footer id={:footer}/>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
