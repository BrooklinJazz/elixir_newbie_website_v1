defmodule ElixirNewbie.Post do
  @moduledoc """
  Schema used to cast blogs from API into consistent structs
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "blog_post" do
    field(:title, :string)
    field(:subtitle, :string)
    field(:slug, :string)
    field(:description, :string)
    field(:cover_image, :string)
    field(:published, :boolean)
    field(:published_at, :date)
    field(:tags, {:array, :string})
    field(:markdown, :string)
  end

  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, [
      :title,
      :subtitle,
      :slug,
      :description,
      :cover_image,
      :published,
      :published_at,
      :tags,
      :markdown
    ])

    # |> validate_acceptance(:published)
  end

  def cast(params \\ %{}) do
    params |> changeset() |> apply_changes()
  end
end
