defmodule ElixirNewbieWeb.Components.Page do
  @moduledoc """
  Page component
  Use for pages that need navigation and footer.
  """
  use Surface.Component
  alias ElixirNewbieWeb.Components.Footer
  alias ElixirNewbieWeb.Components.Navigation
  slot default, required: true
  prop loading, :boolean, required: true

  def render(assigns) do
    ~F"""
    <section class="page bg-background">
    {#if @loading}
    {#else}
    <section class="content bg-background">
        <Navigation id={:navigation}/>
          <#slot/>
        </section>
        <Footer id={:footer}/>
    {/if}
    </section>
    """
  end
end
