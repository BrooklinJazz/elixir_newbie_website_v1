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
        <Navigation id={:navigation}/>
        <section class="pt-12 content bg-background">
          <#slot/>
        </section>
        <Footer id={:footer}/>
    {/if}
    </section>
    """
  end
end
