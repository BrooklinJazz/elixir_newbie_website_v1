%{
  title: "Phoenix/Elixir testing: beyond mix test",
  tags: ~w(elixir phoenix testing mix),
  description: "Using commands, tags, arguments, and test watching to improve your testing experience.",
  cover_image: "06-19-beyond_mix_test.jpeg"
}
---

Using commands, tags, arguments, and test watching to improve your testing experience.

Coming from a Javascript background, testing Phoenix and Elixir is a dream come true. Tests are extremely fast, often taking mere seconds to run. Developers who are familiar with elixir should be aware of the Mix module.

> Mix is a build tool that provides tasks for creating, compiling, and testing Elixir projects, managing its dependencies, and more.  
> \- [mix docs](https://hexdocs.pm/mix/Mix.html)

By leveraging Mix properly, you can gain fine-tuned control of your tests and further improve the convenience and speed of your testing.

You will learn how to:
======================

*   run tests by folder
*   run test by file
*   run a single test in a file
*   run tests using tags for specific modules, describe blocks, and tests
*   run tests in watch mode
*   configure mix commands
*   use convenient code editor extensions

Assuming you already have a phoenix project up and running (if you don’t, you can [read my article](https://www.elixirnewbie.com/blog/elixir-phoenix-v1.5.9-getting-started-on-windows-10) or [read the docs](https://hexdocs.pm/phoenix/up_and_running.html))

You should be able to run your tests with `mix.test` in your command line and see something like:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*evjnHIpX5GMMSPS08Qe7zA.png" width="700" height="164" srcSet="https://miro.medium.com/max/552/1*evjnHIpX5GMMSPS08Qe7zA.png 276w, https://miro.medium.com/max/1104/1*evjnHIpX5GMMSPS08Qe7zA.png 552w, https://miro.medium.com/max/1280/1*evjnHIpX5GMMSPS08Qe7zA.png 640w, https://miro.medium.com/max/1400/1*evjnHIpX5GMMSPS08Qe7zA.png 700w" sizes="700px" role="presentation"/>

I’m using [a demo blog project](https://github.com/BrooklinJazz/phoenix_blog) as an example.

Run tests by folder
-------------------

You can run `mix test path/to/folder` to run all the tests in a specific folder. Here’s an example of running all of your controller tests.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*10UD1w04ULmlWrmhRQTk1Q.png" width="700" height="178" srcSet="https://miro.medium.com/max/552/1*10UD1w04ULmlWrmhRQTk1Q.png 276w, https://miro.medium.com/max/1104/1*10UD1w04ULmlWrmhRQTk1Q.png 552w, https://miro.medium.com/max/1280/1*10UD1w04ULmlWrmhRQTk1Q.png 640w, https://miro.medium.com/max/1400/1*10UD1w04ULmlWrmhRQTk1Q.png 700w" sizes="700px" role="presentation"/>

I found that on Windows, this can be a problem because windows autocomplete files using a different syntax. `./path/to/folder`

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*JFboEZzWIRFGEZkR4UYe8g.png" width="700" height="65" srcSet="https://miro.medium.com/max/552/1*JFboEZzWIRFGEZkR4UYe8g.png 276w, https://miro.medium.com/max/1104/1*JFboEZzWIRFGEZkR4UYe8g.png 552w, https://miro.medium.com/max/1280/1*JFboEZzWIRFGEZkR4UYe8g.png 640w, https://miro.medium.com/max/1400/1*JFboEZzWIRFGEZkR4UYe8g.png 700w" sizes="700px" role="presentation"/>

I’ll edit this post if I find a good solution for this. Oddly it’s only folders that have this issue.

Run tests by file
-----------------

You can run `mix test path/to/file.ex` to run all the tests in a specific folder. Here’s a single controller test called `author_auth_test.ex` . You’ll notice that, unlike with folders, running tests by file works correctly with the Windows path syntax. `./path/to/file.ex` .

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*UVhv242oEdbhkJPNfRVWSQ.png" width="700" height="193" srcSet="https://miro.medium.com/max/552/1*UVhv242oEdbhkJPNfRVWSQ.png 276w, https://miro.medium.com/max/1104/1*UVhv242oEdbhkJPNfRVWSQ.png 552w, https://miro.medium.com/max/1280/1*UVhv242oEdbhkJPNfRVWSQ.png 640w, https://miro.medium.com/max/1400/1*UVhv242oEdbhkJPNfRVWSQ.png 700w" sizes="700px" role="presentation"/>

Run a specific test or describe block
-------------------------------------

You can run `mix test path/to/file.ex:linenumber` to run either a specific test or describe block where `linenumber` is the first line of the describe block or test.

Here’s an example test in a describe block. It doesn’t matter what the test does. Just notice that the describe block starts on line 119, and the first test starts on line 120.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*5hA3TJ5s2rQSiWCUXQ6-xg.png" width="700" height="199" srcSet="https://miro.medium.com/max/552/1*5hA3TJ5s2rQSiWCUXQ6-xg.png 276w, https://miro.medium.com/max/1104/1*5hA3TJ5s2rQSiWCUXQ6-xg.png 552w, https://miro.medium.com/max/1280/1*5hA3TJ5s2rQSiWCUXQ6-xg.png 640w, https://miro.medium.com/max/1400/1*5hA3TJ5s2rQSiWCUXQ6-xg.png 700w" sizes="700px" role="presentation"/>

Run the describe block on line 119

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*jH6buV7UjOdAi2GE7BMxuw.png" width="700" height="189" srcSet="https://miro.medium.com/max/552/1*jH6buV7UjOdAi2GE7BMxuw.png 276w, https://miro.medium.com/max/1104/1*jH6buV7UjOdAi2GE7BMxuw.png 552w, https://miro.medium.com/max/1280/1*jH6buV7UjOdAi2GE7BMxuw.png 640w, https://miro.medium.com/max/1400/1*jH6buV7UjOdAi2GE7BMxuw.png 700w" sizes="700px" role="presentation"/>

Or run a single test on line 120

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*HKj_Km5KsQwUUQYyZuiwFg.png" width="700" height="172" srcSet="https://miro.medium.com/max/552/1*HKj_Km5KsQwUUQYyZuiwFg.png 276w, https://miro.medium.com/max/1104/1*HKj_Km5KsQwUUQYyZuiwFg.png 552w, https://miro.medium.com/max/1280/1*HKj_Km5KsQwUUQYyZuiwFg.png 640w, https://miro.medium.com/max/1400/1*HKj_Km5KsQwUUQYyZuiwFg.png 700w" sizes="700px" role="presentation"/>

Run tests using tags
====================

You can create tags for modules using @moduletag, describe blocks using @describetag, and specific tests using @tag.

You can then use tags to choose which tests to run using the `--include, --exclude, and --only` arguments for mix test.

Using a real code example, I’ll put an @moduletag in [my example repository.](https://github.com/BrooklinJazz/phoenix_blog)

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/830/1*aD0rrNUJ8cjtGeRC5wbFkw.png" width="415" height="205" srcSet="https://miro.medium.com/max/552/1*aD0rrNUJ8cjtGeRC5wbFkw.png 276w, https://miro.medium.com/max/830/1*aD0rrNUJ8cjtGeRC5wbFkw.png 415w" sizes="415px" role="presentation"/>

then you can use the `--only` argument to run this file with `mix.test`

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*NT2Z9w9u7w2-mw5VtP9bAw.png" width="700" height="283" srcSet="https://miro.medium.com/max/552/1*NT2Z9w9u7w2-mw5VtP9bAw.png 276w, https://miro.medium.com/max/1104/1*NT2Z9w9u7w2-mw5VtP9bAw.png 552w, https://miro.medium.com/max/1280/1*NT2Z9w9u7w2-mw5VtP9bAw.png 640w, https://miro.medium.com/max/1400/1*NT2Z9w9u7w2-mw5VtP9bAw.png 700w" sizes="700px" role="presentation"/>

Here’s an example using @describetag and also @tag.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*dnuUV5vF5mMFDvTZEf-L7g.png" width="700" height="255" srcSet="https://miro.medium.com/max/552/1*dnuUV5vF5mMFDvTZEf-L7g.png 276w, https://miro.medium.com/max/1104/1*dnuUV5vF5mMFDvTZEf-L7g.png 552w, https://miro.medium.com/max/1280/1*dnuUV5vF5mMFDvTZEf-L7g.png 640w, https://miro.medium.com/max/1400/1*dnuUV5vF5mMFDvTZEf-L7g.png 700w" sizes="700px" role="presentation"/>

You can selectively run tests using `--include` and `--exclude` . Here’s an example including the describe_example tag but excluding the test_example tag so that only the second test runs.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*4hJPEFxvzLWzDwMQaCRpgg.png" width="700" height="89" srcSet="https://miro.medium.com/max/552/1*4hJPEFxvzLWzDwMQaCRpgg.png 276w, https://miro.medium.com/max/1104/1*4hJPEFxvzLWzDwMQaCRpgg.png 552w, https://miro.medium.com/max/1280/1*4hJPEFxvzLWzDwMQaCRpgg.png 640w, https://miro.medium.com/max/1400/1*4hJPEFxvzLWzDwMQaCRpgg.png 700w" sizes="700px" role="presentation"/>

It’s important to note that includes overwrites excludes (unfortunately, I will update this article if I find a solution) So including a module then excluding a describe block inside of that module, or including a describe block then excluding a test inside of the describe block does not work.

Notice in the next terminal example, 2 tests are run instead of just 1 like you might expect.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*jxBFokkAiq0nPUV-r7D_xQ.png" width="700" height="199" srcSet="https://miro.medium.com/max/552/1*jxBFokkAiq0nPUV-r7D_xQ.png 276w, https://miro.medium.com/max/1104/1*jxBFokkAiq0nPUV-r7D_xQ.png 552w, https://miro.medium.com/max/1280/1*jxBFokkAiq0nPUV-r7D_xQ.png 640w, https://miro.medium.com/max/1400/1*jxBFokkAiq0nPUV-r7D_xQ.png 700w" sizes="700px" role="presentation"/>

In the above, you might notice `--exclude test` this is provided by mix to exclude all non-included tests.

Using tags with values
----------------------

You can also declare tags with a value. For example:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*qHqtOtQz_yMSG6iqjq1ExQ.png" width="700" height="182" srcSet="https://miro.medium.com/max/552/1*qHqtOtQz_yMSG6iqjq1ExQ.png 276w, https://miro.medium.com/max/1104/1*qHqtOtQz_yMSG6iqjq1ExQ.png 552w, https://miro.medium.com/max/1280/1*qHqtOtQz_yMSG6iqjq1ExQ.png 640w, https://miro.medium.com/max/1400/1*qHqtOtQz_yMSG6iqjq1ExQ.png 700w" sizes="700px" role="presentation"/>

You can then run the tag with `tag:value`

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*UBsaqEtZkKyuzQaIF03TLA.png" width="700" height="216" srcSet="https://miro.medium.com/max/552/1*UBsaqEtZkKyuzQaIF03TLA.png 276w, https://miro.medium.com/max/1104/1*UBsaqEtZkKyuzQaIF03TLA.png 552w, https://miro.medium.com/max/1280/1*UBsaqEtZkKyuzQaIF03TLA.png 640w, https://miro.medium.com/max/1400/1*UBsaqEtZkKyuzQaIF03TLA.png 700w" sizes="700px" role="presentation"/>

Tags with a different value or the default value will be exempt.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*JH5nIiOl0B4nmfTnmxoL1A.png" width="700" height="416" srcSet="https://miro.medium.com/max/552/1*JH5nIiOl0B4nmfTnmxoL1A.png 276w, https://miro.medium.com/max/1104/1*JH5nIiOl0B4nmfTnmxoL1A.png 552w, https://miro.medium.com/max/1280/1*JH5nIiOl0B4nmfTnmxoL1A.png 640w, https://miro.medium.com/max/1400/1*JH5nIiOl0B4nmfTnmxoL1A.png 700w" sizes="700px" role="presentation"/>

Recommended Tags
================

Now that you’ve learned about tags, you may want to consider some recommended tags to use.

Skip
----

It’s useful to be able to skip test(s). Using what you’ve already learned, you could add the `:skip` tag then run your tests with `-exclude skip` . Instead, however, you can configure your `test_helper.ex` file to do this automatically.

Add `ExUnit.configure(exclude: :skip)` to your test_helper file. It should look something like this.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*O4qrPWziHJNtMJn8I3uuIw.png" width="700" height="228" srcSet="https://miro.medium.com/max/552/1*O4qrPWziHJNtMJn8I3uuIw.png 276w, https://miro.medium.com/max/1104/1*O4qrPWziHJNtMJn8I3uuIw.png 552w, https://miro.medium.com/max/1280/1*O4qrPWziHJNtMJn8I3uuIw.png 640w, https://miro.medium.com/max/1400/1*O4qrPWziHJNtMJn8I3uuIw.png 700w" sizes="700px" role="presentation"/>

Now try adding `@tag :skip` to a test. you could also use `@describetag` or `@moduletag` .

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*VdejyRgGExeryJL9Ry11zQ.png" width="700" height="217" srcSet="https://miro.medium.com/max/552/1*VdejyRgGExeryJL9Ry11zQ.png 276w, https://miro.medium.com/max/1104/1*VdejyRgGExeryJL9Ry11zQ.png 552w, https://miro.medium.com/max/1280/1*VdejyRgGExeryJL9Ry11zQ.png 640w, https://miro.medium.com/max/1400/1*VdejyRgGExeryJL9Ry11zQ.png 700w" sizes="700px" role="presentation"/>

Now when you run `mix test` that test, describe block, or module will be excluded automatically.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*5ydBX-i7yL26OMPX9BEIpA.png" width="700" height="190" srcSet="https://miro.medium.com/max/552/1*5ydBX-i7yL26OMPX9BEIpA.png 276w, https://miro.medium.com/max/1104/1*5ydBX-i7yL26OMPX9BEIpA.png 552w, https://miro.medium.com/max/1280/1*5ydBX-i7yL26OMPX9BEIpA.png 640w, https://miro.medium.com/max/1400/1*5ydBX-i7yL26OMPX9BEIpA.png 700w" sizes="700px" role="presentation"/>

Current
-------

use `:current` to run only the test(s) you are working on.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*XcVqQ2kZTiF2bTu-YxQEZA.png" width="700" height="203" srcSet="https://miro.medium.com/max/552/1*XcVqQ2kZTiF2bTu-YxQEZA.png 276w, https://miro.medium.com/max/1104/1*XcVqQ2kZTiF2bTu-YxQEZA.png 552w, https://miro.medium.com/max/1280/1*XcVqQ2kZTiF2bTu-YxQEZA.png 640w, https://miro.medium.com/max/1400/1*XcVqQ2kZTiF2bTu-YxQEZA.png 700w" sizes="700px" role="presentation"/>

You already know you can run tests using `--only`. To make running `:current` more convenient, you can add an alias (see below).

Mix aliases
-----------

If you find yourself using the same commands repeatedly, you might want to consider making an alias. For example, go to your mix.exs folder, and you should see something like this.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*WAXskP7krzv0F-6Y9vm-Lw.png" width="700" height="272" srcSet="https://miro.medium.com/max/552/1*WAXskP7krzv0F-6Y9vm-Lw.png 276w, https://miro.medium.com/max/1104/1*WAXskP7krzv0F-6Y9vm-Lw.png 552w, https://miro.medium.com/max/1280/1*WAXskP7krzv0F-6Y9vm-Lw.png 640w, https://miro.medium.com/max/1400/1*WAXskP7krzv0F-6Y9vm-Lw.png 700w" sizes="700px" role="presentation"/>

Here’s an example alias using the `:current` tag from before.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*IcSvoo4J1O-HTAKovry-OQ.png" width="700" height="247" srcSet="https://miro.medium.com/max/552/1*IcSvoo4J1O-HTAKovry-OQ.png 276w, https://miro.medium.com/max/1104/1*IcSvoo4J1O-HTAKovry-OQ.png 552w, https://miro.medium.com/max/1280/1*IcSvoo4J1O-HTAKovry-OQ.png 640w, https://miro.medium.com/max/1400/1*IcSvoo4J1O-HTAKovry-OQ.png 700w" sizes="700px" role="presentation"/>

The name of the alias `test.current` is up to your preference. Now you can run `mix test.current` .

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1254/1*V1ZuxN7m7kjeEorVrz9DoQ.png" width="627" height="302" srcSet="https://miro.medium.com/max/552/1*V1ZuxN7m7kjeEorVrz9DoQ.png 276w, https://miro.medium.com/max/1104/1*V1ZuxN7m7kjeEorVrz9DoQ.png 552w, https://miro.medium.com/max/1254/1*V1ZuxN7m7kjeEorVrz9DoQ.png 627w" sizes="627px" role="presentation"/>

How to run tests only on affected files
---------------------------------------

Run `mix test --stale` to only execute tests on files changed since the late time you ran `mix test --stale`.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*z2QLbNYOokaVUHeyCut6CQ.png" width="700" height="215" srcSet="https://miro.medium.com/max/552/1*z2QLbNYOokaVUHeyCut6CQ.png 276w, https://miro.medium.com/max/1104/1*z2QLbNYOokaVUHeyCut6CQ.png 552w, https://miro.medium.com/max/1280/1*z2QLbNYOokaVUHeyCut6CQ.png 640w, https://miro.medium.com/max/1400/1*z2QLbNYOokaVUHeyCut6CQ.png 700w" sizes="700px" role="presentation"/>

Watch files for changes and automatically run tests
---------------------------------------------------

There’s a great package called [mix-test.watch](https://github.com/lpil/mix-test.watch). You should follow the link if you want the most up-to-date instructions. Here’s my mix.exs file for an example installation.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*dkBs-3tqRMtsitHYqcnE4w.png" width="700" height="520" srcSet="https://miro.medium.com/max/552/1*dkBs-3tqRMtsitHYqcnE4w.png 276w, https://miro.medium.com/max/1104/1*dkBs-3tqRMtsitHYqcnE4w.png 552w, https://miro.medium.com/max/1280/1*dkBs-3tqRMtsitHYqcnE4w.png 640w, https://miro.medium.com/max/1400/1*dkBs-3tqRMtsitHYqcnE4w.png 700w" sizes="700px" role="presentation"/>

Once properly installed, you can run `mix test.watch` to run tests whenever a file is changed so you can catch broken code as you’re developing.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*BIgAY6nJtpvof4Kr4DhK6Q.png" width="700" height="204" srcSet="https://miro.medium.com/max/552/1*BIgAY6nJtpvof4Kr4DhK6Q.png 276w, https://miro.medium.com/max/1104/1*BIgAY6nJtpvof4Kr4DhK6Q.png 552w, https://miro.medium.com/max/1280/1*BIgAY6nJtpvof4Kr4DhK6Q.png 640w, https://miro.medium.com/max/1400/1*BIgAY6nJtpvof4Kr4DhK6Q.png 700w" sizes="700px" role="presentation"/>

On Mac or Linux, you should also be able to mix test.watch with arguments `(--stale, --include, --only)`. However, there seems to be [an open issue](https://github.com/lpil/mix-test.watch/issues/103) for Windows users at the time of writing where these arguments are ignored.

Using an extension on your code editor to make running tests easier.
--------------------------------------------------------------------

For Visual Studio Code users like myself, a great package called [Elixir Test](https://marketplace.visualstudio.com/items?itemName=samuel-pordeus.elixir-test) provides useful commands such as running tests in a file, jumping between the test and the affected file, and running the test at your cursor position.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*7lJ8C7Ne9BSuP5rsYFGmKg.png" width="700" height="341" srcSet="https://miro.medium.com/max/552/1*7lJ8C7Ne9BSuP5rsYFGmKg.png 276w, https://miro.medium.com/max/1104/1*7lJ8C7Ne9BSuP5rsYFGmKg.png 552w, https://miro.medium.com/max/1280/1*7lJ8C7Ne9BSuP5rsYFGmKg.png 640w, https://miro.medium.com/max/1400/1*7lJ8C7Ne9BSuP5rsYFGmKg.png 700w" sizes="700px" role="presentation"/>

If you use a different editor like Atom or Sublime, I recommend finding a similar plugin. I don’t want to recommend anything that I haven’t used, so if you find one you enjoy, please let me know!

Conclusion
==========

You have learned how to leverage mix to run customizable test suites so that you can run exactly the tests you want. You have also learned about commands, tags, arguments, aliases, test watching, and editor extensions to both improve the performance and convenience of testing.