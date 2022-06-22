defmodule ElixirNewbie.StatsTest do
  use ElixirNewbie.DataCase, async: true

  alias ElixirNewbie.Stats
  alias ElixirNewbie.Blog

  describe "posts" do
    alias ElixirNewbie.Stats.Post

    import ElixirNewbie.StatsFixtures

    @invalid_attrs %{post_id: nil, reads: nil, views: nil}

    test "for_post creates empty stats for post" do
      [post | _] = Blog.all_posts()
      post_id = post.id
      assert {:ok, %{post_id: ^post_id, views: 0, reads: 0}} = Stats.for_post(post.id)
    end

    test "view increments stats for post" do
      [post | _] = Blog.all_posts()
      post_id = post.id
      assert {:ok, %Stats.Post{} = post_stats} = Stats.view(post.id)
      assert %{post_id: ^post_id, views: 1, reads: 0} = post_stats
      assert {:ok, %Stats.Post{} = post_stats} = Stats.view(post.id)
      assert %{post_id: ^post_id, views: 2, reads: 0} = post_stats
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Stats.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Stats.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{post_id: "some post_id", reads: 42, views: 42}

      assert {:ok, %Post{} = post} = Stats.create_post(valid_attrs)
      assert post.post_id == "some post_id"
      assert post.reads == 42
      assert post.views == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{post_id: "some updated post_id", reads: 43, views: 43}

      assert {:ok, %Post{} = post} = Stats.update_post(post, update_attrs)
      assert post.post_id == "some updated post_id"
      assert post.reads == 43
      assert post.views == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_post(post, @invalid_attrs)
      assert post == Stats.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Stats.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Stats.change_post(post)
    end
  end
end
