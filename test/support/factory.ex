defmodule Factory do
  alias ElixirNewbie.BlogPost

  def string, do: Faker.String.base64()

  def blog_post(attrs \\ %{}) do
    %BlogPost{title: string()}
  end
end
