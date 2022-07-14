defmodule ElixirNewbie.TwitterTest do
  use ExUnit.Case, async: true
  alias ElixirNewbie.Twitter

  test "get/0" do
    assert [%{"id" => _, "text" => _, "created_at" => _, "author" => _} | _] = Twitter.get()
  end

  test "get_author/1" do
    author_id = "1429815729533198339"

    assert %{"id" => _, "username" => _, "name" => _} = Twitter.get_author(author_id)
  end
end
