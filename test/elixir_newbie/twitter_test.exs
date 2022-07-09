defmodule ElixirNewbie.TwitterTest do
  use ExUnit.Case, async: true
  alias ElixirNewbie.Twitter

  test "ping api" do
    result = Twitter.get()
    assert result
    assert is_list(result)
    assert [tweet | _tail] = result
    assert %{"id" => id, "text" => text} = tweet
    assert is_bitstring(text)
    assert is_bitstring(id)
    assert text =~ ~r/#ElixirNewbie/i
  end
end
