%{
  title: "The ‘use’ Macro in Elixir.",
  tags: ~w(elixir macros),
  description: "How to use 'use' and 'using' usefully in your modules",
  cover_image: "09-27-the-use-macro-in-elixir.jpeg"
}
---

The ‘use’ Macro in Elixir.
==========================

Information on 'use' is Hard to Find.
===========================================

I found learning ‘use’ unintuitive. Partially because I think it’s hard to find documentation for.

*   **‘use’ is not searchable:** Google searching “how to use ‘**_use’_** in elixir” doesn’t return much information.
*   **‘use’ is hidden in the elixir documentation:** It’s in the Elixir documentation for alias, require, and import.
*   **There is no example for __using__ in a module**: The elixir documentation states that ‘use’ calls the __using__ callback, but there’s no example implementation of this callback.

Also not trying to bash elixir documentation, the docs are fantastic. ❤

So What Is ‘use’?
=================

here’s a lightweight explanation of ‘use’ in elixir as I currently understand it.

*   Use is a tool to reuse code just like require, import, and alias.
*   Use simply calls the __using__ macro defined in another module.
*   The __using__ macro allows you to inject code into another module.

You can define a module with the __using__ macro and any code inside of the quote block will be injected into the module. like so:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1178/1*cXLWCKEnScwRLIwrRgz4Vw.png" width="589" height="218" srcSet="https://miro.medium.com/max/552/1*cXLWCKEnScwRLIwrRgz4Vw.png 276w, https://miro.medium.com/max/1104/1*cXLWCKEnScwRLIwrRgz4Vw.png 552w, https://miro.medium.com/max/1178/1*cXLWCKEnScwRLIwrRgz4Vw.png 589w" sizes="589px" role="presentation"/>

The quote block allows you to inject code to be evaluated at The app can then ‘use’ the Example module.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1252/1*t2wx2wbfRjhW6HKuASOu8g.png" width="626" height="130" srcSet="https://miro.medium.com/max/552/1*t2wx2wbfRjhW6HKuASOu8g.png 276w, https://miro.medium.com/max/1104/1*t2wx2wbfRjhW6HKuASOu8g.png 552w, https://miro.medium.com/max/1252/1*t2wx2wbfRjhW6HKuASOu8g.png 626w" sizes="626px" role="presentation"/>

Code inside the __using__ module is injected into App. So if you define a function inside of the quote block:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*zUO1arhfvX6ojiEkq1CIZw.png" width="700" height="241" srcSet="https://miro.medium.com/max/552/1*zUO1arhfvX6ojiEkq1CIZw.png 276w, https://miro.medium.com/max/1104/1*zUO1arhfvX6ojiEkq1CIZw.png 552w, https://miro.medium.com/max/1280/1*zUO1arhfvX6ojiEkq1CIZw.png 640w, https://miro.medium.com/max/1400/1*zUO1arhfvX6ojiEkq1CIZw.png 700w" sizes="700px" role="presentation"/>

Now the injected function can be used inside of the App module.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1314/1*EF6Q3K6o27O7oZr5Im9yvA.png" width="657" height="218" srcSet="https://miro.medium.com/max/552/1*EF6Q3K6o27O7oZr5Im9yvA.png 276w, https://miro.medium.com/max/1104/1*EF6Q3K6o27O7oZr5Im9yvA.png 552w, https://miro.medium.com/max/1280/1*EF6Q3K6o27O7oZr5Im9yvA.png 640w, https://miro.medium.com/max/1314/1*EF6Q3K6o27O7oZr5Im9yvA.png 657w" sizes="657px" role="presentation"/>

Why ‘use’ Instead of Import?
============================

Looking at the above example, you might wonder why you should use ‘use’ instead of import. Import allows you to import all of the functions from a module, so you could accomplish the same goal like so:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*tsbWcr7SiaZ_s8JmRlGBdw.png" width="700" height="246" srcSet="https://miro.medium.com/max/552/1*tsbWcr7SiaZ_s8JmRlGBdw.png 276w, https://miro.medium.com/max/1104/1*tsbWcr7SiaZ_s8JmRlGBdw.png 552w, https://miro.medium.com/max/1280/1*tsbWcr7SiaZ_s8JmRlGBdw.png 640w, https://miro.medium.com/max/1400/1*tsbWcr7SiaZ_s8JmRlGBdw.png 700w" sizes="700px" role="presentation"/>

However, ‘use’ allows you to inject more than just functions, you can also inject other alias’s, imports, and even inject other ‘use’ modules.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*jO_UN34QqE_2bj2bCh-y6A.png" width="700" height="297" srcSet="https://miro.medium.com/max/552/1*jO_UN34QqE_2bj2bCh-y6A.png 276w, https://miro.medium.com/max/1104/1*jO_UN34QqE_2bj2bCh-y6A.png 552w, https://miro.medium.com/max/1280/1*jO_UN34QqE_2bj2bCh-y6A.png 640w, https://miro.medium.com/max/1400/1*jO_UN34QqE_2bj2bCh-y6A.png 700w" sizes="700px" role="presentation"/>

Now the InjectedAlias module can be used in the App module.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*3qqPfwhLckG3Ag4fEysbcA.png" width="700" height="260" srcSet="https://miro.medium.com/max/552/1*3qqPfwhLckG3Ag4fEysbcA.png 276w, https://miro.medium.com/max/1104/1*3qqPfwhLckG3Ag4fEysbcA.png 552w, https://miro.medium.com/max/1280/1*3qqPfwhLckG3Ag4fEysbcA.png 640w, https://miro.medium.com/max/1400/1*3qqPfwhLckG3Ag4fEysbcA.png 700w" sizes="700px" role="presentation"/>

Use Allows You to Create Templates.
-----------------------------------

Have a common pattern? use allows you to codify the pattern into a template for making other modules.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/582/1*BsLtWdl6nld0xy3eIQtRNg.png" width="291" height="61" srcSet="https://miro.medium.com/max/552/1*BsLtWdl6nld0xy3eIQtRNg.png 276w, https://miro.medium.com/max/582/1*BsLtWdl6nld0xy3eIQtRNg.png 291w" sizes="291px" role="presentation"/>

Use is powerful and dangerous. It’s great when you have a reusable pattern you want to abstract away in your codebase. However, its strength is also its weakness. If you overuse the ‘use’ macro, you might hide too much of the complexity of your system and make it difficult to understand.

How Phoenix Leverages ‘use’.
============================

Phoenix is a powerful example of how to leverage ‘use.’

Phoenix has common patterns. These patterns are provided out of the box in any phoenix application and include controllers, views, live views, channels, and more. If you aren’t familiar with Phoenix, that’s ok. It’s enough to know these are common patterns in a phoenix application.

These are all templates you can leverage to make routers, controllers, views, etc.

Nothing in code is magic, and all of the code to power these templates is in your application.

Phoenix applications have a Web module. It’s typically named <appname>Web, so I will generically refer to it as the Web module.

The Web module in your phoenix application leverages the __using__ macro.  
with atoms passed in to inject the functionality for the different templates for :controller, :live_view, :view. :router etc.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*cTVeLnrtrjEzfKbIgfE3vA.png" width="700" height="161" srcSet="https://miro.medium.com/max/552/1*cTVeLnrtrjEzfKbIgfE3vA.png 276w, https://miro.medium.com/max/1104/1*cTVeLnrtrjEzfKbIgfE3vA.png 552w, https://miro.medium.com/max/1280/1*cTVeLnrtrjEzfKbIgfE3vA.png 640w, https://miro.medium.com/max/1400/1*cTVeLnrtrjEzfKbIgfE3vA.png 700w" sizes="700px" role="presentation"/>

So when you create a new router like so:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*sBvM_p3wTAlOOZqa4DSP8g.png" width="700" height="104" srcSet="https://miro.medium.com/max/552/1*sBvM_p3wTAlOOZqa4DSP8g.png 276w, https://miro.medium.com/max/1104/1*sBvM_p3wTAlOOZqa4DSP8g.png 552w, https://miro.medium.com/max/1280/1*sBvM_p3wTAlOOZqa4DSP8g.png 640w, https://miro.medium.com/max/1400/1*sBvM_p3wTAlOOZqa4DSP8g.png 700w" sizes="700px" role="presentation"/>

You inject the code from the Web module’s __using__ macro, which calls the router function in the Web module:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*2AkZ-gg2RNXpClPoCNX7hQ.png" width="700" height="192" srcSet="https://miro.medium.com/max/552/1*2AkZ-gg2RNXpClPoCNX7hQ.png 276w, https://miro.medium.com/max/1104/1*2AkZ-gg2RNXpClPoCNX7hQ.png 552w, https://miro.medium.com/max/1280/1*2AkZ-gg2RNXpClPoCNX7hQ.png 640w, https://miro.medium.com/max/1400/1*2AkZ-gg2RNXpClPoCNX7hQ.png 700w" sizes="700px" role="presentation"/>

This quote block injects the code inside of it to call the Phoenix.Router module’s __using__ macro and inject the functionality for a Phoenix Router. That’s a 1000+ line file, so I won’t paste it in, but you can check out the Phoenix.Router module in your phoenix application if you are curious.

From start to finish, here’s a diagram to help you understand.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/882/1*_dUhElh9WbNqSTy9tRtSCQ.png" width="441" height="301" srcSet="https://miro.medium.com/max/552/1*_dUhElh9WbNqSTy9tRtSCQ.png 276w, https://miro.medium.com/max/882/1*_dUhElh9WbNqSTy9tRtSCQ.png 441w" sizes="441px" role="presentation"/>

You don’t need to understand how phoenix applications leverage ‘use’ to create controllers, channels, views, etc. However, by including a more complex use case, I hope you can see the power of the ‘use’ macro.

Summary
=======

Anytime you have a common pattern you want to repeat for modules, you can consider ‘use.’ For other cases, you should consider sticking with alias, require, and import. However, be cautious not to overuse the ‘use’ macro because it can hide functionality and behavior.

Use ‘use’ usefully by using __using__.

I’m sorry I had to sneak in one more.