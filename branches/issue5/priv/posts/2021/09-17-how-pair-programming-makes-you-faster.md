%{
  title: "How Pair Programming Makes You Faster.",
  tags: ~w(pair_programming),
  description: "When You Optimize For Thinking Speed, Then 1 + 1 = 3.",
  cover_image: "09-17-how-pair-programming-makes-you-faster.jpeg"
}
---

Pairing is the process of creating software collaboratively. It’s usually done between 2 developers though other forms of it involve more people.

Typically one person will be the navigator, and the other person will be the driver.

The Driver.
-----------

The driver is the person who controls the keyboard. The driver worries about the trees, not the forest. They wrote the code and worry about the specific implementation details.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*AJXMH18bhEAitxqsW3puxA.jpeg" width="700" height="467" srcSet="https://miro.medium.com/max/552/1*AJXMH18bhEAitxqsW3puxA.jpeg 276w, https://miro.medium.com/max/1104/1*AJXMH18bhEAitxqsW3puxA.jpeg 552w, https://miro.medium.com/max/1280/1*AJXMH18bhEAitxqsW3puxA.jpeg 640w, https://miro.medium.com/max/1400/1*AJXMH18bhEAitxqsW3puxA.jpeg 700w" sizes="700px" role="presentation"/>

Photo by [why kei](https://unsplash.com/@whykei?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/driver?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

The Navigator
-------------

The navigator is the person who provides suggestions and instructions to create the code. The navigator worries about the forest, not the trees. They handle the big picture. They have the luxury of sitting back and thinking about the codebase as a whole without the tendency to get tunnel vision on details.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*rv9kadG6E2Mgx3Os4kQNfQ.jpeg" width="700" height="467" srcSet="https://miro.medium.com/max/552/1*rv9kadG6E2Mgx3Os4kQNfQ.jpeg 276w, https://miro.medium.com/max/1104/1*rv9kadG6E2Mgx3Os4kQNfQ.jpeg 552w, https://miro.medium.com/max/1280/1*rv9kadG6E2Mgx3Os4kQNfQ.jpeg 640w, https://miro.medium.com/max/1400/1*rv9kadG6E2Mgx3Os4kQNfQ.jpeg 700w" sizes="700px" role="presentation"/>

Photo by [Tabea Damm](https://unsplash.com/@tabeadamm?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

Pairing Keeps Your Team Connected.
----------------------------------

I used to work on a team that paired every single day. Every. Single. Day. It was special. The entire team grew quickly, became very tightknit. You get to spend more time with your coworkers, and you get to know each other better.

In a world moving towards remote work, staying connected and avoiding feeling separated and siloed from the rest of your team is even more important.

Rather than only communicating during meetings or code reviews, you communicate all the time. It’s built-in team building.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*6tZ9qha4HcQm-PzIo0iO_A.jpeg" width="700" height="467" srcSet="https://miro.medium.com/max/552/1*6tZ9qha4HcQm-PzIo0iO_A.jpeg 276w, https://miro.medium.com/max/1104/1*6tZ9qha4HcQm-PzIo0iO_A.jpeg 552w, https://miro.medium.com/max/1280/1*6tZ9qha4HcQm-PzIo0iO_A.jpeg 640w, https://miro.medium.com/max/1400/1*6tZ9qha4HcQm-PzIo0iO_A.jpeg 700w" sizes="700px" role="presentation"/>

Photo by [Priscilla Du Preez](https://unsplash.com/@priscilladupreez?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/connected-team?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

Pairing Spreads Knowledge on the Team.
--------------------------------------

Team standards don’t need to be written in a design document when you discuss them every day.

In a pair programming session today, we talked about [testing standards and the 3A’s of testing (Arrange, Act, Assert)](https://www.elixirnewbie.com/blog/readable-test-code-matters), readable code, [debugging](https://www.elixirnewbie.com/blog/debugging-phoenix-and-elixir-applications-in-visual-studio-code), and test-driven development. I didn’t know these concepts early in my career, and it took a long time to pick up. While the developer I was pairing with got to learn them in a day. In addition, Thanks to my pair partner, I learned about testing Phoenix Live Views and got a better understanding of the business logic in our application.

You become a better communicator. You learn to talk about code and talk through complex ideas by practicing regularly. You learn how to teach others, and by teaching others, you learn a lot more yourself.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/0*a1szcBjLv2hKLPwJ.jpg" width="700" height="467" srcSet="https://miro.medium.com/max/552/0*a1szcBjLv2hKLPwJ.jpg 276w, https://miro.medium.com/max/1104/0*a1szcBjLv2hKLPwJ.jpg 552w, https://miro.medium.com/max/1280/0*a1szcBjLv2hKLPwJ.jpg 640w, https://miro.medium.com/max/1400/0*a1szcBjLv2hKLPwJ.jpg 700w" sizes="700px" role="presentation"/>

I’m sorry I couldn’t resist.

Pairing Improved Code Quality and Reduces Time Spent Reviewing PRs.
-------------------------------------------------------------------

You had another dev with you the entire time—likely, another dev who would have been responsible for doing your code review. This means you can have much quicker feedback and don’t need to go through endless review cycles. As a result, it’s less frustrating, and it’s faster.

You may even choose to remove code reviews entirely and opt for a trunk-based development style where every push goes directly to master instead of going through a pull request.

Pairing Improves Development Speed.
-----------------------------------

But but but there’s only one keyboard! At first, it doesn’t make sense. You can split up two developers and have them work on two different features. Why would you have them work together and halve their progress?

Well, the bottleneck to development is not programming speed. The bottleneck to development is thinking speed.

By putting two programmers together, you leverage the awesome power of human communication.

That feature you weren’t quite sure about how to implement with existing functionality? Your pair partner worked on that code area a few days ago and can share the domain knowledge learning with you.

That bug you spent an hour on? Solved in 15 minutes because your pair partner had an idea that you didn’t.

That awful bit of code that halts everyone's progress whenever they have to work with it? It was never written in the first place.

By leveraging two brains together, you get immediate short-term speed improvement. If you pair, you’ll often say to yourself, “that would have taken me hours extra on my own.” (That’s a direct quote from my last pair session).

It might not make sense to you at first, but when you pair: 1 + 1 = 3 when it comes to developer productivity.

The Long-Term Benefits Are Worth It.
------------------------------------

Sure, sometimes a feature will take a bit longer when pairing. But this is vastly offset by the long-term results. Because your team engages in knowledge sharing, everyone is a better developer for it. You optimize for the global team speed rather than optimize for the local speed of a single developer. Over time this results in a highly competent team of developers more capable of writing quality code quickly.

Final Thoughts.
---------------

I hope this article inspires you to give it a try, and if you already love pairing, I hope this article gives you even more reason to.

On the other hand, what do you think about my reasoning if you don't love pairing? I hope to write an article in the future on the flaws and pitfalls of pairing and would love your feedback.