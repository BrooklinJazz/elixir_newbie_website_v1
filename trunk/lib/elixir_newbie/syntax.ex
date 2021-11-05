defmodule ElixirNewbie.Syntax do
  def highlight(source) do
    Regex.replace(
      ~r/<code class=\"elixir\">(?s)(.*?)<\/code>/,
      source,
      fn _, x ->
        # Unfortunately, the html coming in has escaped special characters.
        # There MUST be better way, but this works for now.
        x
        |> String.replace("&quot;", "\"")
        |> String.replace("&gt;", ">")
        |> String.replace("&lt;", "<")
        |> String.replace("&amp;", "&")
        # I'm not sure that | is working
        |> Makeup.highlight()
      end
    )
  end
end
