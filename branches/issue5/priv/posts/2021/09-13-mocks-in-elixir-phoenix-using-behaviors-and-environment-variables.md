%{
  title: "Mocks in Elixir/Phoenix using Behaviors and Environment variables.",
  tags: ~w(elixir phoenix testing mocks),
  description: "With Real World Examples Mocking SMS with Twilio.",
  cover_image: "09-13-mocks-in-elixir-phoenix-using-behaviors-and-environment-variables.jpeg"
}
---

Mocks simulate real-world behavior for the sake of convenient testing.

José Valim wrote an excellent piece on [mocks and explicit contracts](https://dashbit.co/blog/mocks-and-explicit-contracts), and I recently had to opportunity to implement a Twilio Mock on my current project. I’ll share the experience of taking his advice and putting it to practice so that you can do the same.

The Goal
========

The goal is to use a Twilio Sms Mock  to verify and send. Rather than use the Twilio API directly, we don’t want to rely on external APIs in our non-production environments for a variety of reasons:

*   Introduces flakiness and a reliance on network connectivity
*   Slows down tests that need to wait for the response
*   Avoid coupling code directly to the library in case we change libraries.
*   Working directly with a library that can send real SMS text messages is risky.

The Design
==========

We can set an environment variable in phoenix to point to the module we want to use depending on the environment.

Abstractly, there’s the parent module and the environment-specific modules it delegates to.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/562/1*dX2eGNQnfWI_dYoRX5Zcxw.png" width="281" height="151" srcSet="https://miro.medium.com/max/552/1*dX2eGNQnfWI_dYoRX5Zcxw.png 276w, https://miro.medium.com/max/562/1*dX2eGNQnfWI_dYoRX5Zcxw.png 281w" sizes="281px" role="presentation"/>

The rest of your application will use the parent module and never directly use the environment-specific modules. This avoids using the prod module directly, which could be disastrous 😰

In my specific use case, we want a single Sms module for the rest of the application to access. This module will delegate to either the production module or the mock module.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/842/1*LLqrN5EqOCZ50pzNKcxvyg.png" width="421" height="212" srcSet="https://miro.medium.com/max/552/1*LLqrN5EqOCZ50pzNKcxvyg.png 276w, https://miro.medium.com/max/842/1*LLqrN5EqOCZ50pzNKcxvyg.png 421w" sizes="421px" role="presentation"/>

Access and Set Environment Variables.
=====================================

You can set environment variables in phoenix by adding them to your environment’s config file.

To Set An Environment Variable.
-------------------------------

Add the following to an environment config file.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1206/1*nxD71VOTS1dhUrBPmyAYRw.png" width="603" height="84" srcSet="https://miro.medium.com/max/552/1*nxD71VOTS1dhUrBPmyAYRw.png 276w, https://miro.medium.com/max/1104/1*nxD71VOTS1dhUrBPmyAYRw.png 552w, https://miro.medium.com/max/1206/1*nxD71VOTS1dhUrBPmyAYRw.png 603w" sizes="603px" role="presentation"/>

*   **:app_name** should be your applications name
*   **sms_service** is the env variable name. It can be any valid name you want.
*   **App.Sms.MockSms** is the SMS module you want to use for that environment. In dev.exs and test.exs, it should be MockSms, and in prod.exs it should be ProdSms

To Retrieve an Environment Variable.
------------------------------------

You can access environment variables with `Application.get_env`

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*xzmz0HJfecsqdDkkRbgu6A.png" width="700" height="200" srcSet="https://miro.medium.com/max/552/1*xzmz0HJfecsqdDkkRbgu6A.png 276w, https://miro.medium.com/max/1104/1*xzmz0HJfecsqdDkkRbgu6A.png 552w, https://miro.medium.com/max/1280/1*xzmz0HJfecsqdDkkRbgu6A.png 640w, https://miro.medium.com/max/1400/1*xzmz0HJfecsqdDkkRbgu6A.png 700w" sizes="700px" role="presentation"/>

Create The Prod and Mock Modules.
=================================

Both modules should have the same interface. This means they must define the same common public methods.

Here’s an example prod module.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*o0xNLTr8N1lBbeGRdBr_EA.png" width="700" height="401" srcSet="https://miro.medium.com/max/552/1*o0xNLTr8N1lBbeGRdBr_EA.png 276w, https://miro.medium.com/max/1104/1*o0xNLTr8N1lBbeGRdBr_EA.png 552w, https://miro.medium.com/max/1280/1*o0xNLTr8N1lBbeGRdBr_EA.png 640w, https://miro.medium.com/max/1400/1*o0xNLTr8N1lBbeGRdBr_EA.png 700w" sizes="700px" role="presentation"/>

Here’s an example mock module.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1344/1*FO8SNvG-2s4pFO0UJXapkA.png" width="672" height="426" srcSet="https://miro.medium.com/max/552/1*FO8SNvG-2s4pFO0UJXapkA.png 276w, https://miro.medium.com/max/1104/1*FO8SNvG-2s4pFO0UJXapkA.png 552w, https://miro.medium.com/max/1280/1*FO8SNvG-2s4pFO0UJXapkA.png 640w, https://miro.medium.com/max/1344/1*FO8SNvG-2s4pFO0UJXapkA.png 672w" sizes="672px" role="presentation"/>

The mock module skips sending messages and does soft validation on the phone number so that tests using invalid phone numbers will still return an error.

You don’t need to understand the implementation code to set up your own production and mock modules.

Your production and mock modules will differ from mine, depending on what you’re using this pattern for.

Delegate to the Prod and Mock Modules.
======================================

Now that you have production and mock modules defined, your parent module can delegate to them.

Here’s an example using the main Sms module.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*xh8iJyIXXXWILUO4mGMvbg.png" width="700" height="327" srcSet="https://miro.medium.com/max/552/1*xh8iJyIXXXWILUO4mGMvbg.png 276w, https://miro.medium.com/max/1104/1*xh8iJyIXXXWILUO4mGMvbg.png 552w, https://miro.medium.com/max/1280/1*xh8iJyIXXXWILUO4mGMvbg.png 640w, https://miro.medium.com/max/1400/1*xh8iJyIXXXWILUO4mGMvbg.png 700w" sizes="700px" role="presentation"/>

Test the Prod Module.
=====================

To make sure your prod module continues to work, you can implement tests that specifically use the module.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1150/1*rSGv3ic42PNBTs5KqzNu4g.png" width="575" height="397" srcSet="https://miro.medium.com/max/552/1*rSGv3ic42PNBTs5KqzNu4g.png 276w, https://miro.medium.com/max/1104/1*rSGv3ic42PNBTs5KqzNu4g.png 552w, https://miro.medium.com/max/1150/1*rSGv3ic42PNBTs5KqzNu4g.png 575w" sizes="575px" role="presentation"/>

However, you likely don’t want to run these tests as part of your normal suit, so you can tag them using @moduletag and exclude them from your normal tests.

To exclude the :sms tag, you can add this line in your test_helpers.exs.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*_BfMblWmhlI7Iyz4TgP5mA.png" width="700" height="48" srcSet="https://miro.medium.com/max/552/1*_BfMblWmhlI7Iyz4TgP5mA.png 276w, https://miro.medium.com/max/1104/1*_BfMblWmhlI7Iyz4TgP5mA.png 552w, https://miro.medium.com/max/1280/1*_BfMblWmhlI7Iyz4TgP5mA.png 640w, https://miro.medium.com/max/1400/1*_BfMblWmhlI7Iyz4TgP5mA.png 700w" sizes="700px" role="presentation"/>

You can then run these tests when needed using the include or only tags. You can learn about those in my article on [useful test commands and tags](https://www.elixirnewbie.com/blog/phoenix-elixir-testing-beyond-mix-test).

Final Thoughts.
===============

Now that you have the parent module set up, you can use that in your normal tests.

José Valim went into deeper detail on all sorts of different patterns for using mocks. For further reading, I recommend [his article on mocks and explicit contracts.](https://dashbit.co/blog/mocks-and-explicit-contracts)

Just make sure you aren’t using your mock module in prod, otherwise, it might not send 😜