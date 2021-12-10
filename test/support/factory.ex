defmodule Factory do
  @moduledoc """
  Factory handles data creation for tests.
  """
  alias ElixirNewbie.Post

  def string, do: Faker.String.base64()

  def blog_post do
    %Post{title: string()}
  end
end
