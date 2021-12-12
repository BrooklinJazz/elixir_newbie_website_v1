%{
  title: "Pagination and Infinite Scroll in Phoenix",
  tags: ~w(elixir jobs),
  description: "With Phoenix Hooks and Ecto Queries.",
  cover_image: "10-11-pagination-and-infinite-scroll-in-phoenix.jpeg"
}
---

Data gets big, really big. You can optimize your data retrieval with faster algorithms, but at some point, there’s simply too much data for your client or server to handle.

That’s where Pagination comes in.

What is Pagination?
===================

Think of your data like a big massive book. It has lines and lines of information. However, like in a regular book. We can’t store all of that information on a single page.

So like in a book we separate the information into “pages” and decide how much information should fit on a single page.

We break up hundreds of entries and can retrieve them on command by deciding how many entries should be displayed per page, and what page we want to retrieve.

Imagine you have 100 entries, and you want to retrieve page 1 with 10 entries per page. You would retrieve entries 1–10. Then when you want to retrieve page 2 with 10 entries, you would retrieve entries 11–20.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/602/1*V0k0a5Bf_4H7ByKeu_LtqA.png" width="301" height="261" srcSet="https://miro.medium.com/max/552/1*V0k0a5Bf_4H7ByKeu_LtqA.png 276w, https://miro.medium.com/max/602/1*V0k0a5Bf_4H7ByKeu_LtqA.png 301w" sizes="301px" role="presentation"/>

What is Infinite Scroll?
========================

Pagination is separate from infinite scroll. You could implement pagination simply by having a load-more button that triggers your request to grab the next 10 pages.

Infinite scroll is a mechanism of triggering pagination that relies on the user scrolling down the page, and automatically triggering the load-more pagination functionality when the user gets close to the bottom of the current page of entries.

Pagination and Infinite scroll can be performed by either loading more entries and attaching them to the current set of entries, or by dynamically loading the current and next page of entries.

Loading more entries is a simpler implementation, and that’s what I’ll focus on in this article, however, it’s important to be aware that both versions exist.

To load more, retrieve the next page of data and add it to the current data set.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1192/1*0rgMMJ6gwWCyKVepTfOPNA.png" width="596" height="216" srcSet="https://miro.medium.com/max/552/1*0rgMMJ6gwWCyKVepTfOPNA.png 276w, https://miro.medium.com/max/1104/1*0rgMMJ6gwWCyKVepTfOPNA.png 552w, https://miro.medium.com/max/1192/1*0rgMMJ6gwWCyKVepTfOPNA.png 596w" sizes="596px" role="presentation"/>

Load more is easier to implement and may provide a smoother less buggy scrolling experience. However, can you imagine the problem that occurs eventually? Eventually, as you scroll down, you retrieve too much data and the client gets slow and clunky again.

For many use cases, this is fine. The cause of slowness is not the amount of data, it’s the time it takes to fetch that data.

However, if you want to avoid the issue you can remove previous pages as you scroll father down.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1192/1*x62Aq9X_auBnt8tNYgpk1w.png" width="596" height="316" srcSet="https://miro.medium.com/max/552/1*x62Aq9X_auBnt8tNYgpk1w.png 276w, https://miro.medium.com/max/1104/1*x62Aq9X_auBnt8tNYgpk1w.png 552w, https://miro.medium.com/max/1192/1*x62Aq9X_auBnt8tNYgpk1w.png 596w" sizes="596px" role="presentation"/>

Then re-retrieve them and remove the bottom pages if the user scrolls up.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1152/1*bzP9XOxkWPihxy-zphTAZA.png" width="576" height="326" srcSet="https://miro.medium.com/max/552/1*bzP9XOxkWPihxy-zphTAZA.png 276w, https://miro.medium.com/max/1104/1*bzP9XOxkWPihxy-zphTAZA.png 552w, https://miro.medium.com/max/1152/1*bzP9XOxkWPihxy-zphTAZA.png 576w" sizes="576px" role="presentation"/>

As mentioned, I’m going to focus on the load-more implementation in this article, but once you know how to load more, then you should have all the tools you need to remove unnecessary pages from the list of data.

How Do We Code This In Phoenix?
===============================

Now that you understand the concept of pagination and infinite scrolling, how do you add it to a phoenix application?

Let’s break that into smaller and easier problems to solve.

How Do You Paginate an Ecto Query?
----------------------------------

I’m assuming you are already knowledgeable on Ecto Queries, so if you would like a quick refresher you can read my article [Ecto with Phoenix in 4 Minutes](https://www.elixirnewbie.com/blog/ecto-with-phoenix-in-4-minutes).

Using Ecto.Query methods `limit` and `offset` the code for pagination is pretty straightforward.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1032/1*KQuPOKBZT9gHAZw_78LfyQ.png" width="516" height="165" srcSet="https://miro.medium.com/max/552/1*KQuPOKBZT9gHAZw_78LfyQ.png 276w, https://miro.medium.com/max/1032/1*KQuPOKBZT9gHAZw_78LfyQ.png 516w" sizes="516px" role="presentation"/>

Add this paginate code to any of your existing Ecto queries and it imposes a limit (the number of entries to display per page) and an offset (the entry to start on given the current page number.

In context, this could be used to return a page of 20 entries. I’ve chosen a list of Books for the sake of example.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1140/1*sdzi6mrovibah4WSPTSCag.png" width="570" height="246" srcSet="https://miro.medium.com/max/552/1*sdzi6mrovibah4WSPTSCag.png 276w, https://miro.medium.com/max/1104/1*sdzi6mrovibah4WSPTSCag.png 552w, https://miro.medium.com/max/1140/1*sdzi6mrovibah4WSPTSCag.png 570w" sizes="570px" role="presentation"/>

How Do You Handle a load-more Event In Phoenix Liveview?
--------------------------------------------------------

Likely, you’ll have a phoenix live view function to load more data.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1392/1*sqbEJ3LJ_2ElNxI4mXIU7w.png" width="696" height="417" srcSet="https://miro.medium.com/max/552/1*sqbEJ3LJ_2ElNxI4mXIU7w.png 276w, https://miro.medium.com/max/1104/1*sqbEJ3LJ_2ElNxI4mXIU7w.png 552w, https://miro.medium.com/max/1280/1*sqbEJ3LJ_2ElNxI4mXIU7w.png 640w, https://miro.medium.com/max/1392/1*sqbEJ3LJ_2ElNxI4mXIU7w.png 696w" sizes="696px" role="presentation"/>

the current page is stored in socket assigns, and then gets incremented every time the load-more event is triggered.

The load more event retrieves the next page of books and using the ++ operator to add two lists together in phoenix, adds the next page of books to the current list of books.

How Do You Trigger The Load More Event?
---------------------------------------

You can trigger the load more event however you want, for example, you could have a “more” button that triggers the event when you scroll down far enough. In fact, that’s a great test to make sure that the event works correctly.

However, if you want to implement infinite scrolling, then one way to achieve the effect is with a phoenix hook.

The following implements an infinite_scroll hook in a file infinite_scroll.js. This attaches an event listener for “scroll” and triggers the “load-more” event anytime the scroll percent down is greater than 90.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*nWybFbA8tLObe9RITMPUnQ.png" width="700" height="167" srcSet="https://miro.medium.com/max/552/1*nWybFbA8tLObe9RITMPUnQ.png 276w, https://miro.medium.com/max/1104/1*nWybFbA8tLObe9RITMPUnQ.png 552w, https://miro.medium.com/max/1280/1*nWybFbA8tLObe9RITMPUnQ.png 640w, https://miro.medium.com/max/1400/1*nWybFbA8tLObe9RITMPUnQ.png 700w" sizes="700px" role="presentation"/>

Hooks can be imported and configured in a phoenix project using the LiveSocket configuration in app.js.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*C8UeZtAQt4Zks1cIjYHPJg.png" width="700" height="240" srcSet="https://miro.medium.com/max/552/1*C8UeZtAQt4Zks1cIjYHPJg.png 276w, https://miro.medium.com/max/1104/1*C8UeZtAQt4Zks1cIjYHPJg.png 552w, https://miro.medium.com/max/1280/1*C8UeZtAQt4Zks1cIjYHPJg.png 640w, https://miro.medium.com/max/1400/1*C8UeZtAQt4Zks1cIjYHPJg.png 700w" sizes="700px" role="presentation"/>

For more information on hooks see the [LiveView documentation](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html).

You can then attach this hook to an element in your template which contains your list of books.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1008/1*4TLl4piVGhefkl2zF0qIjA.png" width="504" height="127" srcSet="https://miro.medium.com/max/552/1*4TLl4piVGhefkl2zF0qIjA.png 276w, https://miro.medium.com/max/1008/1*4TLl4piVGhefkl2zF0qIjA.png 504w" sizes="504px" role="presentation"/>

You’ll need to make sure this element allows overflow: scroll, and possibly a height or maximum height.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/944/1*peyotzMKgX6y7WBCiYdL_w.png" width="472" height="105" srcSet="https://miro.medium.com/max/552/1*peyotzMKgX6y7WBCiYdL_w.png 276w, https://miro.medium.com/max/944/1*peyotzMKgX6y7WBCiYdL_w.png 472w" sizes="472px" role="presentation"/>

Final Thoughts.
===============

You now have a much better understanding of pagination!

You have learned about

*   Infinite Scrolling
*   Loading more entries vs loading next entries and removing previous entries.
*   Implementing pagination with Ecto queries
*   Creating a load-more event to load more entries and attach them to the current data set.
*   Triggering the load more event when the user scrolls down using phoenix hooks.

It’s important to say that this is just one way to implement pagination, and how you implement it in your application may differ. But by breaking down the problem into smaller ones it will be easier to understand exactly what you need to solve to get this working.