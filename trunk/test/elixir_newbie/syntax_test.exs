defmodule ElixirNewbie.SyntaxTest do
  use ExUnit.Case
  alias ElixirNewbie.Syntax

  test "highlight/1 one code block" do
    # regex to find <blockquote><p>{stuff}</p></blockquote>.
    # replace stuff with Makeup.highlight(stuff)
    source = "<code class=\"elixir\">8</code>"

    expected =
      "<code class=\"elixir\"><pre class=\"highlight\"><code><span class=\"mi\">8</span></code></pre></code>"

    assert Syntax.highlight(source) == expected
  end

  test "highlight/1 multiple code blocks" do
    # regex to find <blockquote><p>{stuff}</p></blockquote>.
    # replace stuff with Makeup.highlight(stuff)
    source = "
      <code class=\"elixir\">8</code>
      <code class=\"elixir\">8</code>
      <code class=\"elixir\">8</code>
    "

    expected = "
      <code class=\"elixir\"><pre class=\"highlight\"><code><span class=\"mi\">8</span></code></pre></code>
      <code class=\"elixir\"><pre class=\"highlight\"><code><span class=\"mi\">8</span></code></pre></code>
      <code class=\"elixir\"><pre class=\"highlight\"><code><span class=\"mi\">8</span></code></pre></code>
    "

    assert Syntax.highlight(source) == expected
  end
end
