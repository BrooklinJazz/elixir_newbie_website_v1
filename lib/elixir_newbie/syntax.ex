defmodule ElixirNewbie.Syntax do
  @moduledoc """
  Highlight Code Snippets
  """
  def highlight(source) do
    Regex.replace(
      ~r/<code class=\".*\">(?s)(.*?)<\/code>/,
      source,
      fn _, x ->
        x
        |> decode_special_characters()
        |> Makeup.highlight()
      end
    )
  end

  def decode_special_characters(html_string) do
    # Unfortunately, the html coming in has escaped special characters.
    # There MUST be better way, but this works for now.
    html_string
    |> String.replace("&quot;", "\"")
    |> String.replace("&gt;", ">")
    |> String.replace("&lt;", "<")
    |> String.replace("&amp;", "&")
  end
end
