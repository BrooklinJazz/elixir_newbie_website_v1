%{
  title: "Elixir/Phoenix How You Can Cut Test Time by 80% With Development Specific Test Suites.",
  tags: ~w(elixir phoenix testing),
  description: "Use The --slowest and --exclude Flags to Profile Your Slowest Tests.",
  cover_image: "08-30-elixir-phoenix-how-you-can-cut-test-time-by-80-with-development-specific-test-suites.jpeg"
}
---

Tests are wonderful. Tests are little rules and assertions that you can put in your codebase that guarantee you haven’t broken anything while developing your feature.

However, as lovely as tests are, they also suck up a lot of time. How many hours do you think you’ve spent waiting for tests to pass? If you use Test Driven Development, then that number is probably relatively high.

I’ve worked on a project that had a 5–10 minute local test suite (It was JavaScript). That’s 5–10 minutes of my workday every time I need to run the entire suite. 5–10 minutes every time you push a new feature, every time you make a commit, every time you start work. 5–10 minutes is probably not that bad compared to other companies, but it still eats your day away.

Then I switched to Elixir, and so far, the testing experience has been beautiful. At my current workplace, we have 622 tests that take only 1 minute to run. Well, 1 minute and a half on the currently spotty wifi I’m using to write this article 😅

That’s a lot better than 5–10 minutes, but how do you make it even faster?

How to Profile Your Test Suite.
===============================

To speed up your test suite, you need to know the largest areas to improve. Likewise, you need to know your slowest test.

When I first had this idea, I manually ran all of our tests with a verbose output to see the time for each and tag any tests that took more than 100 milliseconds.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*dg-CEFVxCtizENgbVoLbBA.jpeg" width="700" height="468" srcSet="https://miro.medium.com/max/552/1*dg-CEFVxCtizENgbVoLbBA.jpeg 276w, https://miro.medium.com/max/1104/1*dg-CEFVxCtizENgbVoLbBA.jpeg 552w, https://miro.medium.com/max/1280/1*dg-CEFVxCtizENgbVoLbBA.jpeg 640w, https://miro.medium.com/max/1400/1*dg-CEFVxCtizENgbVoLbBA.jpeg 700w" sizes="700px" role="presentation"/>

Photo by [Tim Gouw](https://unsplash.com/@punttim?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/stress?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

After (of course after) I’d done that, my awesome coworker let me know there’s a tag for running mix tests that prints out a nice readable list of your slowest tests.

So if you want to do the same, you can save yourself a ton of time on this compared to how I did it.

Use Mix to Find Your Slowest Tests.
-----------------------------------

You can run your tests and return a list of your N slowest tests, where N is the number of tests you want to display.

```elixir
mix test --slowest N
```

For example, if you wanted a top 100 list of slowest tests in your project listed from slowest to fastest, you can run:

```elixir
mix test --slowest 100
```

Here’s an example of the top 100 slowest tests in my project.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1288/1*gIeW3xbxoehdEhxtWyL6Ag.png" width="644" height="64" srcSet="https://miro.medium.com/max/552/1*gIeW3xbxoehdEhxtWyL6Ag.png 276w, https://miro.medium.com/max/1104/1*gIeW3xbxoehdEhxtWyL6Ag.png 552w, https://miro.medium.com/max/1280/1*gIeW3xbxoehdEhxtWyL6Ag.png 640w, https://miro.medium.com/max/1288/1*gIeW3xbxoehdEhxtWyL6Ag.png 644w" sizes="644px" role="presentation"/>

The entire test suite takes 99.2 seconds to run, and the slowest 100 tests take 78.7 seconds which is 79.3% of the total test time. This is on a project with 622 tests, so that’s only 16% of the entire test suite.

Tag Expensive Tests.
====================

You can tag modules, describe blocks, and individual tests in elixir using `@moduletag`, `@describetag`, and `@tag`If you want to know more, you can read my article [Phoenix/Elixir testing: beyond mix test](https://www.elixirnewbie.com/blog/phoenix-elixir-testing-beyond-mix-test).

So you can go through your tests and tag them. I chose to tag them as `:expensive.`

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*HkUC9Ed5sjMYj2RoF6YT4w.png" width="700" height="116" srcSet="https://miro.medium.com/max/552/1*HkUC9Ed5sjMYj2RoF6YT4w.png 276w, https://miro.medium.com/max/1104/1*HkUC9Ed5sjMYj2RoF6YT4w.png 552w, https://miro.medium.com/max/1280/1*HkUC9Ed5sjMYj2RoF6YT4w.png 640w, https://miro.medium.com/max/1400/1*HkUC9Ed5sjMYj2RoF6YT4w.png 700w" sizes="700px" role="presentation"/>

Exclude Expensive Tests
=======================

By tagging your tests, you have control over which tests you want to run. For example, you can exclude the expensive tests by using the `--exclude` flag.

```elixir
mix test --exclude="expensive"
```

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*6FGCbMVrXE4FWEeqCK1ofA.png" width="700" height="147" srcSet="https://miro.medium.com/max/552/1*6FGCbMVrXE4FWEeqCK1ofA.png 276w, https://miro.medium.com/max/1104/1*6FGCbMVrXE4FWEeqCK1ofA.png 552w, https://miro.medium.com/max/1280/1*6FGCbMVrXE4FWEeqCK1ofA.png 640w, https://miro.medium.com/max/1400/1*6FGCbMVrXE4FWEeqCK1ofA.png 700w" sizes="700px" role="presentation"/>

23 seconds compared to 96.7 seconds is pretty darn good. Now I don’t have to wait nearly as long to get quick feedback for tests.

Didn’t You Just Ignore Longer Tests?
====================================

Yes. Absolutely, you are right. However, in most cases, you don’t need 100% test coverage. You make a small change and want to be reasonably sure that you didn’t break anything.

Run You Fast Tests Before Your Slow Tests.
==========================================

You can still run the full test suite before you push your branch. For example, I added the following commands to our pre-push hooks that run before anyone pushes their finished code.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*ibiwsgNLNQQipi_KxSBh9w.png" width="700" height="133" srcSet="https://miro.medium.com/max/552/1*ibiwsgNLNQQipi_KxSBh9w.png 276w, https://miro.medium.com/max/1104/1*ibiwsgNLNQQipi_KxSBh9w.png 552w, https://miro.medium.com/max/1280/1*ibiwsgNLNQQipi_KxSBh9w.png 640w, https://miro.medium.com/max/1400/1*ibiwsgNLNQQipi_KxSBh9w.png 700w" sizes="700px" role="presentation"/>

By running the fasts test first, you don’t need to bother waiting for your longer tests to run if any of them break.

In addition, if you run the fast test suite before the slow suite in your git hooks, then you can catch failing tests sooner after the time you push, rather than waiting for all of your slower tests to run first.

Summary
-------

Using the slowest flag to profile your test suite allows you to create a development-specific suite of tests to save time.

You can then run your development-specific suite using the only and exclude flags to improve your development speed and to run your faster tests first to ensure you don’t wait longer than you need to to find out that you have a failing test.

To ensure you have maximal test coverage, run your complete test suite when necessary, such as when you push your changes to Github.
