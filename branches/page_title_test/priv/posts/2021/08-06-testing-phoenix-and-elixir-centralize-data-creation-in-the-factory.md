%{
  title: "Testing Phoenix and Elixir: Centralize Data Creation in the Factory.",
  tags: ~w(elixir phoenix testing),
  description: "How to Centralize Data Creation in Your Factory With Examples.",
  cover_image: "08-06-testing-phoenix-and-elixir-centralize-data-creation-in-the-factory.jpeg"
}
---

> Jeffrey Matthias, the coauthor with Andrea Leopardi of [Testing Elixir: Effective and Robust Testing for Elixir and its Ecosystem](https://pragprog.com/titles/lmelixir/testing-elixir/), hosted a recent talk on building maintainable test factories that I had the pleasure to attend.
> 
> This article expands on a point originally discussed in my previous article: [How to Build Maintainable Test Factories in Elixir and Phoenix.](https://brooklinmyers.medium.com/how-to-build-maintainable-test-factories-in-elixir-and-phoenix-84312998f7e7)

What is a Factory?
==================

Factories in Elixir are modules that handle inserting data into your database. They can also be responsible for handling the generation of any test-related data. [Ex Machina](https://github.com/thoughtbot/ex_machina) is a popular library for creating factories. However, you can also build your own from scratch.

This article assumes you have some knowledge of testing Phoenix and/or Elixir with a Factory. If you want a brief overview of factories in Elixir, I wrote about [factories and other methods of seeding data in phoenix.](https://www.elixirnewbie.com/blog/phoenix-understanding-how-to-seed-data)

What is centralized data creation?
==================================

By putting all of your methods to generate relevant data for your tests in your factory or factories, rather than putting them anywhere in your codebase, you can centralize all of your data creation in a single place.

Why centralize data creation?
=============================

By centralizing data creation in the factory, you provide a single, convenient interface where all test data is created. So, for example, if you need to generate emails, names, addresses, or even booleans for your tests, you only have a single place to generate emails in the factory, rather than multiple different methods spread across the codebase.

Your factory can expose public methods for generating data that can be used throughout the codebase. This way, if the data changes, it only needs to be updated in a single place.

Incidental Data vs. Intentional Data.
=====================================

Intentional data is data that your tests rely on the value of. You should explicitly pass intentional data into your factory method rather than relying on hidden values. Conversely, incidental data is data that the specific value of does not matter, so long as the value is valid. Consider randomizing incidental data, so your tests don’t rely on hidden assumptions and catch potential side effects.

How do you centralize data creation?
====================================

If you are working on a Phoenix or Elixir project and using factories, you may have multiple places where you generate the same type of data differently.

<img alt="" class="t u v jb aj" src="https://miro.medium.com/max/1400/1*YECeOxlko9KoOJNw8RNm3A.jpeg" width="700" height="467" srcSet="https://miro.medium.com/max/552/1*YECeOxlko9KoOJNw8RNm3A.jpeg 276w, https://miro.medium.com/max/1104/1*YECeOxlko9KoOJNw8RNm3A.jpeg 552w, https://miro.medium.com/max/1280/1*YECeOxlko9KoOJNw8RNm3A.jpeg 640w, https://miro.medium.com/max/1400/1*YECeOxlko9KoOJNw8RNm3A.jpeg 700w" sizes="700px" role="presentation"/>

Photo by [Alina Grubnyak](https://unsplash.com/@alinnnaaaa?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

Create A Public Method in the Factory.
--------------------------------------

Some common data most applications need are emails, phone numbers, names, and addresses. You might have multiple ways in your application to generate these values.

For example, on my current project, we have multiple ways of creating emails in our factory.

Commonly we use ExMachina’s sequence method to create a list of emails (email-1@test.com, email-2@test.com, etc.) in order.

<img alt="" class="t u v jb aj" src="https://miro.medium.com/max/1400/1*PUgge7y1Ohk2fNPnWhuEaw.png" width="700" height="179" srcSet="https://miro.medium.com/max/552/1*PUgge7y1Ohk2fNPnWhuEaw.png 276w, https://miro.medium.com/max/1104/1*PUgge7y1Ohk2fNPnWhuEaw.png 552w, https://miro.medium.com/max/1280/1*PUgge7y1Ohk2fNPnWhuEaw.png 640w, https://miro.medium.com/max/1400/1*PUgge7y1Ohk2fNPnWhuEaw.png 700w" sizes="700px" role="presentation"/>

In the same project, we also sometimes use Faker for emails. Faker is a library that provides utility methods for generating fake data.

<img alt="" class="t u v jb aj" src="https://miro.medium.com/max/1400/1*k4oOsaH4D-l0T_iVsfawjA.png" width="700" height="156" srcSet="https://miro.medium.com/max/552/1*k4oOsaH4D-l0T_iVsfawjA.png 276w, https://miro.medium.com/max/1104/1*k4oOsaH4D-l0T_iVsfawjA.png 552w, https://miro.medium.com/max/1280/1*k4oOsaH4D-l0T_iVsfawjA.png 640w, https://miro.medium.com/max/1400/1*k4oOsaH4D-l0T_iVsfawjA.png 700w" sizes="700px" role="presentation"/>

We also sometimes use static values for emails.

<img alt="" class="t u v jb aj" src="https://miro.medium.com/max/1400/1*4ps4dNHcD2YDdPJq45gyKQ.png" width="700" height="41" srcSet="https://miro.medium.com/max/552/1*4ps4dNHcD2YDdPJq45gyKQ.png 276w, https://miro.medium.com/max/1104/1*4ps4dNHcD2YDdPJq45gyKQ.png 552w, https://miro.medium.com/max/1280/1*4ps4dNHcD2YDdPJq45gyKQ.png 640w, https://miro.medium.com/max/1400/1*4ps4dNHcD2YDdPJq45gyKQ.png 700w" sizes="700px" role="presentation"/>

However, to centralize data generation, you ideally want a single method for generating a type of data. In this case, an email.

To start, I added the following method to our Factory. I chose to use Faker for emails instead of sequence because it provides more randomization.

<img alt="" class="t u v jb aj" src="https://miro.medium.com/max/1400/1*pfsj0h8DVJlqWycSxiERcA.png" width="700" height="59" srcSet="https://miro.medium.com/max/552/1*pfsj0h8DVJlqWycSxiERcA.png 276w, https://miro.medium.com/max/1104/1*pfsj0h8DVJlqWycSxiERcA.png 552w, https://miro.medium.com/max/1280/1*pfsj0h8DVJlqWycSxiERcA.png 640w, https://miro.medium.com/max/1400/1*pfsj0h8DVJlqWycSxiERcA.png 700w" sizes="700px" role="presentation"/>

And now, whenever we need to generate an email, we can use this method. Here’s the same user code from before but using the Factory Method.

> side note: I haven’t yet extracted the name value, only the email.

<img alt="" class="t u v jb aj" src="https://miro.medium.com/max/1360/1*r6PvKI-PnoHi1qL0tRb9Gw.png" width="680" height="171" srcSet="https://miro.medium.com/max/552/1*r6PvKI-PnoHi1qL0tRb9Gw.png 276w, https://miro.medium.com/max/1104/1*r6PvKI-PnoHi1qL0tRb9Gw.png 552w, https://miro.medium.com/max/1280/1*r6PvKI-PnoHi1qL0tRb9Gw.png 640w, https://miro.medium.com/max/1360/1*r6PvKI-PnoHi1qL0tRb9Gw.png 680w" sizes="680px" role="presentation"/>

Now the way we create emails is consistent throughout the application. If our understanding of valid and invalid emails changes, then we only need to change the data generation method in a single place rather than many.

Given this example with an email, you could do the same for any common data you use in your application.

Factory Templates.
==================

If you have multiple factories in your application, you might consider extracting your data generation methods into a single factory template module so that your factories can share that code.

<img alt="" class="t u v jb aj" src="https://miro.medium.com/max/1400/1*N-ZPiTUGV0MBRlCayfLrWQ.jpeg" width="700" height="412" srcSet="https://miro.medium.com/max/552/1*N-ZPiTUGV0MBRlCayfLrWQ.jpeg 276w, https://miro.medium.com/max/1104/1*N-ZPiTUGV0MBRlCayfLrWQ.jpeg 552w, https://miro.medium.com/max/1280/1*N-ZPiTUGV0MBRlCayfLrWQ.jpeg 640w, https://miro.medium.com/max/1400/1*N-ZPiTUGV0MBRlCayfLrWQ.jpeg 700w" sizes="700px" role="presentation"/>

Photo by [Aleksey Boev](https://unsplash.com/@alanveob?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/stamp?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

We are currently using a single factory in our application, but as we grow, we will split our large factory into smaller ones.

If you find yourself in that place, you might consider making a factory template module with your common data generation functions, which you can use in your separate factory modules.

Future Plans.
=============

I want to practice what I learned from Jeffrey’s talk, so I plan to start by centralizing data creation. From there, the next step is to randomize incidental data. We still have plenty of places where we use static data instead of random data.

I hope you learned something from my experience trying to centralize data generation in my current project! Also, I hope to share more of what I learned about writing maintainable factories for elixir applications in the future.