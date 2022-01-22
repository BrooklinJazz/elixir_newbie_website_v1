# ElixirNewbie

Elixir Newbie is a podcast about what it's like being new to Elixir. I (Brooklin Myers) share my experience, document my process, and summarize what I learn to help and encourage new Elixir developers.

## Prerequisites
- [WSL for WINDOWS USERS](https://docs.microsoft.com/en-us/windows/wsl/install)
- [asdf](http://asdf-vm.com/guide/getting-started.html#_1-install-dependencies)
- [Phoenix Installation](https://hexdocs.pm/phoenix/installation.html#content)
- [Postgresql](https://hexdocs.pm/phoenix/installation.html#postgresql)

## Quick Start

To start your Phoenix server
  * check .tool-versions for the current node, elixir, and erlang plugins. 
  * asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  * asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  * asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  * install elixir/erlang/node from .tool-versions with asdf `asdf install`
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Trouble Shooting
  * for Windows users, this project is recommended to run with WSL