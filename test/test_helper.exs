ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ElixirNewbie.Repo, :manual)
ExUnit.configure(exclude: [:prod, :skip])

Mox.defmock(TwitterBehaviourMock, for: ElixirNewbie.TwitterFeed.TwitterClientBehaviour)
Application.put_env(:elixir_newbie, :twitter_client, TwitterBehaviourMock)
