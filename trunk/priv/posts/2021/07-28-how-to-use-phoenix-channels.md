%{
  title: "How To: Use Phoenix Channels",
  tags: ~w(elixir),
  description: "Build real-time features and a synchronized experience across browsers.",
  cover_image: "07-28-how-to-use-phoenix-channels.jpeg"
}
---

Chris McCord showed how [a single Phoenix server could power a million connections](https://www.youtube.com/watch?v=N4Duii6Yog0). That means a million people send and receive messages in a chat application powered only by a single physical server.

Phoenix is industry-leading when it comes to scalability and real-time systems.

What is a real-time system?
===========================

You might be more familiar with a typical one-way server request. The client requests information from the server, and the server responds.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1240/1*BFxyJWCkhixnVS2lsoD92w.png" width="620" height="260" srcSet="https://miro.medium.com/max/552/1*BFxyJWCkhixnVS2lsoD92w.png 276w, https://miro.medium.com/max/1104/1*BFxyJWCkhixnVS2lsoD92w.png 552w, https://miro.medium.com/max/1240/1*BFxyJWCkhixnVS2lsoD92w.png 620w" sizes="620px" role="presentation"/>

This works fine for most use cases. For example, when you visit this article, you are the client. You request the information in this article, and a Medium server responds by sending it to your computer, phone, or device.

> Author's Note: This article was originally published on the medium blogging platform. 

The client has complete control over requests made to the server. So if you need to check if anything has been updated, the client has to do it.

For cases like the comment section of this article, which could change anytime, the client doesn’t know when to re-request the comment data from the Medium server. Sometimes you can implement a quick fix and request to the server every few seconds, minutes, or whatever interval works best. However, implementing a real-time solution is a more appropriate approach for most use cases.

In a real-time application, communication can be two-way. Unlike in a typical request-response application where the client has complete control over requesting information, the server can communicate to the client. If data changes, then the server can send the client updated information.

Transports
==========

A transport is a method of allowing real-time communication. The two transports supported by phoenix are WebSockets and long polling.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1240/1*YUKvHKye-w_3KT3IWnJsiA.png" width="620" height="200" srcSet="https://miro.medium.com/max/552/1*YUKvHKye-w_3KT3IWnJsiA.png 276w, https://miro.medium.com/max/1104/1*YUKvHKye-w_3KT3IWnJsiA.png 552w, https://miro.medium.com/max/1240/1*YUKvHKye-w_3KT3IWnJsiA.png 620w" sizes="620px" role="presentation"/>

WebSockets
----------

Websockets allow for direct two-way communication between the client and server. Therefore, for most real-time applications, WebSockets are preferable.

At any point, the client or the server can send a message to the other. Websockets are the default method of real-time communication in phoenix.

Long polling
------------

Long polling is another less popular communication protocol for real-time features often used when clients have a poor internet connection. Long polling is a continuous cycle of request and response rather than open two-way communication.

The client establishes a connection. The connection then remains open until the server times out or responds. The client then reestablishes a connection, and the cycle continues.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*-cUzuWOcELfFopro23KCog.png" width="700" height="245" srcSet="https://miro.medium.com/max/552/1*-cUzuWOcELfFopro23KCog.png 276w, https://miro.medium.com/max/1104/1*-cUzuWOcELfFopro23KCog.png 552w, https://miro.medium.com/max/1280/1*-cUzuWOcELfFopro23KCog.png 640w, https://miro.medium.com/max/1400/1*-cUzuWOcELfFopro23KCog.png 700w" sizes="700px" role="presentation"/>

This allows the server to control when to update the client and benefits clients with poor internet connections.

> A client can change from WebSocket to long polling if something goes wrong, such as poor network connectivity.
> 
> \- Pragmatic Programmer

Phoenix Channels
================

> Channels are an exciting part of Phoenix that enable soft real-time communication with and between millions of connected clients.
> 
> Some possible use cases include:  
> \- Chat rooms and APIs for messaging apps  
> \- Breaking news, like “a goal was scored” or “an earthquake is coming”  
> \- Tracking trains, trucks, or race participants on a map  
> \- Events in multiplayer games  
> \- Monitoring sensors and controlling lights
> 
> \- [Phoenix Channel Documentation](https://hexdocs.pm/phoenix/channels.html)

Some other use cases include

*   Collaborative documents
*   Unified cross-tab experience. For example, a shopping cart that updates even across multiple tabs.

Phoenix channels allow real-time features across many clients. Here’s what that looks like in practice.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/960/1*7Xtlz177pyftzU6ktE9Mmw.gif" width="480" height="270" srcSet="https://miro.medium.com/max/552/1*7Xtlz177pyftzU6ktE9Mmw.gif 276w, https://miro.medium.com/max/960/1*7Xtlz177pyftzU6ktE9Mmw.gif 480w" sizes="480px" role="presentation"/>

Notice that when a message is sent, it updates both browser windows.

Phoenix Real-time Infrastructure
================================

When you generate a new phoenix project

```elixir
mix phx.new app
```

Phoenix provides everything you need to get started with real-time features. The important pieces to know are the Endpoint, Socket, Topic, and Channel.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*kytNh6q7tXoP1Qb9D27xIw.png" width="700" height="110" srcSet="https://miro.medium.com/max/552/1*kytNh6q7tXoP1Qb9D27xIw.png 276w, https://miro.medium.com/max/1104/1*kytNh6q7tXoP1Qb9D27xIw.png 552w, https://miro.medium.com/max/1280/1*kytNh6q7tXoP1Qb9D27xIw.png 640w, https://miro.medium.com/max/1400/1*kytNh6q7tXoP1Qb9D27xIw.png 700w" sizes="700px" role="presentation"/>

The Endpoint
------------

> Defines a Phoenix endpoint.
> 
> The endpoint is the boundary where all requests to your web application start. It is also the interface your application provides to the underlying web servers.
> 
> Overall, an endpoint has three responsibilities:
> 
> \- to provide a wrapper for starting and stopping the endpoint as part of a supervision tree  
> \- to define an initial plug pipeline for requests to pass through  
> \- to host web specific configuration for your application
> 
> — Phoenix Endpoint Documentation

In your phoenix application in the `endpoint.ex` file, you’ll notice the Endpoint sets up the user socket by default. It also sets up a LiveView socket, but we’ll focus on the user socket.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*cHaq7UqwfPmD4O5NDJDruA.png" width="700" height="94" srcSet="https://miro.medium.com/max/552/1*cHaq7UqwfPmD4O5NDJDruA.png 276w, https://miro.medium.com/max/1104/1*cHaq7UqwfPmD4O5NDJDruA.png 552w, https://miro.medium.com/max/1280/1*cHaq7UqwfPmD4O5NDJDruA.png 640w, https://miro.medium.com/max/1400/1*cHaq7UqwfPmD4O5NDJDruA.png 700w" sizes="700px" role="presentation"/>

The Socket
----------

The socket ties transports and channels together.

By default, phoenix uses WebSockets instead of long-polling, but it comes with support for both. Notice `websockets: true` and `longpolling: false` in the `socket` method.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1240/1*bdrEiBpMu259CZvxz6p8vg.png" width="620" height="200" srcSet="https://miro.medium.com/max/552/1*bdrEiBpMu259CZvxz6p8vg.png 276w, https://miro.medium.com/max/1104/1*bdrEiBpMu259CZvxz6p8vg.png 552w, https://miro.medium.com/max/1240/1*bdrEiBpMu259CZvxz6p8vg.png 620w" sizes="620px" role="presentation"/>

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*cHaq7UqwfPmD4O5NDJDruA.png" width="700" height="94" srcSet="https://miro.medium.com/max/552/1*cHaq7UqwfPmD4O5NDJDruA.png 276w, https://miro.medium.com/max/1104/1*cHaq7UqwfPmD4O5NDJDruA.png 552w, https://miro.medium.com/max/1280/1*cHaq7UqwfPmD4O5NDJDruA.png 640w, https://miro.medium.com/max/1400/1*cHaq7UqwfPmD4O5NDJDruA.png 700w" sizes="700px" role="presentation"/>

Sockets must define two callbacks, `connect` and `id` . These callbacks are used to authenticate and identify socket connections.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*OvCELAau1nsgKsgq7vZfwQ.png" width="700" height="638" srcSet="https://miro.medium.com/max/552/1*OvCELAau1nsgKsgq7vZfwQ.png 276w, https://miro.medium.com/max/1104/1*OvCELAau1nsgKsgq7vZfwQ.png 552w, https://miro.medium.com/max/1280/1*OvCELAau1nsgKsgq7vZfwQ.png 640w, https://miro.medium.com/max/1400/1*OvCELAau1nsgKsgq7vZfwQ.png 700w" sizes="700px" role="presentation"/>

The socket manages the different channels in your phoenix application. You can connect a channel under a particular context using the built-in `channel` method provided by the `Phoenix.Socket` module. The `channel` method takes in two values, the context for messages and the Channel module to handle messages under that context.

For example, here’s how to connect all messages under the chat context to the ChatChannel. The asterisk * is a wildcard. This means the ChatChannel handles all events under the chat topic.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*D3GAn7WFrrKwh779hmy_5w.png" width="700" height="75" srcSet="https://miro.medium.com/max/552/1*D3GAn7WFrrKwh779hmy_5w.png 276w, https://miro.medium.com/max/1104/1*D3GAn7WFrrKwh779hmy_5w.png 552w, https://miro.medium.com/max/1280/1*D3GAn7WFrrKwh779hmy_5w.png 640w, https://miro.medium.com/max/1400/1*D3GAn7WFrrKwh779hmy_5w.png 700w" sizes="700px" role="presentation"/>

The Channel
-----------

To create a new channel, you can use the `mix phx.gen.channel <ChannelName>`command.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*M7_OTjeNmLm4F0oS3wEO5w.png" width="700" height="174" srcSet="https://miro.medium.com/max/552/1*M7_OTjeNmLm4F0oS3wEO5w.png 276w, https://miro.medium.com/max/1104/1*M7_OTjeNmLm4F0oS3wEO5w.png 552w, https://miro.medium.com/max/1280/1*M7_OTjeNmLm4F0oS3wEO5w.png 640w, https://miro.medium.com/max/1400/1*M7_OTjeNmLm4F0oS3wEO5w.png 700w" sizes="700px" role="presentation"/>

This generates a ChatChannel that looks like this.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*g3_1TVgT8YFXSDjSzUR0iQ.png" width="700" height="713" srcSet="https://miro.medium.com/max/552/1*g3_1TVgT8YFXSDjSzUR0iQ.png 276w, https://miro.medium.com/max/1104/1*g3_1TVgT8YFXSDjSzUR0iQ.png 552w, https://miro.medium.com/max/1280/1*g3_1TVgT8YFXSDjSzUR0iQ.png 640w, https://miro.medium.com/max/1400/1*g3_1TVgT8YFXSDjSzUR0iQ.png 700w" sizes="700px" role="presentation"/>

This channel is responsible for handling the live communication between the client and server.

By default, generated channels contain a `join` method that handles connecting the client to the channel. This `join` method uses the `authorized?` method as a placeholder for any authorization logic that you might want to implement in the future. By default, all `join` requests are authorized.

channels use `handle_in` methods that handle receiving a message from a client. The first parameter of the `handle_in` method is an event name string to pattern match on. The client sends the same event name string so that the channel knows which `handle_in` method should handle the incoming message.

The Client
----------

Phoenix provides a `socket.js` file to handle connecting to the server from the client. There you will find some boilerplate code to handle connecting to a channel.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*e1Oj46rYKfhMAYg48cj-OQ.png" width="700" height="268" srcSet="https://miro.medium.com/max/552/1*e1Oj46rYKfhMAYg48cj-OQ.png 276w, https://miro.medium.com/max/1104/1*e1Oj46rYKfhMAYg48cj-OQ.png 552w, https://miro.medium.com/max/1280/1*e1Oj46rYKfhMAYg48cj-OQ.png 640w, https://miro.medium.com/max/1400/1*e1Oj46rYKfhMAYg48cj-OQ.png 700w" sizes="700px" role="presentation"/>

Change that code to match your topic and subtopic. This should match the string you used for the channel’s join method.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*oYNFNeWaAyallIJxPt48Dg.png" width="700" height="33" srcSet="https://miro.medium.com/max/552/1*oYNFNeWaAyallIJxPt48Dg.png 276w, https://miro.medium.com/max/1104/1*oYNFNeWaAyallIJxPt48Dg.png 552w, https://miro.medium.com/max/1280/1*oYNFNeWaAyallIJxPt48Dg.png 640w, https://miro.medium.com/max/1400/1*oYNFNeWaAyallIJxPt48Dg.png 700w" sizes="700px" role="presentation"/>

Import the socket in your app.js file.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*yOKvcyfaSc7QLpF5J2u4aA.png" width="700" height="326" srcSet="https://miro.medium.com/max/552/1*yOKvcyfaSc7QLpF5J2u4aA.png 276w, https://miro.medium.com/max/1104/1*yOKvcyfaSc7QLpF5J2u4aA.png 552w, https://miro.medium.com/max/1280/1*yOKvcyfaSc7QLpF5J2u4aA.png 640w, https://miro.medium.com/max/1400/1*yOKvcyfaSc7QLpF5J2u4aA.png 700w" sizes="700px" role="presentation"/>

Start your phoenix project using `mix phx.server` and open up your browser console (usually f12), and you’ll see that you’re joining successfully.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*2nE1Qe7zYU3qnhWGY7yiFQ.png" width="700" height="127" srcSet="https://miro.medium.com/max/552/1*2nE1Qe7zYU3qnhWGY7yiFQ.png 276w, https://miro.medium.com/max/1104/1*2nE1Qe7zYU3qnhWGY7yiFQ.png 552w, https://miro.medium.com/max/1280/1*2nE1Qe7zYU3qnhWGY7yiFQ.png 640w, https://miro.medium.com/max/1400/1*2nE1Qe7zYU3qnhWGY7yiFQ.png 700w" sizes="700px" role="presentation"/>

Sending Messages
----------------

you can send messages using the `channel.push()` method

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1382/1*LcfY8y6J-gyQyClSjaNtzw.png" width="691" height="33" srcSet="https://miro.medium.com/max/552/1*LcfY8y6J-gyQyClSjaNtzw.png 276w, https://miro.medium.com/max/1104/1*LcfY8y6J-gyQyClSjaNtzw.png 552w, https://miro.medium.com/max/1280/1*LcfY8y6J-gyQyClSjaNtzw.png 640w, https://miro.medium.com/max/1382/1*LcfY8y6J-gyQyClSjaNtzw.png 691w" sizes="691px" role="presentation"/>

Receiving Messages
------------------

You can handle receiving messages using the `channel.on` method.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*-RDAKU0CpGZ8m8Wz-J3dbA.png" width="700" height="35" srcSet="https://miro.medium.com/max/552/1*-RDAKU0CpGZ8m8Wz-J3dbA.png 276w, https://miro.medium.com/max/1104/1*-RDAKU0CpGZ8m8Wz-J3dbA.png 552w, https://miro.medium.com/max/1280/1*-RDAKU0CpGZ8m8Wz-J3dbA.png 640w, https://miro.medium.com/max/1400/1*-RDAKU0CpGZ8m8Wz-J3dbA.png 700w" sizes="700px" role="presentation"/>

`channel.on` gets triggered by the `broadcast` method inside of the Phoenix Channel.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*tQtLnotCp9Kf7wU1vze9Bw.png" width="700" height="155" srcSet="https://miro.medium.com/max/552/1*tQtLnotCp9Kf7wU1vze9Bw.png 276w, https://miro.medium.com/max/1104/1*tQtLnotCp9Kf7wU1vze9Bw.png 552w, https://miro.medium.com/max/1280/1*tQtLnotCp9Kf7wU1vze9Bw.png 640w, https://miro.medium.com/max/1400/1*tQtLnotCp9Kf7wU1vze9Bw.png 700w" sizes="700px" role="presentation"/>

Here’s what that looks like if you add both methods to the `socket.js` file.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*0uc4CReeZIz8NiZvEMU_LA.png" width="700" height="504" srcSet="https://miro.medium.com/max/552/1*0uc4CReeZIz8NiZvEMU_LA.png 276w, https://miro.medium.com/max/1104/1*0uc4CReeZIz8NiZvEMU_LA.png 552w, https://miro.medium.com/max/1280/1*0uc4CReeZIz8NiZvEMU_LA.png 640w, https://miro.medium.com/max/1400/1*0uc4CReeZIz8NiZvEMU_LA.png 700w" sizes="700px" role="presentation"/>

Now you’ll see the following in your browser console:

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*U880gFfLmKZXNZENgumHxw.png" width="700" height="145" srcSet="https://miro.medium.com/max/552/1*U880gFfLmKZXNZENgumHxw.png 276w, https://miro.medium.com/max/1104/1*U880gFfLmKZXNZENgumHxw.png 552w, https://miro.medium.com/max/1280/1*U880gFfLmKZXNZENgumHxw.png 640w, https://miro.medium.com/max/1400/1*U880gFfLmKZXNZENgumHxw.png 700w" sizes="700px" role="presentation"/>

Intercepting Messages
---------------------

You can intercept messages using the `handle_out` method in the Phoenix Channel. You can override values, perform authentication, or add additional information.

The `handle_out` method is triggered whenever the `broadcast` method is called by the `handle_in` method with the same event string. In this case, “shout.”

You also have to include the event name in an `intercept` call inside of the Phoenix Channel.

To push the message to the client inside of the `handle_out` method use the `push` method.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*fHh3d4IY6BTNQRuQkciFXA.png" width="700" height="248" srcSet="https://miro.medium.com/max/552/1*fHh3d4IY6BTNQRuQkciFXA.png 276w, https://miro.medium.com/max/1104/1*fHh3d4IY6BTNQRuQkciFXA.png 552w, https://miro.medium.com/max/1280/1*fHh3d4IY6BTNQRuQkciFXA.png 640w, https://miro.medium.com/max/1400/1*fHh3d4IY6BTNQRuQkciFXA.png 700w" sizes="700px" role="presentation"/>

When you load the app inside your browser console, you will see the payload with extra information.

<img alt="" class="t u v jo aj" src="https://miro.medium.com/max/1400/1*PS4CKqgfEyKDq6rFHhZNyg.png" width="700" height="131" srcSet="https://miro.medium.com/max/552/1*PS4CKqgfEyKDq6rFHhZNyg.png 276w, https://miro.medium.com/max/1104/1*PS4CKqgfEyKDq6rFHhZNyg.png 552w, https://miro.medium.com/max/1280/1*PS4CKqgfEyKDq6rFHhZNyg.png 640w, https://miro.medium.com/max/1400/1*PS4CKqgfEyKDq6rFHhZNyg.png 700w" sizes="700px" role="presentation"/>

Conclusion
==========

Now you know everything you need to know to handle receiving, sending, and intercepting messages using Phoenix Channels.

If you’d like to know more about what you can do with Phoenix Channels, then the [Phoenix Documentation](https://hexdocs.pm/phoenix/Phoenix.Channel.html) is a great place to start!
