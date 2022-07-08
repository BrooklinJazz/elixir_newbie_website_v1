defmodule ElixirNewbie.StatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirNewbie.Stats` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        post_id: "some post_id",
        reads: 42,
        views: 42
      })
      |> ElixirNewbie.Stats.create_post()

    post
  end
end
