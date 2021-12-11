%{
  title: "Ecto with Phoenix in 4 Minutes.",
  tags: ~w(elixir phoenix),
  description: "Learn How To Handle Data Persistence and Validation in Phoenix with Ecto.",
  cover_image: "08-16-ecto-with-phoenix-in-4-minutes.png"
}
---

Ecto.Schema
===========

A schema is a definition of how your program models your data. For example, you might have a user schema that validates that all users must have a name, an email, and a password.

An Ecto Schema is used to map and validate data from one source into an Elixir Struct. Structs are extensions built on top of maps that provide compile-time checks and default values.

Here’s an example of a Blog Post schema using Ecto.Schema:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*xTHrG1_SPGHLBuyRusEGWQ.png" width="700" height="402" srcSet="https://miro.medium.com/max/552/1*xTHrG1_SPGHLBuyRusEGWQ.png 276w, https://miro.medium.com/max/1104/1*xTHrG1_SPGHLBuyRusEGWQ.png 552w, https://miro.medium.com/max/1280/1*xTHrG1_SPGHLBuyRusEGWQ.png 640w, https://miro.medium.com/max/1400/1*xTHrG1_SPGHLBuyRusEGWQ.png 700w" sizes="700px" role="presentation"/>

You can create the same schema by making a new phoenix project through the mix terminal command.

```elixir
mix phx.new projectname
```

Then create a post model using the mix phoenix generator:

```elixir
mix phx.gen.html Blog Post posts title:string content:text.
```

the `schema` method comes from the `Ecto.Schema` module. It takes the schema name and defines fields for the schema. the `field` method takes in a field name and field data type.

Ecto.Repo
=========

`Ecto.Repo` is a repository is a layer above your database. The `Ecto.Repo` acts as an adapter for the database. The repository layer handles all communication between your application and the database. By default `Ecto.Repo` comes with an adapter for PostgreSQL, which knows how to store data in the PostgreSQL database.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*XMNxK26R80f8TSVxTa97TA.png" width="700" height="156" srcSet="https://miro.medium.com/max/552/1*XMNxK26R80f8TSVxTa97TA.png 276w, https://miro.medium.com/max/1104/1*XMNxK26R80f8TSVxTa97TA.png 552w, https://miro.medium.com/max/1280/1*XMNxK26R80f8TSVxTa97TA.png 640w, https://miro.medium.com/max/1400/1*XMNxK26R80f8TSVxTa97TA.png 700w" sizes="700px" role="presentation"/>

The `Ecto.Repo` provides methods like `all` to interact with the underlying repository and database.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*nhQwvB_od0tAwz-3i2xV1Q.png" width="700" height="533" srcSet="https://miro.medium.com/max/552/1*nhQwvB_od0tAwz-3i2xV1Q.png 276w, https://miro.medium.com/max/1104/1*nhQwvB_od0tAwz-3i2xV1Q.png 552w, https://miro.medium.com/max/1280/1*nhQwvB_od0tAwz-3i2xV1Q.png 640w, https://miro.medium.com/max/1400/1*nhQwvB_od0tAwz-3i2xV1Q.png 700w" sizes="700px" role="presentation"/>

`Repo.all` takes in a query. In this case, it takes in the Post schema, which is just a short syntax for:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*pd6MyQaoqyTh_gYORAB8yw.png" width="700" height="68" srcSet="https://miro.medium.com/max/552/1*pd6MyQaoqyTh_gYORAB8yw.png 276w, https://miro.medium.com/max/1104/1*pd6MyQaoqyTh_gYORAB8yw.png 552w, https://miro.medium.com/max/1280/1*pd6MyQaoqyTh_gYORAB8yw.png 640w, https://miro.medium.com/max/1400/1*pd6MyQaoqyTh_gYORAB8yw.png 700w" sizes="700px" role="presentation"/>

`from(p in Post)` is a query to grab all of the posts from the database.

Ecto.Query
==========

Ecto also handles building queries for your database. Queries are used to retrieve and manipulate data from a repository. The query is passed to Ecto.Repo methods to handle retrieving or storing data in the database.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*P0NG8KUegskxPl7v25I4HA.jpeg" width="700" height="561" srcSet="https://miro.medium.com/max/552/1*P0NG8KUegskxPl7v25I4HA.jpeg 276w, https://miro.medium.com/max/1104/1*P0NG8KUegskxPl7v25I4HA.jpeg 552w, https://miro.medium.com/max/1280/1*P0NG8KUegskxPl7v25I4HA.jpeg 640w, https://miro.medium.com/max/1400/1*P0NG8KUegskxPl7v25I4HA.jpeg 700w" sizes="700px" role="presentation"/>

from
----

The `from` method comes from the Ecto.Query module. It allows you to select a particular schema to query from the repository. In this case, the Post schema.

where
-----

where allows you to filter in only objects that match a condition. For example, you might query for a specific post where the title is “specific title.”

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*NzS-p8CPqnGoprgAuJQe2w.png" width="700" height="68" srcSet="https://miro.medium.com/max/552/1*NzS-p8CPqnGoprgAuJQe2w.png 276w, https://miro.medium.com/max/1104/1*NzS-p8CPqnGoprgAuJQe2w.png 552w, https://miro.medium.com/max/1280/1*NzS-p8CPqnGoprgAuJQe2w.png 640w, https://miro.medium.com/max/1400/1*NzS-p8CPqnGoprgAuJQe2w.png 700w" sizes="700px" role="presentation"/>

select
------

select allows you to query for only specific values instead of the entire struct. For example, you might only care to get a list of post titles.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*VAz8TrsHpz4JLNia4nqi8g.png" width="700" height="69" srcSet="https://miro.medium.com/max/552/1*VAz8TrsHpz4JLNia4nqi8g.png 276w, https://miro.medium.com/max/1104/1*VAz8TrsHpz4JLNia4nqi8g.png 552w, https://miro.medium.com/max/1280/1*VAz8TrsHpz4JLNia4nqi8g.png 640w, https://miro.medium.com/max/1400/1*VAz8TrsHpz4JLNia4nqi8g.png 700w" sizes="700px" role="presentation"/>

join
----

To query relationships on the schema, use join. For example, if you also want to get the comments that belong to the post.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*E7y4rau-kiqKcn21sisFFw.png" width="700" height="69" srcSet="https://miro.medium.com/max/552/1*E7y4rau-kiqKcn21sisFFw.png 276w, https://miro.medium.com/max/1104/1*E7y4rau-kiqKcn21sisFFw.png 552w, https://miro.medium.com/max/1280/1*E7y4rau-kiqKcn21sisFFw.png 640w, https://miro.medium.com/max/1400/1*E7y4rau-kiqKcn21sisFFw.png 700w" sizes="700px" role="presentation"/>

Ecto supports two different syntaxes for creating queries. All the examples above use **keywords query syntax.** The alternative syntax is **pipe-based syntax.**

Pipe-based syntax
-----------------

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*Ts0plUZCEYjGfDib7ZHyhA.png" width="700" height="146" srcSet="https://miro.medium.com/max/552/1*Ts0plUZCEYjGfDib7ZHyhA.png 276w, https://miro.medium.com/max/1104/1*Ts0plUZCEYjGfDib7ZHyhA.png 552w, https://miro.medium.com/max/1280/1*Ts0plUZCEYjGfDib7ZHyhA.png 640w, https://miro.medium.com/max/1400/1*Ts0plUZCEYjGfDib7ZHyhA.png 700w" sizes="700px" role="presentation"/>

Final Thoughts
==============

Ecto enables data validation and persistence in phoenix applications. You have learned how to model your data using Ecto.Schema, how to communicate with the database using Ecto.Repo, and how to build queries for the database using Ecto.Query.