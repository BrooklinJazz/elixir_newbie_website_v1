%{
  title: "Phoenix/Elixir: Chain Composable Queries with Ecto Named Bindings.",
  tags: ~w(elixir phoenix ecto),
  description: "Make Easily Composable and Reusable Queries.",
  cover_image: "08-27-phoenix-elixir-chain-composable-queries-with-ecto-named-bindings.jpeg"
}
---

In my earlier article, [Ecto with Phoenix in 4 Minutes](https://www.elixirnewbie.com/blog/ecto-with-phoenix-in-4-minutes), I summarized how Ecto handles data persistence and validation in your phoenix app. If you would like a refresher on Ecto queries, I recommend you start there.

What are composable queries?
============================

Composable queries are a way of building queries to your database such that you can combine them.

For example, let’s pretend you are building a blog app. You may wish to query posts for a variety of reasons. For example, you might want to find all posts for a particular author, written in a certain year, with a certain tag, etc.

Normally with Ecto, that code looks something like this:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*bNr6jQ5e25YtpHl4U34VmA.png" width="700" height="153" srcSet="https://miro.medium.com/max/552/1*bNr6jQ5e25YtpHl4U34VmA.png 276w, https://miro.medium.com/max/1104/1*bNr6jQ5e25YtpHl4U34VmA.png 552w, https://miro.medium.com/max/1280/1*bNr6jQ5e25YtpHl4U34VmA.png 640w, https://miro.medium.com/max/1400/1*bNr6jQ5e25YtpHl4U34VmA.png 700w" sizes="700px" role="presentation"/>

Writing reusable chainable query methods saves you from rewriting similar code over and over. So you can refactor the above into:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*Bk3kHPHsuwbiLkL8J9B4cQ.png" width="700" height="157" srcSet="https://miro.medium.com/max/552/1*Bk3kHPHsuwbiLkL8J9B4cQ.png 276w, https://miro.medium.com/max/1104/1*Bk3kHPHsuwbiLkL8J9B4cQ.png 552w, https://miro.medium.com/max/1280/1*Bk3kHPHsuwbiLkL8J9B4cQ.png 640w, https://miro.medium.com/max/1400/1*Bk3kHPHsuwbiLkL8J9B4cQ.png 700w" sizes="700px" role="presentation"/>

Composable Queries
==================

Query methods like `join`, `select`, and `where` take in a query and return another query.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*-CTv2VlFjgz47r7FxVRgXg.png" width="700" height="190" srcSet="https://miro.medium.com/max/552/1*-CTv2VlFjgz47r7FxVRgXg.png 276w, https://miro.medium.com/max/1104/1*-CTv2VlFjgz47r7FxVRgXg.png 552w, https://miro.medium.com/max/1280/1*-CTv2VlFjgz47r7FxVRgXg.png 640w, https://miro.medium.com/max/1400/1*-CTv2VlFjgz47r7FxVRgXg.png 700w" sizes="700px" role="presentation"/>

Thus you can compose them together, typically using Pipe-based syntax.

Pipe-based syntax
-----------------

Pipe-based syntax in Ecto composes queries together, passing the query through a series of query methods. Here’s an example using multiple `join` calls to add the author, comments, and tags for a list of posts:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*Ei9JPjF4ydGMSmsSDFJbAA.png" width="700" height="176" srcSet="https://miro.medium.com/max/552/1*Ei9JPjF4ydGMSmsSDFJbAA.png 276w, https://miro.medium.com/max/1104/1*Ei9JPjF4ydGMSmsSDFJbAA.png 552w, https://miro.medium.com/max/1280/1*Ei9JPjF4ydGMSmsSDFJbAA.png 640w, https://miro.medium.com/max/1400/1*Ei9JPjF4ydGMSmsSDFJbAA.png 700w" sizes="700px" role="presentation"/>

To make it more clear that the query is being passed through to each query method, here’s the same code without using the pipe operator:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*Y12GVcCUTjYkqyJQUtIghw.png" width="700" height="187" srcSet="https://miro.medium.com/max/552/1*Y12GVcCUTjYkqyJQUtIghw.png 276w, https://miro.medium.com/max/1104/1*Y12GVcCUTjYkqyJQUtIghw.png 552w, https://miro.medium.com/max/1280/1*Y12GVcCUTjYkqyJQUtIghw.png 640w, https://miro.medium.com/max/1400/1*Y12GVcCUTjYkqyJQUtIghw.png 700w" sizes="700px" role="presentation"/>

Positional Bindings.
--------------------

Notice that when you call the `join` method and attach another schema such as Author or Comment onto the post, the binding for the post’s comment and author are based on the position in the list.

Here’s the same code, but with the post, author, comment, and tag bindings written more verbosely to clarify their position.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*VPX98mpGqH6g9tEw20KbVQ.png" width="700" height="161" srcSet="https://miro.medium.com/max/552/1*VPX98mpGqH6g9tEw20KbVQ.png 276w, https://miro.medium.com/max/1104/1*VPX98mpGqH6g9tEw20KbVQ.png 552w, https://miro.medium.com/max/1280/1*VPX98mpGqH6g9tEw20KbVQ.png 640w, https://miro.medium.com/max/1400/1*VPX98mpGqH6g9tEw20KbVQ.png 700w" sizes="700px" role="presentation"/>

Positional bindings are a problem when trying to chain queries together Because you run into positional conflicts if the order changes. Thus you couple your code to the order that the queries are called in.

For example, you cannot retrieve the comments before the tags. You would need to change the position of the comments and tags in the list of bound values.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*odaPOK-fz9FfAukvuKsXUA.png" width="700" height="149" srcSet="https://miro.medium.com/max/552/1*odaPOK-fz9FfAukvuKsXUA.png 276w, https://miro.medium.com/max/1104/1*odaPOK-fz9FfAukvuKsXUA.png 552w, https://miro.medium.com/max/1280/1*odaPOK-fz9FfAukvuKsXUA.png 640w, https://miro.medium.com/max/1400/1*odaPOK-fz9FfAukvuKsXUA.png 700w" sizes="700px" role="presentation"/>

Chain Composable Queries.
=========================

The goal is to create reusable and chainable methods by extracting common queries you make into their own method. When I say chain, I mean that you can call the extracted query methods in a pipe chain like so:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*aYIP6uiR1hgZ9rR_n7_PFA.png" width="700" height="365" srcSet="https://miro.medium.com/max/552/1*aYIP6uiR1hgZ9rR_n7_PFA.png 276w, https://miro.medium.com/max/1104/1*aYIP6uiR1hgZ9rR_n7_PFA.png 552w, https://miro.medium.com/max/1280/1*aYIP6uiR1hgZ9rR_n7_PFA.png 640w, https://miro.medium.com/max/1400/1*aYIP6uiR1hgZ9rR_n7_PFA.png 700w" sizes="700px" role="presentation"/>

However, because of positional bindings, these methods are coupled to each other and their order.

Named Bindings
--------------

You can solve the problem of positional bindings by using named bindings. Where positional bindings are bound to the next position in a list, named bindings allow you to set their name. Like so:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*G6xh2BOnXqrb2V8h8RI7jw.png" width="700" height="71" srcSet="https://miro.medium.com/max/552/1*G6xh2BOnXqrb2V8h8RI7jw.png 276w, https://miro.medium.com/max/1104/1*G6xh2BOnXqrb2V8h8RI7jw.png 552w, https://miro.medium.com/max/1280/1*G6xh2BOnXqrb2V8h8RI7jw.png 640w, https://miro.medium.com/max/1400/1*G6xh2BOnXqrb2V8h8RI7jw.png 700w" sizes="700px" role="presentation"/>

Then you can use the named binding instead of a position if needed for a later query. Here’s an example method that filters posts for a specific author.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*qlc8g5AWyQOVSbMyvK9Vvw.png" width="700" height="70" srcSet="https://miro.medium.com/max/552/1*qlc8g5AWyQOVSbMyvK9Vvw.png 276w, https://miro.medium.com/max/1104/1*qlc8g5AWyQOVSbMyvK9Vvw.png 552w, https://miro.medium.com/max/1280/1*qlc8g5AWyQOVSbMyvK9Vvw.png 640w, https://miro.medium.com/max/1400/1*qlc8g5AWyQOVSbMyvK9Vvw.png 700w" sizes="700px" role="presentation"/>

This prevents position conflicts across joins so that you can chain your methods in any order.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*vwEgZVI7amPC7OcN1gNQQQ.png" width="700" height="361" srcSet="https://miro.medium.com/max/552/1*vwEgZVI7amPC7OcN1gNQQQ.png 276w, https://miro.medium.com/max/1104/1*vwEgZVI7amPC7OcN1gNQQQ.png 552w, https://miro.medium.com/max/1280/1*vwEgZVI7amPC7OcN1gNQQQ.png 640w, https://miro.medium.com/max/1400/1*vwEgZVI7amPC7OcN1gNQQQ.png 700w" sizes="700px" role="presentation"/>

So long as you do not reuse the same name, you can compose the methods in any order.

However, if a method requires a named binding, it will still have to follow the function that creates it. For example, a`for_author` method would have to be called after the `with_author` method because it relies on the `author:` named binding.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*cVD-pWyXU6SSXN4aehhPaA.png" width="700" height="181" srcSet="https://miro.medium.com/max/552/1*cVD-pWyXU6SSXN4aehhPaA.png 276w, https://miro.medium.com/max/1104/1*cVD-pWyXU6SSXN4aehhPaA.png 552w, https://miro.medium.com/max/1280/1*cVD-pWyXU6SSXN4aehhPaA.png 640w, https://miro.medium.com/max/1400/1*cVD-pWyXU6SSXN4aehhPaA.png 700w" sizes="700px" role="presentation"/>

Conclusion
==========

You learned about composable Ecto queries using the Pipe-based syntax. You learned how to extract those composable Ecto queries into separate methods, and you learned how to use named bindings to deal with the position conflicts caused by positional bindings.