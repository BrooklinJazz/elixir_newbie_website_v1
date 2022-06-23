defmodule ElixirNewbie.Stats do
  @moduledoc """
  The Stats context.
  """

  import Ecto.Query, warn: false
  alias ElixirNewbie.Repo

  alias ElixirNewbie.Stats.Post

  @spec for_post(String.t()) :: {:ok, %Post{}}
  def for_post(post_id) do
    case Repo.get_by(Post, post_id: post_id) do
      nil ->
        %Post{}
        |> Post.changeset(%{post_id: post_id, views: 0, reads: 0})
        |> Repo.insert()

      post ->
        {:ok, post}
    end
  end

  def view(post_id) do
    case for_post(post_id) do
      {:ok, post} ->
        update_post(post, %{views: post.views + 1})
    end
  end

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
