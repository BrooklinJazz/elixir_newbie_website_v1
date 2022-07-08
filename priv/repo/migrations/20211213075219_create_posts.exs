defmodule ElixirNewbie.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :views, :integer
      add :reads, :integer
      add :post_id, :string

      timestamps()
    end
  end
end
