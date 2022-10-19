# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :elixir_newbie,
  ecto_repos: [ElixirNewbie.Repo]

# Configures the endpoint
config :elixir_newbie, ElixirNewbieWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ElixirNewbieWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirNewbie.PubSub,
  live_view: [signing_salt: "gCvUdwJW"]

config :sentry,
  dsn: "https://df6ba02885794db9b4e2c283dd7d1bea@o1107808.ingest.sentry.io/6134958",
  included_environments: [:prod],
  environment_name: Mix.env()

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :elixir_newbie, ElixirNewbie.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :elixir_newbie, TwitterClientImpl,
  twitter_base_url: "https://api.twitter.com",
  search_recent_path: "/2/tweets/search/recent?query=",
  search_recent_fields:
    "&tweet.fields=author_id,created_at,geo,id,text&expansions=author_id,geo.place_id&user.fields=id,name,profile_image_url,username,verified&place.fields=full_name",
  bearer_token: ""

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
