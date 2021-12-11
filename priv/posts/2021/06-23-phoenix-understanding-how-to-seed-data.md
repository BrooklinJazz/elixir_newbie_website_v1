%{
  title: "Phoenix: Understanding how to seed data.",
  tags: ~w(elixir phoenix seeds),
  description: "Leverage test fixtures, Ex Machina, and Faker to create high-quality test and development data.",
  cover_image: "06-23-phoenix-understanding-how-to-seed-data.jpeg"
}
---

What is seeding?
----------------

Seeding is the initial creation of data in your database typically run before your tests or to create a convenient developer or QA testing environment. Though, you can seed in a production or other environment as well.

Why should you care?
--------------------

By learning how to create seed data effectively, you can dramatically improve your tests' reliability, reusability, and readability.

More importantly, you will improve the speed and quality of your development cycle to release more features and fewer bugs.

Examples using [the demo blog application](https://github.com/BrooklinJazz/phoenix_seeding)
===========================================================================================

All of the following concepts and examples can be applied in any phoenix application. If you like, you can see all of the code samples In the [example blog application.](https://github.com/BrooklinJazz/phoenix_seeding)

Global Seed Data
================

In any phoenix application generated using mix, you should have a `seed.exs` file.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*EMluhu87PpYX8l_HTptgCw.png" width="700" height="435" srcSet="https://miro.medium.com/max/552/1*EMluhu87PpYX8l_HTptgCw.png 276w, https://miro.medium.com/max/1104/1*EMluhu87PpYX8l_HTptgCw.png 552w, https://miro.medium.com/max/1280/1*EMluhu87PpYX8l_HTptgCw.png 640w, https://miro.medium.com/max/1400/1*EMluhu87PpYX8l_HTptgCw.png 700w" sizes="700px" role="presentation"/>

You can create data in this file that you want to pre-exist for all of your tests or in your development environment.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*KBEJaaG9eBa4hCdDXTaOCg.png" width="700" height="424" srcSet="https://miro.medium.com/max/552/1*KBEJaaG9eBa4hCdDXTaOCg.png 276w, https://miro.medium.com/max/1104/1*KBEJaaG9eBa4hCdDXTaOCg.png 552w, https://miro.medium.com/max/1280/1*KBEJaaG9eBa4hCdDXTaOCg.png 640w, https://miro.medium.com/max/1400/1*KBEJaaG9eBa4hCdDXTaOCg.png 700w" sizes="700px" role="presentation"/>

Notice the `Repo.delete_all(Post)` line. Unless you want the seed file to re-create existing data over and over, you might want to consider deleting any data that already exists so that your seed data is consistent.

You can run the seed file using:

```elixir
mix run priv/repo/seeds.exs
```

Make you are in the correct environment when running your seed data.

```elixir
\# on mac or linux:  
MIX_ENV="test" mix run priv/repo/seeds.exs # for test env  
MIX_ENV="dev" mix run priv/repo/seeds.exs # for dev env\# On windows you'll have to set the env first using either: $env:MIX_ENV="test"  
$env:MIX_ENV="dev"\# then run the seed command like normal  
mix run priv/repo/seeds.exs
```

Configure different test and dev seed files.
--------------------------------------------

The `seed.exs` file is automatically configured to run in the `mix ecto.setup` alias.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*RZoG1me9qxgPlXa7X9_llw.png" width="700" height="376" srcSet="https://miro.medium.com/max/552/1*RZoG1me9qxgPlXa7X9_llw.png 276w, https://miro.medium.com/max/1104/1*RZoG1me9qxgPlXa7X9_llw.png 552w, https://miro.medium.com/max/1280/1*RZoG1me9qxgPlXa7X9_llw.png 640w, https://miro.medium.com/max/1400/1*RZoG1me9qxgPlXa7X9_llw.png 700w" sizes="700px" role="presentation"/>

You can configure different behaviors for your global seed file depending on what environment you are in using the `Mix.env()` variable.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*fDJjCsCCxI2MxbuVP2z8MQ.png" width="700" height="510" srcSet="https://miro.medium.com/max/552/1*fDJjCsCCxI2MxbuVP2z8MQ.png 276w, https://miro.medium.com/max/1104/1*fDJjCsCCxI2MxbuVP2z8MQ.png 552w, https://miro.medium.com/max/1280/1*fDJjCsCCxI2MxbuVP2z8MQ.png 640w, https://miro.medium.com/max/1400/1*fDJjCsCCxI2MxbuVP2z8MQ.png 700w" sizes="700px" role="presentation"/>

If you’d like this global data in your tests, you can add the command to run your seed file to your `mix test` alias.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*PilOTjqNku8jtQeBHLvfnw.png" width="700" height="360" srcSet="https://miro.medium.com/max/552/1*PilOTjqNku8jtQeBHLvfnw.png 276w, https://miro.medium.com/max/1104/1*PilOTjqNku8jtQeBHLvfnw.png 552w, https://miro.medium.com/max/1280/1*PilOTjqNku8jtQeBHLvfnw.png 640w, https://miro.medium.com/max/1400/1*PilOTjqNku8jtQeBHLvfnw.png 700w" sizes="700px" role="presentation"/>

Make other seed files.
----------------------

There's nothing special about the `seed.exs` file so that you can make other seed files. In this blog app example, you might want to have a different seed file to add five posts for you.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*Cp1WU0Tt_7tiJ0X-FiYySg.png" width="700" height="337" srcSet="https://miro.medium.com/max/552/1*Cp1WU0Tt_7tiJ0X-FiYySg.png 276w, https://miro.medium.com/max/1104/1*Cp1WU0Tt_7tiJ0X-FiYySg.png 552w, https://miro.medium.com/max/1280/1*Cp1WU0Tt_7tiJ0X-FiYySg.png 640w, https://miro.medium.com/max/1400/1*Cp1WU0Tt_7tiJ0X-FiYySg.png 700w" sizes="700px" role="presentation"/>

You would run this file using:

```elixir
mix run .\\priv\\repo\\five_blog_posts.exs
```

Realistic fake data using Faker.
================================

[Faker](https://github.com/elixirs/faker) is an elixir library for creating fake data. This is useful when you want to create realistic data to test your application. For example, in the [demo blogging application](https://github.com/BrooklinJazz/phoenix_seeding), It would be convenient to generate long, medium, and short content.

*   Install [Faker](https://github.com/elixirs/faker): likely you’ll have to add an up-to-date version of the following in your mix dependencies:

```elixir
{:faker, "~> 0.16", only: :test}
```

Faker recommends you only have the faker module in the test environment. However, since we’re seeding data for dev testing, you may also want to have it for the dev environment.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*PnCvgVleo30CukYO4ELFmQ.png" width="700" height="535" srcSet="https://miro.medium.com/max/552/1*PnCvgVleo30CukYO4ELFmQ.png 276w, https://miro.medium.com/max/1104/1*PnCvgVleo30CukYO4ELFmQ.png 552w, https://miro.medium.com/max/1280/1*PnCvgVleo30CukYO4ELFmQ.png 640w, https://miro.medium.com/max/1400/1*PnCvgVleo30CukYO4ELFmQ.png 700w" sizes="700px" role="presentation"/>

The installation steps on Faker likely also say to add `Faker.start()` to your test_helper file.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1226/1*px--9Jzqbiuc-wnuxZGIAQ.png" width="613" height="226" srcSet="https://miro.medium.com/max/552/1*px--9Jzqbiuc-wnuxZGIAQ.png 276w, https://miro.medium.com/max/1104/1*px--9Jzqbiuc-wnuxZGIAQ.png 552w, https://miro.medium.com/max/1226/1*px--9Jzqbiuc-wnuxZGIAQ.png 613w" sizes="613px" role="presentation"/>

Make sure the faker dependency is installed by running `mix deps.get.`

Once Faker is installed, You can use it to generate fake data conveniently. I’ll cover the most useful modules, but check out their [documentation](https://hexdocs.pm/faker/api-reference.html) if you want to see everything Faker can do.

Faker Lorem
-----------

Generate words, sentences, and paragraphs with complete control over the size of your content. Lorem is short for “Lorem Ipsum”, which is a common way to generate fake text.

```
alias Faker.Lorem \# fake word with 5 characters  
Lorem.characters(5)   
\# fake word with between 5 to 10 characters  
Lorem.characters(5..10)\# fake sentence with 5 words  
Lorem.sentence(5)  
\# fake sentence with between 5 to 10 words  
Lorem.sentence(5..10)\# fake paragraph with 5 sentences  
Lorem.paragraph(5)  
\# fale paragraph with 5 to 10 sentences  
Lorem.paragraph(5..10)\# fake list with 5 paragraphs joined in a string  
Lorem.paragraphs(5) |> Enum.join("\\n")  
\# fake list with between 5 to 10 paragraphs joined in a string  
Lorem.paragraphs(5..10) |> Enum.join("\\n")
```

You could use this to improve the `five_blog_posts.exs` seed file from before.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*9aHnGVcxxKHnDe4VqvZmLQ.png" width="700" height="331" srcSet="https://miro.medium.com/max/552/1*9aHnGVcxxKHnDe4VqvZmLQ.png 276w, https://miro.medium.com/max/1104/1*9aHnGVcxxKHnDe4VqvZmLQ.png 552w, https://miro.medium.com/max/1280/1*9aHnGVcxxKHnDe4VqvZmLQ.png 640w, https://miro.medium.com/max/1400/1*9aHnGVcxxKHnDe4VqvZmLQ.png 700w" sizes="700px" role="presentation"/>

Faker Person
------------

Generate names for a person

```elixir
alias Faker.PersonPerson.first_name() "Elizabeth"  
Person.last_name() "Hayes"  
Person.name() "Mr. Bianka Ryan"  
Faker.Person.prefix() "Mr."  
Faker.Person.title() "Dynamic Identity Administrator"
```

Faker Address
-------------

Generate pseudo-realistic addresses

```
alias Faker.AddressAddress.country() # "Gibraltar"  
Address.state() # "Kansas"  
Address.city() # "East Casey"  
Address.postcode() # "84979"
```

Faker Internet
--------------

Generate internet-related data such as emails, images, links, usernames, and IP addresses

```elixir
Faker.Internet.email() "elizabeth2056@rolfson.net"  
Faker.Internet.image_url() "https://placehold.it/936x936"  
Faker.Internet.url() "http://sipes.com"  
Faker.Internet.user_name() "elizabeth2056"
```

Custom test fixtures modules and test fixture functions
=======================================================

When you first create a phoenix context, you are provided with test fixture functions to help you in testing.

For example, when you run:

```elixir
mix phx.gen.html Posts Post posts title:string content:text
```

A file will be generated that looks something like this.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*v0yheWefwAE9llzPz8HhLQ.png" width="700" height="520" srcSet="https://miro.medium.com/max/552/1*v0yheWefwAE9llzPz8HhLQ.png 276w, https://miro.medium.com/max/1104/1*v0yheWefwAE9llzPz8HhLQ.png 552w, https://miro.medium.com/max/1280/1*v0yheWefwAE9llzPz8HhLQ.png 640w, https://miro.medium.com/max/1400/1*v0yheWefwAE9llzPz8HhLQ.png 700w" sizes="700px" role="presentation"/>

Test fixture functions are a great way to create some data for tests local to the same test file.

the `post_fixture` function creates a post so that you can test the Posts.list_posts() function. Even better, the data is only created for this test and not others. So there are no side effects on other tests causing hard to debug test interaction.

Reusing test fixture functions
------------------------------

This is great, but what if you have another test file that needs the post_fixture?

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*-T3yEvKn5iaWMChfEU4EiA.png" width="700" height="263" srcSet="https://miro.medium.com/max/552/1*-T3yEvKn5iaWMChfEU4EiA.png 276w, https://miro.medium.com/max/1104/1*-T3yEvKn5iaWMChfEU4EiA.png 552w, https://miro.medium.com/max/1280/1*-T3yEvKn5iaWMChfEU4EiA.png 640w, https://miro.medium.com/max/1400/1*-T3yEvKn5iaWMChfEU4EiA.png 700w" sizes="700px" role="presentation"/>

Rewriting this would be a lot of duplication! A simple way to reuse test fixture functions is to move them to a single test fixture module that you can `use` in your test file.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*g832UkIXbs8mCgYwD9wUkA.png" width="700" height="404" srcSet="https://miro.medium.com/max/552/1*g832UkIXbs8mCgYwD9wUkA.png 276w, https://miro.medium.com/max/1104/1*g832UkIXbs8mCgYwD9wUkA.png 552w, https://miro.medium.com/max/1280/1*g832UkIXbs8mCgYwD9wUkA.png 640w, https://miro.medium.com/max/1400/1*g832UkIXbs8mCgYwD9wUkA.png 700w" sizes="700px" role="presentation"/>

Then `use` the PostsFixture in any files where you want to access the `@valid_attrs, @update_attrs, or @invalid_attrs` values or the `post_fixture` function.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/978/1*3tvjpEtQVRHZsKVwJ34qng.png" width="489" height="322" srcSet="https://miro.medium.com/max/552/1*3tvjpEtQVRHZsKVwJ34qng.png 276w, https://miro.medium.com/max/978/1*3tvjpEtQVRHZsKVwJ34qng.png 489w" sizes="489px" role="presentation"/>

For an explanation on `use` and `__using__` check out [Elixir Schools’ lesson](https://elixirschool.com/en/lessons/basics/modules/#use).

Factories using Ex Machina
==========================

If using your own custom test fixtures and Faker data isn’t enough, you may want to consider using the Ex Machina elixir library for a convenient test data infrastructure. Note that Ex Machina uses the term “factory” instead of “fixture”.

*   [Install Ex Machina](https://github.com/thoughtbot/ex_machina): Follow the repo installation instructions for the most up-to-date installation steps.

Ex Machina factory module
-------------------------

Once you have Ex Machina installed, you’ll want to set up a factory module.  
the factory module will `use` the ExMachina module.

```elixir
defmodule Blog.Factory do  
     use ExMachina.Ecto, repo: Blog.Repo  
end
```

Ex Machina factory functions
----------------------------

The factory module contains factory functions which must end in `_factory` due to how Ex Machina works under the hood.

```elixir
def post_factory do  
    %Post{  
      title: Example Title,  
      content: "Example Content"  
    }  
end
```

Factory functions can also be derived from other factory functions using `struct!`

```elixir
\# derived factory  
  def long_post_factory do  
    struct!(  
      post_factory(),  
      %{  
        content: Faker.Lorem.paragraphs(5..10) |> Enum.join("\\n")  
      }  
    )  
 end
```

Sequence
--------

Ex Machina provides the `sequence` function to increment the string or list you provide every time you call a factory function.

```elixir
sequence("Name") # Name0  
sequence("Name") # Name1
```

`sequence` can also be called with an atom and a list to cycle through a list of values.

```elixir
sequence(:role, \["admin", "member", "superuser"\]) # admin  
sequence(:role, \["admin", "member", "superuser"\]) # member  
sequence(:role, \["admin", "member", "superuser"\]) # superuser
```

Insert
------

In your test or seed files, these factory functions can be used with the `insert` functions provided by Ex Machina. `insert` takes an atom as an argument. The atom should match the function name before `_factory` . For example, `post_factory` is used with `:post`.

```elixir
insert(:post) #  inserts  %Blog.Posts.Post{  
                __meta__: #Ecto.Schema.Metadata<:built,"posts">,  
                title: "Example Title0",  
                content: "Example Content0",  
                inserted_at: nil,  
                updated_at: nil  
              } into the database
```

Putting it all together
=======================

Putting everything you learned about Ex Machina, test fixtures, and Faker together, here’s an example factory and usage in a test for the demo blogging app.

Defining the factory
--------------------

Notice that `sequence` can take a list of any value you want. In this case, I’m using Faker and `sequence` to cycle between long, medium, and short content.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*9VPuYqv0MJxAIZFId-mqDA.png" width="700" height="664" srcSet="https://miro.medium.com/max/552/1*9VPuYqv0MJxAIZFId-mqDA.png 276w, https://miro.medium.com/max/1104/1*9VPuYqv0MJxAIZFId-mqDA.png 552w, https://miro.medium.com/max/1280/1*9VPuYqv0MJxAIZFId-mqDA.png 640w, https://miro.medium.com/max/1400/1*9VPuYqv0MJxAIZFId-mqDA.png 700w" sizes="700px" role="presentation"/>

Create a test with the factory
------------------------------

Import the factory into your test file to gain access to the `insert` function provided by Ex Machina.

<img alt="" class="t u v km aj" src="https://miro.medium.com/max/1400/1*wqW2G8TGO9ogNclGjTAYUQ.png" width="700" height="429" srcSet="https://miro.medium.com/max/552/1*wqW2G8TGO9ogNclGjTAYUQ.png 276w, https://miro.medium.com/max/1104/1*wqW2G8TGO9ogNclGjTAYUQ.png 552w, https://miro.medium.com/max/1280/1*wqW2G8TGO9ogNclGjTAYUQ.png 640w, https://miro.medium.com/max/1400/1*wqW2G8TGO9ogNclGjTAYUQ.png 700w" sizes="700px" role="presentation"/>

Conclusion
==========

You have learned to improve your phoenix data seeding reliability, reusability, and readability by leveraging custom test fixture modules, test fixture functions, Ex Machina, and Faker.

I hope you found this article useful and are excited to apply what you learned to your next or current project.

If you have any questions or comments, please let me know by posting a reply; I’d be happy to get back to you!

Further Reading
---------------

*   [Ex Machina Repo](https://github.com/thoughtbot/ex_machina) and [Ex Machina Docs](https://hexdocs.pm/ex_machina/ExMachina.html)
*   [Phoenix Seeding Data Docs](https://hexdocs.pm/phoenix/1.3.0-rc.1/seeding_data.html)
*   [Faker Docs](https://hexdocs.pm/faker/api-reference.html)
*   [Example Blogging Application using Faker and Ex Machina](https://github.com/BrooklinJazz/phoenix_seeding)