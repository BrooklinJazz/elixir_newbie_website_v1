%{
  title: "Installation Guide for Elixir & Phoenix on Windows 10",
  tags: ~w(elixir phoenix hackathons),
  description: "Version 1.5.9",
  cover_image: "06-05-elixir-phoenix-v1.5.9-getting-started-on-windows-10.jpg"
}
---

Elixir & Phoenix v1.5.9 getting started on Windows 10.
======================================================

Prerequisites
=============

To run a Phoenix project on your Windows 10 machine, you should install:

*   Node js
*   Elixir & Erlang
*   Hex
*   The Phoenix application generator
*   PostgreSQL

Install Node
------------

You probably already have Node if you’re working on other projects, but if not, you can download a node installer for Windows 10.

*   Download the [Node Installer for Windows](https://nodejs.org/en/download/)

Install Elixir and Erlang
-------------------------

You can install Elixir and Erlang by downloading an installer or using chocolatey (a package manager for windows)

*   use the [Elixir Installer](https://github.com/elixir-lang/elixir-windows-setup/releases/download/v2.1/elixir-websetup.exe)
*   or install [Chocolatey](https://chocolatey.org/install#individual) and in your PowerShell run:

```elixir
cinst elixir
```

Install Hex
-----------

*   In your PowerShell run:

```elixir
mix local.hex
```

Install Phoenix application generator
-------------------------------------

*   In your PowerShell run:

```elixir
mix archive.install hex phx_new 1.5.9
```

Install PostgreSQL
------------------

PostgreSQL is a database management tool. Later you will configure it with Ecto in Phoenix to run your project’s database.

*   [Download PostgreSQL](https://www.postgresql.org/download/windows/)

Make sure to remember the password you choose for your PostgreSQL superuser. You will use this password to configure the phoenix dev.exs file later.

<img alt="" class="t u v kk aj" src="https://miro.medium.com/max/1360/1*y-6UVzRiXnLziiFTN5W8yg.png" width="680" height="529" srcSet="https://miro.medium.com/max/552/1*y-6UVzRiXnLziiFTN5W8yg.png 276w, https://miro.medium.com/max/1104/1*y-6UVzRiXnLziiFTN5W8yg.png 552w, https://miro.medium.com/max/1280/1*y-6UVzRiXnLziiFTN5W8yg.png 640w, https://miro.medium.com/max/1360/1*y-6UVzRiXnLziiFTN5W8yg.png 680w" sizes="680px" role="presentation"/>

After installing PostgreSQL, you might be prompted to use the Stack Application Builder to install other add-on software. For the phoenix project, you do not need any other packages and can skip this dialogue.

You may need to restart your computer after you install PostgreSQL.

Start a new Phoenix Project.
============================

Now that you have the prerequisites installed, you can generate and configure a new phoenix project. Once you’re done this section, you will have a newly created Phoenix project running on localhost:4000

<img alt="" class="t u v kk aj" src="https://miro.medium.com/max/1400/1*QO2ell8FtOuzWc577G8PnA.png" width="700" height="394" srcSet="https://miro.medium.com/max/552/1*QO2ell8FtOuzWc577G8PnA.png 276w, https://miro.medium.com/max/1104/1*QO2ell8FtOuzWc577G8PnA.png 552w, https://miro.medium.com/max/1280/1*QO2ell8FtOuzWc577G8PnA.png 640w, https://miro.medium.com/max/1400/1*QO2ell8FtOuzWc577G8PnA.png 700w" sizes="700px" role="presentation"/>

Generate a new Phoenix project
------------------------------

*   In your PowerShell run:

```elixir
mix phx.new project_name
```

you can replace project_name with whatever you want your new project to be. Phoenix only allows project names with lowercase letters, numbers, and underscores.

Install modules
---------------

*   In your PowerShell inside of the /assets folder, run:

```elixir
npm install
```

Here I got an error.

```
Can't find Python executable "python", you can set the PYTHON env variable.
```

However, I do have python on my computer. I found [other developers having the issue](https://elixirforum.com/t/npm-installation-for-fresh-phoenixliveview-project-failing-in-windows-10/37170) and discovered the node-sass library caused this. If you have the same issue, you can replace node-sass with sass to fix the problem

*   go into your assets/package.json and replace the node-sass package with sass.

<img alt="" class="t u v kk aj" src="https://miro.medium.com/max/1400/1*TJGakVZ6t1UNDcLgnhrQQw.png" width="700" height="106" srcSet="https://miro.medium.com/max/552/1*TJGakVZ6t1UNDcLgnhrQQw.png 276w, https://miro.medium.com/max/1104/1*TJGakVZ6t1UNDcLgnhrQQw.png 552w, https://miro.medium.com/max/1280/1*TJGakVZ6t1UNDcLgnhrQQw.png 640w, https://miro.medium.com/max/1400/1*TJGakVZ6t1UNDcLgnhrQQw.png 700w" sizes="700px" role="presentation"/>

*   In your PowerShell inside of the /assets folder run

```
npm install
```

Run webpack
-----------

*   In your PowerShell in the /assets folder, run:

```
node node_modules/webpack/bin/webpack.js --mode development
```

Configure your Ecto Database with PostgreSQL
--------------------------------------------

Ecto handles data validation and persistence for Phoenix projects. It has built-in integration for PostgreSQL by default. It can also work with other database tools such as MySQL and MSSQL.

*   In your dev.exs file, change the password and username to match your PostgreSQL superuser. I made my password `supersecret` for the sake of this article, and the default username for PostgreSQL is postgres.

<img alt="" class="t u v kk aj" src="https://miro.medium.com/max/1196/1*VcJ9Dfg-G1Zc4wImKgcl9A.png" width="598" height="172" srcSet="https://miro.medium.com/max/552/1*VcJ9Dfg-G1Zc4wImKgcl9A.png 276w, https://miro.medium.com/max/1104/1*VcJ9Dfg-G1Zc4wImKgcl9A.png 552w, https://miro.medium.com/max/1196/1*VcJ9Dfg-G1Zc4wImKgcl9A.png 598w" sizes="598px" role="presentation"/>

Create your Ecto database
-------------------------

*   In your PowerShell run:

```elixir
mix ecto.create
```

Hopefully, this should run successfully. However, If you get a connection refused error, you probably have a PostgreSQL issue. Likely you either have the wrong password, or PostgreSQL is not properly installed.

Start the server
----------------

*   In your PowerShell run:

```elixir
mix phx.server
```

Open the project in your browser
--------------------------------

*   Open your preferred browser (I use Google Chrome)
*   go to localhost:4000

You should see your project up and running!

<img alt="" class="t u v kk aj" src="https://miro.medium.com/max/1400/1*QO2ell8FtOuzWc577G8PnA.png" width="700" height="394" srcSet="https://miro.medium.com/max/552/1*QO2ell8FtOuzWc577G8PnA.png 276w, https://miro.medium.com/max/1104/1*QO2ell8FtOuzWc577G8PnA.png 552w, https://miro.medium.com/max/1280/1*QO2ell8FtOuzWc577G8PnA.png 640w, https://miro.medium.com/max/1400/1*QO2ell8FtOuzWc577G8PnA.png 700w" sizes="700px" role="presentation"/>

I hope this helped you get your phoenix project up and running!