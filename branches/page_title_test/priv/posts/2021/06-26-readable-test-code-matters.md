%{
  title: "Readable test code matters.",
  tags: ~w(elixir phoenix testing),
  description: "How to structure your tests using Phoenix and Elixir examples.",
  cover_image: "06-26-readable-test-code-matters.jpeg"
}
---

Developers spend much more of their time reading than writing.

> Indeed, the ratio of time spent reading versus writing is well over 10 to 1. We are constantly reading old code as part of the effort to write new code. …\[Therefore,\] making it easy to read makes it easier to write. — Bob Martin

Developers spend as much time maintaining and testing their code as they do writing code for new features.

[A report](https://thenewstack.io/how-much-time-do-developers-spend-actually-writing-code/) found developers spend 39% of their time on new features and 40% of their time on testing, maintenance, and security issues.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*T-iaVmd__4DS0bWvNDoC1g.png" width="700" height="530" srcSet="https://miro.medium.com/max/552/1*T-iaVmd__4DS0bWvNDoC1g.png 276w, https://miro.medium.com/max/1104/1*T-iaVmd__4DS0bWvNDoC1g.png 552w, https://miro.medium.com/max/1280/1*T-iaVmd__4DS0bWvNDoC1g.png 640w, https://miro.medium.com/max/1400/1*T-iaVmd__4DS0bWvNDoC1g.png 700w" sizes="700px" role="presentation"/>

So, now that you know the importance of readable tests, how do you do it?

Give your tests good names.
===========================

Having clear intention in your tests is important. There are lots of good patterns to follow when naming tests. Upon reading a range of opinions, I found 3 common elements in any naming pattern for tests.

The three common elements are:

*   **The system under test.** This is the method, module, class, or route under test.
*   **The state under test.** The context that the test occurs. For example, if you need to arrange specific data such as “user already signed in”.
*   **The expected behavior of the test.** The desired return value or expected state of your system.

Here’s an example:

```elixir
test "User.signIn _ user is already signed in _ redirect to home"
```

Here’s a breakdown

*   The system under test: `User.signIn`
*   The state under test: `user is already signed in`
*   The expected behavior: `redirect to home`

Realworld example
-----------------

The important piece to remember is not following a particular standard. Instead, it’s to make sure that your test name captures the right information.

For the test above.

```elixir
test "User.signIn _ user is already signed in _ redirect to home"
```

Here’s a similar test in Phoenix/Elixir. It doesn’t follow the same naming convention, but it still captures the information nicely.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*uPGwt7jd8yFaVQQEulrBCA.png" width="700" height="142" srcSet="https://miro.medium.com/max/552/1*uPGwt7jd8yFaVQQEulrBCA.png 276w, https://miro.medium.com/max/1104/1*uPGwt7jd8yFaVQQEulrBCA.png 552w, https://miro.medium.com/max/1280/1*uPGwt7jd8yFaVQQEulrBCA.png 640w, https://miro.medium.com/max/1400/1*uPGwt7jd8yFaVQQEulrBCA.png 700w" sizes="700px" role="presentation"/>

Do not worry about understanding the syntax or the internals of the test. The important information is:

`Get /authors/login` and `redirects if already logged in` .

Here’s why it’s a good name.

*   **The system under test:** `GET /authors/log_in`
*   **Expected behavior:** `redirects`
*   **State under test:** `already logged in`

It could be an even better test name if we were more specific about the expected behavior. Redirects to where? in this case, it’s the home page.

Test names should read like a good news headline. It’s enough information to understand the intent of the test without having to read further.

The three A’s of testing (arrange, act, assert)
-----------------------------------------------

In case you are not familiar with the three A’s of testing, they are:

*   **Arrange:** set up the data necessary to perform the test.
*   **Act:** trigger the action to test. Usually, this is a specific method or action that you’re testing.
*   **Assert:** now that you’ve triggered that action, assert that your system behaved as you expect.

There’s a direct parallel between naming conventions and the three A’s of testing.

*   Arrange == state under test
*   Act == system under test
*   Assert == expected behavior

This is because a good test name should seek to describe what the test is doing accurately. Because most tests follow this pattern, naming conventions naturally match how most tests are written.

Common Naming Conventions
-------------------------

There are many common naming conventions for tests. Most if not all of them try to capture the information above. Rather than recommending a specific convention, I’d like to help you understand why they exist and how you can pick your own.

Here are some example conventions.

*   _Given _ state under test _ when _ system under test _ then _ expected behavior_
*   Should _ expected behavior _ when _ state under test
*   _The system under test _ state under test_ expected behavior_

Here’s a good [list of naming conventions](https://dzone.com/articles/7-popular-unit-test-naming) if you’re curious.

It’s not important to follow a specific convention, though you might want to agree to a convention on your team for consistency's sake.

It’s more important that your test name captures the important information.

Tests still get out of date.
============================

Now you know how to give your tests readable names. But as your application grows and changes, it’s still inevitable that your tests will become out of date.

Names Change
------------

Tests can become out of date is due to renaming. Here’s some pseudo-code to illustrate renaming a method from `login` to `signin` and a class from `UserClass` to `AuthClass`.

```elixir
test "UserClass.login _ renders log in page"  
   AuthClass.signin()  
   assert current_route === "/login"
```

Matching the system name with the test is ultimately up to the discipline of your team. There is likely no easy answer.

Whenever you rename something, make sure you understand the scope of your change and make sure your tests match.

Behavior changes
----------------

Product demands constantly change to fit user demands. This is not a bug; it’s a feature.

> “Software is a compound word. The word “ware” means “product.” The word “soft” means easy to change. Therefore, software is a product that is easy to change. Software was invented because we wanted a way to quickly and easily change the behavior of our machines. Had we wanted that behavior to be hard to change, we would have called it hardware.” — Bob Martin

When the behavior of your test changes, you need to make sure the name reflects that.

Take the example where we redirect an already signed-in user to home.

```elixir
test "User.signIn _ user is already signed in _ redirect to home"  
   UserClass.signin()  
   assert current_route === "/"
```

But now, instead of sending the user back to the home page, you want to send them to a page where they can sign in with a different account.

```elixir
# "redirect to home" should be "log in as different account"  
test "User.signIn _ user is already signed in _ redirect to home"  
   UserClass.signin()  
   assert current_route === "/log_in_as_different_account"
```

Once again, this imposes a demand on your team to maintain good discipline when refactoring or renaming tests.

How to make your tests more maintainable
========================================

Now that you know how tests go out of date, what can you do to make them easier to maintain?

Consider excluding the expected behavior in the test name
---------------------------------------------------------

You may choose to use a pattern that doesn’t include the expected behavior in the test name. Instead, the expected behavior is made clear in the assertion at the end of the test.

Take the scenario where a user who already signed in should be redirected to the home page.

```elixir
test "UserClass.signin _ user already signed in"  
   UserClass.signin()  
   expectRedirectedToHome()
```

Now if the behavior changes, you change the expectRedirectedToHome() method into expectRedirectedToChooseAnotherAccount()

```elixir
test "UserClass.signin _ user already signed in"  
   UserClass.signin()  
   expectRedirectedToChooseAnotherAccount()
```

Consider putting the system under test in the describe block
------------------------------------------------------------

For tests sharing the same system under test, consider grouping them, so you only have to refactor the name in one place.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1174/1*5S3fy8PT-ueG7jd1redHkg.png" width="587" height="515" srcSet="https://miro.medium.com/max/552/1*5S3fy8PT-ueG7jd1redHkg.png 276w, https://miro.medium.com/max/1104/1*5S3fy8PT-ueG7jd1redHkg.png 552w, https://miro.medium.com/max/1174/1*5S3fy8PT-ueG7jd1redHkg.png 587w" sizes="587px" role="presentation"/>

In the example above, you’ll notice there’s the main system under test. The `AuthorSessionController` and then several subsystems under test.

Inside of each subsystem, some tests specify the state under test and the expected behavior.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*lJ6Y1bGL4Mv5cgsxWt22UA.png" width="700" height="232" srcSet="https://miro.medium.com/max/552/1*lJ6Y1bGL4Mv5cgsxWt22UA.png 276w, https://miro.medium.com/max/1104/1*lJ6Y1bGL4Mv5cgsxWt22UA.png 552w, https://miro.medium.com/max/1280/1*lJ6Y1bGL4Mv5cgsxWt22UA.png 640w, https://miro.medium.com/max/1400/1*lJ6Y1bGL4Mv5cgsxWt22UA.png 700w" sizes="700px" role="presentation"/>

This might be easier to maintain than having several tests with the name of the system under test. Like so:

`POST /authors/login _ logs the author in`

`POST /authors/login _ logs the author in _ with remember me`

`POST /authors/login _ logs the author in _ with return to`

`POST /authors/login _ emits error message _ with invalid credentials`

If the route `POST /authors/login` changes, you only have to change it in the describe block instead of in each test.

Conclusion
==========

Making your code readable is as important as making it work. Therefore, your test code should maintain a standard of readability, just like any other code in your system.

You’ve learned the most important information to include in your test:

*   **The system under test**
*   **The state under test**
*   **The expected behavior of the test.**

You’ve also learned the **_why_** of test naming conventions so that you have the knowledge to choose your own pattern.

If you have any questions or comments, please let me know in the reply section of this article. I would be happy to know your thoughts and get back to you!