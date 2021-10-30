![[https://depositphotos.com/category/industrial.html](https://depositphotos.com/category/industrial.html)](https://cdn-images-1.medium.com/max/9824/1*L5dti-Uzb9LiLyuUhhfcGA.jpeg)

This post is an accumulation of what I’ve learned researching threads in React Native. Hopefully, it should help you:

* Understand threads and processes.

* Understand the main threads and processes that React Native uses to run your program.

* Debug common issues with threads that result in performance issues.

* Clarify how React Native uses the terms thread and process interchangeably

### What is a thread?

A thread is short for a thread of execution. You can think of a thread as a set of instructions to be executed by the CPU. A thread is a component of a process.

### What is a process?

A process is a program that is running. For example, the browser (perhaps Google Chrome, Safari, or Firefox) you are using to view this article is a process. In fact, If you want to see all of the processes that are running on your computer, you can open up the Task Manager on Windows or the Activity Monitor on mac. You should see all of the processes running on your computer.

![](https://cdn-images-1.medium.com/max/2000/1*4ZQEMZ8BvoPlKruHOC6JXw.png)

Every process has one or more threads. And a program can actually be made up of many processes. In the example above, you’ll notice that it says Google Chrome (44). This means that Google Chrome is actually running 44 different processes. Processes in a single program are referred to as **child processes**. A program that uses multiple processes is referred to as **multi-processed.**

### Single-threaded

Single-threaded means that a process is designed to have only one thread of execution. This means only one set of instructions executes at once.

For example, imagine you have a simple program. It’s designed to calculate the result of a series of mathematical equations. In this case:

```elixir
(5+5)-(10–4)
```

As a single-threaded program, the program can only run one instruction at a time. A single instruction is one addition or subtraction statement. From start to finish, the evaluation of this program by the CPU would look like:

step 0: (5+5)-(10–4)
step 1: (10)-(10–4)
step 2: 10-(6)
step 3: 4

### Multi-threaded

Multi-threaded means that a process has two or more threads. So it can execute multiple instructions simultaneously.

As a multi-threaded program, several instructions can run at a time. Let’s pretend this program has two threads. So, the program can run two instructions at a time. From start to finish, the evaluation of this program by the CPU would look like:

step 0: (5+5)-(10–4)
step 1: (10)-(6) // Notice that both steps 5+5 and 10–4 were accomplished during the same step.
step 2: 4

### React Native is single-threaded

This means that for each process, there is only a single thread. Now in the example above, you might wonder why React Native would be single-threaded instead of multi-threaded. After all, multi-threading accomplished the calculation in fewer steps (i.e., faster), so it must be better, right? Well, not necessarily. The purpose of this article isn’t to do a deep dive on multi-threading vs. single-threading but suffice it to say that that multi-threading has some disadvantages, including [increased complexity, difficulty in testing, and performance costs](https://en.wikipedia.org/wiki/Thread_(computing)#Single-threaded_vs_multithreaded_programs).

Because React Native is single-threaded, if you have a process that has many responsibilities, you can have performance problems. Imagine you have a process responsible for rendering a video on the screen and a live feed of comments on the video. The video rendering could block the live feed from updating correctly, or the live feed could cause stuttering in the video.

### React Native is multi-processed.

Instead of running multiple threads, React Native runs multiple processes. 3 main processes run in React Native and 1 process that only runs on Android L (5.0). If you want to create more processes, you can also use the library [react-native-threads](https://github.com/joltup/react-native-threads).

* **UI Thread**. This process is used for handling rendering android and ios views.

* **JS Thread**. This process is used for handling all of the logic of your react native application.

* **React Native Modules Thread**. This happens when an app needs to access a platform API. For example, if you’re working with animations, you may use the native driver to handle your animations.

* **React Native Render Thread**. Android L (5.0) only uses this to draw the UI with OpenGL. Because this is only used in specific situations, I will ignore this process moving forward and only write about the main 3.

In React Native, every process has only one thread. Unfortunately, because of this, people often use the terms interchangeably. You’ll notice UI Thread, JS Thread, and React Native Modules Thread are actually all processes, and [react-native-threads](https://github.com/joltup/react-native-threads) actually implements multi-processing.

### Debugging Processes and Threads in React Native

By understanding these three main processes in React Native (JS Thread, UI Thread, and React Native Modules Thread), you can better understand why you experience performance issues in React Native. Common issues include:

* Animations blocking the JS Thread.

* Slow navigation transitions during timeouts or animations.

* Expensive computations or large data causing the slowness.

* Stuttering during a components mounting logic.

You can solve many animation issues by using the React Native Modules Thread instead of the JS Thread. the React Native [Animated](https://reactnative.dev/docs/animated#using-the-native-driver) API allows you to configure your animations with useNativeDriver: true so the animation does not block the main JS Thread.

You can also use the React Native [Interaction Manager](https://reactnative.dev/docs/interactionmanager) to fix competing actions (animation and navigation, for example) from causing performance issues by scheduling one action to only start after the other has finished.

### Conclusion

You should now better understand how React Native uses threads and processes to run your application and how to use that knowledge to fix common performance issues that can happen in React Native.
