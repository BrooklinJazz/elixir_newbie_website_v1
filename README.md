# ElixirNewbie

Elixir Newbie is a podcast about what it's like being new to Elixir. I (Brooklin Myers) share my experience, document my process, and summarize what I learn to help and encourage new Elixir developers.

If you're new to github here's how to get started: https://www.freecodecamp.org/news/git-and-github-for-beginners/

## Prerequisites
- [WSL for WINDOWS USERS](https://docs.microsoft.com/en-us/windows/wsl/install)
- [asdf](http://asdf-vm.com/guide/getting-started.html#_1-install-dependencies)
- [Phoenix Installation](https://hexdocs.pm/phoenix/installation.html#content)
- [Postgresql](https://hexdocs.pm/phoenix/installation.html#postgresql)

## Running the Project
- clone the git repo with
- check .tool-versions for the current node, elixir, and erlang plugins.
- asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
- asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
- asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
- install elixir/erlang/node from .tool-versions with asdf `asdf install`
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Run `npm install` in `/assets`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Running livebook
These instructions use Escript to run livebook.
- [Livebook](https://github.com/livebook-dev/livebook#escript)
- If you have livebook installed as an Escript, you can run `livebook server` locally.

Now you can visit [`localhost:8080`](http://localhost:8080) from your browser.
click on the `livebook` folder to view articles.
