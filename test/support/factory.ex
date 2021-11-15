defmodule Factory do
  @moduledoc """
  Factory handles data creation for tests.
  """
  alias ElixirNewbie.BlogPost

  def string, do: Faker.String.base64()

  def blog_post do
    %BlogPost{title: string()}
  end
end
