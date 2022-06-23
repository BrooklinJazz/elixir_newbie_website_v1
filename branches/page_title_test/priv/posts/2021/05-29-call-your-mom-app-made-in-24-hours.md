%{
  title: "Call Your Mom app made in 24 hours for #Hack4Health",
  tags: ~w(react_native),
  description: "My experience building a React Native app in 24 hours",
  cover_image: "05-29-call-your-mom-app-made-in-24-hours.png"
}
---

For a recent [Hack4Health Hackathon](https://event.hackhub.com/event/hack4health), My team and I decided to have some fun building a mobile app that would help you remember to call your mom.

In this post, I’ll discuss how we went through the phases of developing the app in 24 hours, including brainstorming, creating mockups of the design, and implementing the app in React Native. Hopefully, you find the story enjoyable, and if you’re doing a hackathon yourself can use the story to help inspire your own process.

Links
-----

*   [The hackathon submission](https://event.hackhub.com/event/hack4health/submissions/5071) (includes a video demoing the app)
*   [The code repository](https://gist.github.com/BrooklinJazz/e20cd8ce208f1848a879a646cb625065)
*   [Brooklin Myers (Me) (Software Engineer and Team Lead)](https://www.linkedin.com/in/brooklinmyers/)
*   [Kealy Doyle (Software Engineer)](https://www.linkedin.com/in/kealy-doyle/)
*   [Kayla Wu (Designer)](https://www.linkedin.com/in/kayla-wu-designer/)

I hope to upload the app on the play store and app store so that you can download it onto your phone, but for now, if you want to run the app locally, you can close the repository and run it using expo. Getting started instructions are included in [the repository.](https://github.com/BrooklinJazz/call-your-mom)

Brainstorming an app idea
-------------------------

For the Hack4Health hackathon, We went through a list of possible app ideas, including

*   A kids education app using gamification.
*   An emotional diagnostic app.
*   A motivational habit app using Tamagotchi-like pets motivates you to take care of yourself by taking care of them.
*   A friend-finding app based on shared interests.
*   A digital dog walking app where you walk a virtual dog.
*   A social platform for study buddies

Out of nowhere, I suggested, “What about an app that makes you call your mom?”. We latched onto the idea pretty quickly because it had a fun tone, it felt doable given the timeframe, and I think everyone’s been that “bad” son or daughter who forgets to call their mom enough.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*MQuzoqNhNneo2Vo8uxO6nw.png" width="700" height="394" srcSet="https://miro.medium.com/max/552/1*MQuzoqNhNneo2Vo8uxO6nw.png 276w, https://miro.medium.com/max/1104/1*MQuzoqNhNneo2Vo8uxO6nw.png 552w, https://miro.medium.com/max/1280/1*MQuzoqNhNneo2Vo8uxO6nw.png 640w, https://miro.medium.com/max/1400/1*MQuzoqNhNneo2Vo8uxO6nw.png 700w" sizes="700px" role="presentation"/>

Creating a list of app features
-------------------------------

Now that we had an idea, we needed to think about what the app would do. For this, we made a Trello board and broke our features out into individual user stories. We also separated features into what we absolutely had to accomplish for the MVP and what would be cool to work on if we had time. Since we only had 24 hours, we were pretty strict about keeping a small MVP.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*UPYx3Rg4RpPZrhK-WmxNQA.png" width="700" height="693" srcSet="https://miro.medium.com/max/552/1*UPYx3Rg4RpPZrhK-WmxNQA.png 276w, https://miro.medium.com/max/1104/1*UPYx3Rg4RpPZrhK-WmxNQA.png 552w, https://miro.medium.com/max/1280/1*UPYx3Rg4RpPZrhK-WmxNQA.png 640w, https://miro.medium.com/max/1400/1*UPYx3Rg4RpPZrhK-WmxNQA.png 700w" sizes="700px" role="presentation"/>

Creating rough mockups for the app flow
---------------------------------------

Kayla, our designer on the team, went and created some rough drafts to help us understand the flow of the app. The purpose of these was not to provide nice visuals or a design but to understand how the app would function.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*e9zXFPSonyDK_N5Bc4rkxQ.png" width="700" height="392" srcSet="https://miro.medium.com/max/552/1*e9zXFPSonyDK_N5Bc4rkxQ.png 276w, https://miro.medium.com/max/1104/1*e9zXFPSonyDK_N5Bc4rkxQ.png 552w, https://miro.medium.com/max/1280/1*e9zXFPSonyDK_N5Bc4rkxQ.png 640w, https://miro.medium.com/max/1400/1*e9zXFPSonyDK_N5Bc4rkxQ.png 700w" sizes="700px" role="presentation"/>

From here, Kealy and I, as the developers, had enough information to start building out app functionality. We used [Expo](https://docs.expo.io/) to scaffold a new React Native project and started working through tickets. We wrote some code that would allow us to:

*   **make a phone call.** This is surprisingly easy in react native. You can trigger this function on some event (the push of a “Call Your Mom” button), and it will open the call app on the user’s device with the pre-entered phone number.

*   **Navigate between the settings, home, and call history screens.** We also added some placeholders for the screens with whatever rough mock functionality existed at the time.

*   **Add global storage through react-redux and redux-persist** so that we could take the information provided by the user (such as their mom’s phone number) and store it. It’s important to note that you should do this on a server for both functionality and security reasons. But we only had 24 hours, and this is a proof of concept, not the ideal implementation of the app.
*   **Track each time the user calls their mom through the app to keep a list of call history.** Ideally, the app would integrate directly with call history on the device, but we didn’t have time to get fancy.

The final round of mockups
--------------------------

By the time we had most of the important functionality in place, Kayla had finished making much more sophisticated mockups with the desired design.

<img alt="" class="ef es eo ex w" src="https://miro.medium.com/max/1400/1*h93gawNkB9v78BI3WDruPw.png" width="700" height="507" srcSet="https://miro.medium.com/max/552/1*h93gawNkB9v78BI3WDruPw.png 276w, https://miro.medium.com/max/1104/1*h93gawNkB9v78BI3WDruPw.png 552w, https://miro.medium.com/max/1280/1*h93gawNkB9v78BI3WDruPw.png 640w, https://miro.medium.com/max/1400/1*h93gawNkB9v78BI3WDruPw.png 700w" sizes="700px" role="presentation"/>

Kayla did a really great job designing these. We spoke back and forth, making small adjustments to the mockups and deciding on the final color pallet.

Updating the app with the new design
------------------------------------

Armed with the final mockups, we started implementing the new design. This was a pretty arduous process, and I was personally up until about 5 am making sure the app looked how we all wanted it to.

Presenting the app
------------------

As the team lead, I was responsible for presenting the app, so I spent the following morning practicing and rehearsing a 4-minute talk about the app.

We also ran through the app, doing some last-minute QA and bug fixing to ensure that everything would be working and ready for the presentation.

I recorded a hastily recorded [youtube video of my talk](https://www.youtube.com/watch?v=79jpYwHdjYQ) with only 10 minutes left to submit, and we managed to submit it just before the last minute of the deadline. Kayla made some great slides that you can see in the video as well.

The presentation went pretty well. The judges gave us some excellent feedback on our app and some possible future features. Overall they seemed really happy with our presentation, and we waited excitedly afterward, hoping they scored us favorably.

We make it to the finals!
-------------------------

The judges selected our app to move on to the final round of the hackathon. The top 10 apps were all chosen, and we got to see some amazon projects from the other contestants.

Unfortunately, we didn’t wind up taking the top spot! An app called [Champ](https://event.hackhub.com/event/hack4health/submissions/5050) won. They had a really cool idea to build an app that uses losing money as a negative reinforcement to encourage users to accomplish positive challenges like riding their bike or working out.

However, we’re all really proud of what we built, especially given how fast we built it with a small 2 developers and 1 designer team. We got to meet some really great people either participating in or helping to organize the event, and we are all glad to have had the experience.

Wrapping up
-----------

This was my first hackathon despite being in the industry for years now. I really fell in love with the format. There’s something enjoyable and motivating about needing an app done with such a tight time limit. It forces you to be resourceful and pushes you creatively.

If you’re thinking about joining in a hackathon, I hope this post helps motivate you and gives you an idea of what the experience is like!