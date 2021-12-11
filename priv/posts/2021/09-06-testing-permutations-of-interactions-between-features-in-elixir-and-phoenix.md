%{
  title: "Testing Permutations of Interactions Between Features in Elixir and Phoenix.",
  tags: ~w(elixir phoenix testing),
  description: "Learn How to Maximize Test Coverage Using a Book Search Example.",
  cover_image: "09-06-testing-permutations-of-interactions-between-features-in-elixir-and-phoenix.jpeg"
}
---

Testing Interactions Between Features.
--------------------------------------

When testing interactions, permutations of test cases grow exponentially.

What does that mean? Well, imagine you have to test a single feature. For example, you want to be able to search a list of books by title. Then, you have a series of test cases such as:

1.  Filter by full book title should find matching books.
2.  Filter by partial book title should find matching books.
3.  Filter by no book title should find all books.
4.  Filter by non-matching book title should find no books.

Written in an Elixir/Phoenix project, those test cases might look like:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*KPN-MdrfmCyxIoWVWahn3w.png" width="700" height="304" srcSet="https://miro.medium.com/max/552/1*KPN-MdrfmCyxIoWVWahn3w.png 276w, https://miro.medium.com/max/1104/1*KPN-MdrfmCyxIoWVWahn3w.png 552w, https://miro.medium.com/max/1280/1*KPN-MdrfmCyxIoWVWahn3w.png 640w, https://miro.medium.com/max/1400/1*KPN-MdrfmCyxIoWVWahn3w.png 700w" sizes="700px" role="presentation"/>

You also want to filter by the author of a book. This creates another series of test cases.

A. Filter by author full name should find author’s books.

B. Filter by partial author name should find author’s books.

C. Filter by no author name should find all books.

D. Filter by non-matching author name should find no books.

Written in Elixir/Phoenix, those test cases might look like:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*YDUrD7ssawWNtttHQordEA.png" width="700" height="311" srcSet="https://miro.medium.com/max/552/1*YDUrD7ssawWNtttHQordEA.png 276w, https://miro.medium.com/max/1104/1*YDUrD7ssawWNtttHQordEA.png 552w, https://miro.medium.com/max/1280/1*YDUrD7ssawWNtttHQordEA.png 640w, https://miro.medium.com/max/1400/1*YDUrD7ssawWNtttHQordEA.png 700w" sizes="700px" role="presentation"/>

Now that there are two interacting features, we’ve introduced a permutation of possible test interactions. For example, if we filter by both an author’s full name and a book's full name, do we find the matching books? Or is there a bug where the function returns a list of all books by the author?.

The possible list of interactions grows as a permutation of each test case like so:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*LPwSXA1ySKq53w-9Sxbhcg.jpeg" width="700" height="383" srcSet="https://miro.medium.com/max/552/1*LPwSXA1ySKq53w-9Sxbhcg.jpeg 276w, https://miro.medium.com/max/1104/1*LPwSXA1ySKq53w-9Sxbhcg.jpeg 552w, https://miro.medium.com/max/1280/1*LPwSXA1ySKq53w-9Sxbhcg.jpeg 640w, https://miro.medium.com/max/1400/1*LPwSXA1ySKq53w-9Sxbhcg.jpeg 700w" sizes="700px" role="presentation"/>

Notice that when adding interacting features, the number of test cases grows exponentially. This is because it quickly becomes unreasonable to write a test for every single case.

This list grows massively if we add a single additional feature like filtering by a range of dates.

So how do you maintain reasonable test coverage in this situation?

Selectively Test Interactions.
==============================

One option for handling a large number of test permutations is to test interactions selectively.

Once you’ve covered your main test cases for each feature, you can selectively test interactions between the features to maximize test coverage.

For example, if you know that your main test cases for filtering by author and by book title work, then it’s reasonable to assume that if you can search by full author name and full book name successfully, you can probably search by full author name and partial book name without needing to write a test.

In this way, you can maximize test coverage by selecting the test interactions you think are the most important.

For example, you can write one test per interaction like so:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*eTK83o-1PepBYPGI_NAMBw.png" width="700" height="384" srcSet="https://miro.medium.com/max/552/1*eTK83o-1PepBYPGI_NAMBw.png 276w, https://miro.medium.com/max/1104/1*eTK83o-1PepBYPGI_NAMBw.png 552w, https://miro.medium.com/max/1280/1*eTK83o-1PepBYPGI_NAMBw.png 640w, https://miro.medium.com/max/1400/1*eTK83o-1PepBYPGI_NAMBw.png 700w" sizes="700px" role="presentation"/>

green = test case to test

I want to avoid confusion in case it seems like I’m recommending the following test cases:

*   filter by author full name and book full title finds matching books.
*   Partial name author partial name book finds matching books.
*   No author name, no book name finds all books.
*   Non-matching author name and non-matching book name finds no books.

The order of these test cases doesn’t matter. Instead, you can select the test interactions you think are most important. For example:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*5QHazaKLZCnJ_TbLSFOt8Q.png" width="700" height="384" srcSet="https://miro.medium.com/max/552/1*5QHazaKLZCnJ_TbLSFOt8Q.png 276w, https://miro.medium.com/max/1104/1*5QHazaKLZCnJ_TbLSFOt8Q.png 552w, https://miro.medium.com/max/1280/1*5QHazaKLZCnJ_TbLSFOt8Q.png 640w, https://miro.medium.com/max/1400/1*5QHazaKLZCnJ_TbLSFOt8Q.png 700w" sizes="700px" role="presentation"/>

This might create a series of test cases like so:

*   Filter by full book title and partial author name finds matching books.
*   Filter by partial book title and non-matching author name finds no books.
*   Filter by no book title and no author name finds matching books.
*   Filter by non-matching book title and full author name finds no books.

Here’s how those test cases might look like on an Elixir or Phoenix project:

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1220/1*CjbRGJyg5RHbMjGBxH5oZg.png" width="610" height="784" srcSet="https://miro.medium.com/max/552/1*CjbRGJyg5RHbMjGBxH5oZg.png 276w, https://miro.medium.com/max/1104/1*CjbRGJyg5RHbMjGBxH5oZg.png 552w, https://miro.medium.com/max/1220/1*CjbRGJyg5RHbMjGBxH5oZg.png 610w" sizes="610px" role="presentation"/>

You Don’t Always Need to Test Every Interaction.
------------------------------------------------

Sometimes you can skip certain cases if you are willing to sacrifice test coverage. You can sprinkle in tests for interactions as needed.

For example, I purposely left a test that you can omit: filter by no book title and no author name. This test is clearly redundant and has already been handled. You might even consider a standalone test for “filter with no filters” instead of “filter by no author name” and “filter by no book title.”

You can use your best judgment to determine which test cases need to be covered.

Test Exceptional Cases.
-----------------------

You may also have certain edge cases that defy normal behavior. For example, when filtering by an author and a non-matching book title, the default behavior is to return non-books. However, since users are looking for an author’s book, they may enter its title wrong. In this case, it may be better to return some possible suggestions to the user rather than returning nothing.

Anytime your tests break the default behavior and create an exceptional circumstance, you should consider adding a test for this specific interaction.

Summary
=======

You can handle testing permutations of interactions by selectively testing interactions directly rather than creating a test for every possible permutation of test cases.

Selectively testing interactions provides maximal test coverage without overly extensive tests.

Want to see the code that makes these tests pass? Check out the [example repository.](https://github.com/BrooklinJazz/Book-Finder)

Some exercises to improve your understanding:

*   Can you introduce a bug (on purpose) without the tests catching it?
*   If you remove the interaction tests covering both author name and book title together, what bugs can you introduce while tests still pass?

If you do, or if you have any questions, please share!