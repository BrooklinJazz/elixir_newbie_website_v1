ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ElixirNewbie.Repo, :manual)
ExUnit.configure(exclude: [:prod, :skip])
Mox.defmock(ElixirNewbie.MockBlogAPI, for: ElixirNewbie.BlogAPI)
Application.put_env(:elixir_newbie, :blog_api, ElixirNewbie.MockBlogAPI)