defmodule ElixirNewbie.Stats.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :post_id, :string
    field :reads, :integer
    field :views, :integer

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:views, :reads, :post_id])
    |> validate_required([:views, :reads, :post_id])
  end
end
