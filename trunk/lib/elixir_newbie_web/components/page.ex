defmodule ElixirNewbieWeb.Components.Page do
  use Surface.Component
  alias ElixirNewbieWeb.Components.{Footer, Navigation}
  slot default, required: true
  prop loading, :boolean, required: true

  def render(assigns) do
    ~F"""
    <section class="page bg-background">
    {#if @loading}
    {#else}
        <Navigation id={:navigation}/>
        <section class="content bg-background">
          <#slot/>
        </section>
        <Footer id={:footer}/>
    {/if}
    </section>
    """
  end
end
