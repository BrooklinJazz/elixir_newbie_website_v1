%{
  title: "From Javascript To Elixir In 14 Days.",
  tags: ~w(elixir jobs),
  description: "A Success Story Onboarding Into Elixir.",
  cover_image: "12-14-javascript-to-elixir-in-14-days.jpg",
}
---

The excitement in the Elixir community is palpable. Few languages spur developer passion like it. I’d seen the excitement but hadn’t felt it myself. I’d heard my friend rant about it, and in the spare moments between spare moments, I glanced at the syntax and toyed with a couple of hobby projects, but no more than that.

> _This post was sponsored by digital product consultancy [DockYard](dockyard.com) to support the Elixir community and to encourage its members to share their stories._


For a long time, It wasn’t the right time. Instead, I focused on learning JavaScript and its ecosystem. There simply wasn’t the time to learn a new language, let alone deeply enough to consider using it professionally.

However, Elixir enables fast onboarding. It's known for its high productivity and a gentle learning curve. At least, that's what I had heard. That’s why, when I received an offer to interview for an Elixir job, I accepted, betting that I could learn enough in time.

It was a gamble, and I was scared I’d be wasting my time trying to transition into a new language. However, two weeks, several blogs, two interviews, and a demo project later, I received an offer and am now a full-time Elixir developer.

In only fourteen days, the Elixir ecosystem and community enabled me to go from a JavaScript developer to an Elixir developer. On top of the language features that make Elixir easier to learn, I employed several strategies to increase my learning speed. 

I hope you’ll take the lessons I learned and apply them to onboard yourself and other developers into Elixir.

# The Intro Interview.

![](/images/js-to-elixir-14-days/1.jpg)

In seven days, I needed to learn enough about Elixir to engage in conversation and create an Elixir-focused resume to be considered for the position.

If that went well, I would need to create a project to demonstrate my ability with Elixir and pass a technical debugging challenge seven days after the first interview.

Fortunately, I love writing. Writing allows you to teach others what you learn, and teaching is one of the most effective ways to learn.

## Natural Readable Syntax.

![](/images/js-to-elixir-14-days/2.jpg)

For the first week to prepare for the Intro interview and build some Elixir experience, I focused on learning and writing about Elixir fundamentals. During this time, I wrote [The 20% of Elixir Syntax You Need to Understand 80% of Elixir Code.](https://www.elixirnewbie.com/blog/the-20%25-of-elixir-syntax-you-need-to-read-80%25-of-elixir-code).

In my experience, Elixir feels highly thought out, modular, and elegant. Elixir’s modularity makes it easier to dissect, condense, and learn. If you’re learning Elixir or helping other developers learn. Consider listing the essential topics. Deconstructing what you want to know ensures you spend your time wisely.

Elixir stemmed from the ruby and ruby on rails community. Ruby is already considered a developer-friendly language. Elixir takes that same desire for readability and developer quality of life and extends it further.

Elixir is a functional programming language. Compared with object-oriented programming, functional programming has a reputation for being harder. However, this isn’t true in practice. 

You can think of functional programs as a pipeline that transforms data. For example, in Elixir, the pipe operator connects the output of one function to the input of another. By thinking of your program as input and output, it’s easier to follow the flow of related code.

## Built in Testing.

If you know how to write the test, then you've solved the hard problem, and the code follows naturally from it. However, testing in JavaScript can be clunky. There are too many library options, you have to configure them manually, and tests could be flakey, especially for UI. 

Elixir was designed to be testable and integrates its testing framework directly into the language. ExUnit, the built-in testing library, dramatically reduces the barrier to writing tests and unifies the community on a standard solution.

## The OTP Framework.

Elixir is built on top of Erlang. Erlang was inspired by the problems in telephony applications that needed to be highly available, distributed, fault-tolerant, concurrent, and real-time. However, most other programming languages were inspired to optimize for the speed of a single processor because it fit the needs of web and mobile applications during their inception.

Nowadays, programming challenges have evolved, and nearly every application needs real-time functionality. Elixir, arguably more so than any other programming language, provides simple abstractions through a process-oriented framework called OTP to tackle these notoriously tricky challenges.

You don't even need to use or learn these real-time features to benefit from them. For example, if you use Phoenix, a framework for Elixir web applications, Phoenix makes a process for every request, so your application is automatically more process-oriented and therefore scalable.

While I have since learned the real-time abstractions that Elixir provides, I did not need to learn about OTP to pass the technical interview and perform the most common tasks in a typical web development environment. So while OTP is useful, it’s also something you can learn as necessary. The same is true for many advanced concepts in Elixir.


## Unified Ecosystem.

![](/images/js-to-elixir-14-days/3.jpg)

Learning a language does not only mean learning the core syntax. It also includes understanding the ecosystem and learning common libraries. Elixir hits the sweet spot for ecosystem size for me. It's not overly bloated so you don’t feel paralyzed with the choice of having ten different libraries that all do the same thing. But, it's also full enough to have a tool for almost every job.

The Elixir Ecosystem has done a terrific job of unifying tools. The unified ecosystem reduces the mental overhead when deciding which additional tools you should use. For example, The test framework ExUnit is baked directly into Elixir, thus eliminating the cognitive overhead of picking and configuring a test framework.

As a newbie, this made the learning path for Elixir far simpler. For example, to learn web development in Elixir focus on Phoenix. For the same in Javascript, you have dozens of front-end, back-end, or full-stack frameworks you could learn. Simply deciding what to learn is overwhelming.

If you’re working in a specific niche. Elixir’s Ecosystem may be limited compared to other languages, so it’s worth researching to ensure it has the libraries you need. However, Elixir provides you with powerful tools if you ever need to write something from scratch. At first, the lack of libraries was a common problem with Elixir, but as the ecosystem grows, it's less common to write your own library for an already solved problem.

## Learning Materials and Support from the Community.

![](/images/js-to-elixir-14-days/4.jpg)

Elixir has an abundance of excellent learning material. The Elixir documentation is concise, and online resources such as ElixirSchool.com have done a fantastic job providing the community with a well-structured learning path. The list of resources is long, so if you want more, consider reading [From Elixir Newbie to Elixir Developer: Create Your Learning Path](https://www.elixirnewbie.com/blog/from-elixir-newbie-to-elixir-developer-create-your-learning-path).

The community is also incredibly supportive on typical developer platforms such as Stack Overflow and Twitter and Elixir-specific platforms such as the Elixir Slack and Elixir Forum. There is always a place to ask your question and benefit from the experience of the community.

## Passing the First Interview.
After a week of learning Elixir, It was time for the first interview. Despite having no projects, they were impressed by the writing I'd managed to do on Elixir. They were also happy with the amount I’d learned since starting.

Thankfully they moved me through to the technical portion of the interview. In the upcoming week, I’d need to prepare an Elixir project and be ready to perform a live debugging challenge.

# The Demo Project: A Realtime Blog with Phoenix.

Most web applications are CRUD applications. They create, read, update, and destroy data. A blog is a perfect project for learning how to perform these fundamental operations and quickly pick up the necessary skills for the job.

To give it an elixir spin, I wanted the blog to operate in real-time. So when you create a blog post, that blog post would instantly appear to any users looking at the feed.

If you’re curious about what came from the process, you can see the project [here](https://github.com/BrooklinJazz/phoenix_blog). It’s beginner-level code, but it was a great way to get a fast applied overview of web development with Elixir.

## Phoenix Framework.

Phoenix is the web development framework for Elixir. It’s essentially a collection of Elixir tools packaged together to make it easier to build web apps. Each tool is explicit, so if you want to know how anything works, you can read the code behind it.

Getting started with Elixir and Phoenix is very streamlined. The documentation for Elixir and Phoenix is well-paced, and the mix build tool makes it very straightforward to get a blank project up and running in a few minutes.

With a deadline of one week, this would generally be an ambitious project for an Elixir newbie. However, Phoenix provides out-of-the-box tools that enable rapid development. Phoenix integrates with a data persistence framework called Ecto for typical CRUD operations with a database. In addition, Phoenix exposes a PubSub module for broadcasting and receiving messages that empower real-time features. In only a few lines of code PubSub enabled a live list of blogs that reloaded when a blog is added, updated, or deleted.

# The Technical Interview

The goal of the interview was to talk through my demonstration project and live debug a problem from a previous version of their codebase.

Understanding debugging is critical to being an effective developer in any programming language. Elixir’s debugging tools include the ability to log messages and pause code execution at breakpoints in your code during runtime.

At first glance, you might think this sounds like many high-level programming languages. However, Elixir provides additional benefits that make a huge difference in your debugging ability and speed. For example, the IO module prints and returns values. Therefore, you can debug without rewriting your code since it returns the value it inspects. 

Thanks to Elixir’s debugging tools, I was able to show up to the interview, follow the flow of code causing the bug, and find the root cause so I could come up with a potential solution. Upon completion, I received an offer and accepted it!

![](/images/js-to-elixir-14-days/5.jpg)

Now that I'd received an offer to join the team, it was time to go beyond the fundamentals and learn more in-depth about Elixir and specifics particular to the project. While no project is the same, Phoenix encourages similar project structure and patterns, so I felt reasonably comfortable with the codebase straight away.

Elixir allows you to do a lot with the fundamentals. So, armed with the basics, I built features using the same patterns I learned in the blog project. Repetition solidified the fundamentals I’d learned so far, and delivering features allowed me to go beyond the basics and learn specific skills as needed.


## Object Oriented Baggage

Some languages feel more familiar than others and allow you to carry over more or less knowledge from your previous background. For example, developers from Ruby often have a great experience transitioning to Elixir.

As a JavaScript developer, I found that much of your previous experience carries over. Of course, there were some moments where Object-Oriented baggage comes in (I still call module functions “methods” sometimes), but personally, it hasn’t required too much adjustment. However, I’d already learned some functional programming in JavaScript, so everyone’s path is going to be different.

I’ve heard from other object-oriented developers, learning how to think functionally can be challenging. However, for developers who haven’t already learned object-oriented programming, functional programming can feel more natural to how they think about programming by default.

## Test So You Can Code With Confidence.

Due to Elixir's built-in testing system, it was easy to use the existing tests and encourage more testing on the team.

A solid test suite gives you confidence in writing code, enabling you to develop quickly without worrying that you have broken any existing systems. If you want to allow fast onboarding, have a solid test suite.

Fortunately, I’ve found testing in Elixir to be straightforward and reliable. Elixir is a functional programming language, so ideally, functions are pure. Pure functions have no side effects and simply take input and return output. Breaking your system into small pure functions makes it easier to test.

# 14 Days and Half a Year Later.

![](/images/js-to-elixir-14-days/6.jpg)

Elixir feels easy to learn and hard to master. The learning curve is gradual, and you can learn each concept independently. With only basics, you can get a lot done, and if you want to dive deeper, there are great resources to learn more. When you struggle or have a highly contextual question, the community is incredibly supportive and helpful.

The greatest joy comes from experimenting with patterns and learning how to write higher-quality code. In addition, the Elixir community is inspiring. Other developers and community members expose you to new ideas and ways of thinking that you would have a hard time encountering on your own.

The community has worked hard to provide libraries that make your life easier. For example, I’ve found Wallaby useful for end-to-end testing, Mox for creating test mocks that mimic behavior in your system, ExMachina for making test factories, and Faker for generating random test data.

I’ve also since dived deeper into the OTP platform. Learning the abstractions provided by the OTP framework feels like a superpower. Learning OTP allows you to think about processes in your system directly. This process-oriented programming paradigm makes it easier to think about concurrency and real-time features. OTP provides abstractions like Genservers that represent a process in your system. Processes can communicate with other processes via messages and encapsulate their internal data. Processes act independently and concurrently, but each process acts as a point of synchronization, so it’s simpler to reason about how your system will behave. You don’t need to rely on complex concurrency mechanisms or deal with frustrating race conditions with processes.


While the learning curve is gradual, the depth of knowledge is infinite. In fourteen days, I became a productive developer armed with solid fundamentals. Since then, I’ve constantly discovered new patterns and tools that upgrade my ability as a developer. Finding new and useful language features nearly every day brings me back to the early days of learning programming, where simply centering a box on a page would make you jump in joy.

Beyond that, seeing the enjoyment and passion in other developers inspires me to continue learning and growing. I’ve been genuinely shocked by the supportiveness in this community and can’t overstate how excited I am to be a part of it.

Fourteen days and half a year’s experience later, I’m still loving the experience of learning Elixir and using it to write testable, readable, and high-quality code.
