defmodule Factory do
  @moduledoc """
  Factory handles data creation for tests.
  """

  def string, do: Faker.String.base64()
end
