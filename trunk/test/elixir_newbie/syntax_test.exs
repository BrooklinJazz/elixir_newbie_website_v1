defmodule ElixirNewbie.SyntaxTest do
  use ExUnit.Case
  alias ElixirNewbie.Syntax

  test "highlight/1 one code block" do
    # regex to find <blockquote><p>{stuff}</p></blockquote>.
    # replace stuff with Makeup.highlight(stuff)
    source = "<code class=\"elixir\">8</code>"

    expected = "<pre class=\"highlight\"><code><span class=\"mi\">8</span></code></pre>"

    assert Syntax.highlight(source) == expected
  end

  test "highlight/1 weird" do
    # regex to find <blockquote><p>{stuff}</p></blockquote>.
    # replace stuff with Makeup.highlight(stuff)
    source = "<code class=\"elixir\">IO.puts \“Hello World\”</code>"

    expected =
      "<pre class=\"highlight\"><code><span class=\"nc\">IO</span><span class=\"o\">.</span><span class=\"n\">puts</span><span class=\"w\"> </span><span class=\"err\">“</span><span class=\"nc\">Hello</span><span class=\"w\"> </span><span class=\"nc\">World</span><span class=\"err\">”</span></code></pre>"

    assert Syntax.highlight(source) == expected
  end

  test "highlight/1 quotes and special characters" do
    # regex to find <blockquote><p>{stuff}</p></blockquote>.
    # replace stuff with Makeup.highlight(stuff)
    source = "<code class=\"elixir\">\"</code>"

    expected =
      "<code class=\"elixir\"><pre class=\"highlight\"><code><span class=\"err\">\"</span></code></pre></code>"

    assert Syntax.highlight(source) == expected
  end

  test "highlight/1 code with newlines" do
    # regex to find <blockquote><p>{stuff}</p></blockquote>.
    # replace stuff with Makeup.highlight(stuff)
    source = "<code class=\"elixir\">8\n8</code>"

    expected =
      "<code class=\"elixir\"><pre class=\"highlight\"><code><span class=\"mi\">8</span><span class=\"w\">\n</span><span class=\"mi\">8</span></code></pre></code>"

    assert Syntax.highlight(source) == expected
  end

  test("highlight/1 multiple code blocks") do
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
