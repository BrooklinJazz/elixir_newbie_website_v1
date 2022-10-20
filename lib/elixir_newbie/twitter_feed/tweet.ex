defmodule ElixirNewbie.TwitterFeed.Tweet do
  @enforce_keys [
    :id,
    :text,
    :created_at,
    :author_username,
    :author_name,
    :author_image,
    :author_verified
  ]
  defstruct @enforce_keys
end
