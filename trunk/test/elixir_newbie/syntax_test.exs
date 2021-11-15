defmodule ElixirNewbie.SyntaxTest do
  use ExUnit.Case
  alias ElixirNewbie.Syntax

  test "highlight/1 one code block" do
    source = "<code class=\"elixir\">8</code>"

    expected = "<pre class=\"highlight\"><code><span class=\"mi\">8</span></code></pre>"

    assert Syntax.highlight(source) == expected
  end

  test "highlight/1 quotes" do
    source = "<code class=\"elixir\">\"</code>"

    expected = "<pre class=\"highlight\"><code><span class=\"err\">&quot;</span></code></pre>"

    assert Syntax.highlight(source) == expected
  end

  test "highlight/1 code with newlines" do
    source = "<code class=\"elixir\">8\n8</code>"

    expected =
      "<pre class=\"highlight\"><code><span class=\"mi\">8</span><span class=\"w\">\n</span><span class=\"mi\">8</span></code></pre>"

    assert Syntax.highlight(source) == expected
  end

  test("highlight/1 multiple code blocks") do
    source = "
      <code class=\"elixir\">8</code>
      <code class=\"elixir\">8</code>
      <code class=\"elixir\">8</code>
    "

    expected = "
      <pre class=\"highlight\"><code><span class=\"mi\">8</span></code></pre>
      <pre class=\"highlight\"><code><span class=\"mi\">8</span></code></pre>
      <pre class=\"highlight\"><code><span class=\"mi\">8</span></code></pre>
    "

    assert Syntax.highlight(source) == expected
  end
end
