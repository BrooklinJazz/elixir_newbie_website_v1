defmodule ElixirNewbie.BlogPost do
  @moduledoc """
  Schema used to cast blogs from API into consistent structs
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "blog_post" do
    field(:typeof, :string)
    field(:title, :string)
    field(:description, :string)
    field(:cover_image, :string)
    field(:published, :boolean)
    field(:published_at, :utc_datetime)
    field(:tag_list, {:array, :string})
    field(:body_markdown, :string)
  end

  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, [
      :typeof,
      :title,
      :description,
      :cover_image,
      :published,
      :published_at,
      :tag_list,
      :body_markdown
    ])
    |> validate_acceptance(:published)
  end

  def cast(params \\ %{}) do
    params |> changeset() |> apply_changes()
  end
end
