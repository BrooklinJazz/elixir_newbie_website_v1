defmodule ElixirNewbie.Syntax do
  # \<code\ class=\"elixir\"\>(.+)\<\/code>
  def highlight(source) do
    Regex.replace(
      ~r/\<code\ class=\"elixir\"\>(.+)\<\/code>/,
      source,
      fn _, x ->
        "<code class=\"elixir\">#{Makeup.highlight(x)}</code>"
      end
    )
  end
end
