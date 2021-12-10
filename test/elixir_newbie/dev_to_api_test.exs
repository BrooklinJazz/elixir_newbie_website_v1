defmodule ElixirNewbie.DevToAPITest do
  use ExUnit.Case
  alias ElixirNewbie.Post
  alias ElixirNewbie.DevToAPI

  @tag :prod
  test "get" do
    assert [%Post{markdown: markdown} | _] = DevToAPI.get()
    assert is_bitstring(markdown)
  end
end
