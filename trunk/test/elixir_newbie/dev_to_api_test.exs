defmodule ElixirNewbie.DevToAPITest do
  use ExUnit.Case
  alias ElixirNewbie.{DevToAPI, BlogPost}

  @tag :prod
  test "get" do
    assert [%BlogPost{body_markdown: body_markdown} | _] = DevToAPI.get()
    assert is_bitstring(body_markdown)
  end
end
