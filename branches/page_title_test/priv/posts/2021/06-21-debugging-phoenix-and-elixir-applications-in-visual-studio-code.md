%{
  title: "Debugging Phoenix and Elixir Applications in Visual Studio Code.",
  tags: ~w(elixir phoenix debugging),
  description: "Spend less time fixing code and more time delivering valuable new features.",
  cover_image: "06-21-debugging-phoenix-and-elixir-applications-in-visual-studio-code.jpeg"
}
---

Knowing how to debug your Phoenix or Elixir project properly is the difference between finding a bug in a few minutes or spending the next few painstaking hours reading thousands of lines of code looking for the one line that’s causing your app to crash, your boss to lose their hair (there’s a reason many developers are bald), and your users to abandon ship.

In this article, you’re going to learn how to leverage IO, IEX, and the built-in Visual Studio Code debugger to improve your debugging ability.

Debugging using Elixir’s IO module
==================================

The simplest way to debug is printing. You can print values using the IO.puts and IO.inspect functions.

IO.puts
-------

IO.puts is used for simple, readable values which implement the String.Chars protocol. This includes integers, strings, and atoms.

```elixir
iex(1)> IO.puts("example string")  
example string  
:ok  
iex(2)> IO.puts(:example_atom)  
example_atom  
:ok  
iex(3)> IO.puts(2)  
2  
:ok
```

IO.puts will crash if you give it something like a tuple.

```elixir
iex(1)> IO.puts({1, 2, 3})   
** (Protocol.UndefinedError) protocol String.Chars not implemented for {1, 2, 3} of type Tuple  
    (elixir 1.11.2) lib/string/chars.ex:3: String.Chars.impl_for!/1  
    (elixir 1.11.2) lib/string/chars.ex:22: String.Chars.to_string/1  
    (elixir 1.11.2) lib/io.ex:686: IO.puts/2
```

IO.puts can also give weird values for lists because it’s not converting elixir’s internal representation of the value back into something human-readable.

```elixir
iex(1)> IO.puts \[1, 2, 3\]                  
☺☻♥  
:ok
```

IO.inspect
----------

IO.inspect knows how to print all data structures, including lists, structs, tuples, and maps.

```elixir
iex(1)> IO.inspect(\[1,2,3\])   
\[1, 2, 3\]  
\[1, 2, 3\]iex(2)> IO.inspect({1,2,3})   
{1, 2, 3}  
{1, 2, 3}iex(3)> IO.inspect(%{"example" => "map"})   
%{"example" => "map"}  
%{"example" => "map"}
```

You’ll notice that inspect appears to print everything twice. Actually, inspect only prints once, and iex prints the return value. That’s right, IO.inspect returns the value passed to it. Here’s an example using a function that returns a tuple. This function still returns the tuple {1, 2, 3}, and also prints {1,2,3}.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/916/1*_JbwulXq8JmHKdAYwDVN4A.png" width="458" height="175" srcSet="https://miro.medium.com/max/552/1*_JbwulXq8JmHKdAYwDVN4A.png 276w, https://miro.medium.com/max/916/1*_JbwulXq8JmHKdAYwDVN4A.png 458w" sizes="458px" role="presentation"/>

So when I run the function elsewhere, it has the correct return value.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*6chWSAmg1sQRqRoLC0muzA.png" width="700" height="258" srcSet="https://miro.medium.com/max/552/1*6chWSAmg1sQRqRoLC0muzA.png 276w, https://miro.medium.com/max/1104/1*6chWSAmg1sQRqRoLC0muzA.png 552w, https://miro.medium.com/max/1280/1*6chWSAmg1sQRqRoLC0muzA.png 640w, https://miro.medium.com/max/1400/1*6chWSAmg1sQRqRoLC0muzA.png 700w" sizes="700px" role="presentation"/>

If you want, you can clone the [example repository](https://github.com/BrooklinJazz/debugging_elixir) and run `mix test`. You should see something like this.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1206/1*GTkqoU6B57PoJufNnR1ptg.png" width="603" height="207" srcSet="https://miro.medium.com/max/552/1*GTkqoU6B57PoJufNnR1ptg.png 276w, https://miro.medium.com/max/1104/1*GTkqoU6B57PoJufNnR1ptg.png 552w, https://miro.medium.com/max/1206/1*GTkqoU6B57PoJufNnR1ptg.png 603w" sizes="603px" role="presentation"/>

You can also give your inspect values a label to make them easier to read.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1210/1*smnBzTB7VmTO0J0bViKDGg.png" width="605" height="158" srcSet="https://miro.medium.com/max/552/1*smnBzTB7VmTO0J0bViKDGg.png 276w, https://miro.medium.com/max/1104/1*smnBzTB7VmTO0J0bViKDGg.png 552w, https://miro.medium.com/max/1210/1*smnBzTB7VmTO0J0bViKDGg.png 605w" sizes="605px" role="presentation"/>

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1208/1*lZ7EhxZ-lHxvbyia5QKbSg.png" width="604" height="214" srcSet="https://miro.medium.com/max/552/1*lZ7EhxZ-lHxvbyia5QKbSg.png 276w, https://miro.medium.com/max/1104/1*lZ7EhxZ-lHxvbyia5QKbSg.png 552w, https://miro.medium.com/max/1208/1*lZ7EhxZ-lHxvbyia5QKbSg.png 604w" sizes="604px" role="presentation"/>

IO.inspect binding
------------------

You can also use IO.inspect with the binding() function to view the arguments the function was called with.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*Ec71OHSVMuZblmJq29E58g.png" width="700" height="165" srcSet="https://miro.medium.com/max/552/1*Ec71OHSVMuZblmJq29E58g.png 276w, https://miro.medium.com/max/1104/1*Ec71OHSVMuZblmJq29E58g.png 552w, https://miro.medium.com/max/1280/1*Ec71OHSVMuZblmJq29E58g.png 640w, https://miro.medium.com/max/1400/1*Ec71OHSVMuZblmJq29E58g.png 700w" sizes="700px" role="presentation"/>

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*PQkfjFTTpDu3HwWTFObAXA.png" width="700" height="209" srcSet="https://miro.medium.com/max/552/1*PQkfjFTTpDu3HwWTFObAXA.png 276w, https://miro.medium.com/max/1104/1*PQkfjFTTpDu3HwWTFObAXA.png 552w, https://miro.medium.com/max/1280/1*PQkfjFTTpDu3HwWTFObAXA.png 640w, https://miro.medium.com/max/1400/1*PQkfjFTTpDu3HwWTFObAXA.png 700w" sizes="700px" role="presentation"/>

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1160/1*SZ3tY7daO_x6dRIDLtpE7Q.png" width="580" height="196" srcSet="https://miro.medium.com/max/552/1*SZ3tY7daO_x6dRIDLtpE7Q.png 276w, https://miro.medium.com/max/1104/1*SZ3tY7daO_x6dRIDLtpE7Q.png 552w, https://miro.medium.com/max/1160/1*SZ3tY7daO_x6dRIDLtpE7Q.png 580w" sizes="580px" role="presentation"/>

Debugging using IEX
===================

to run your Elixir project in the Interactive Elixir shell, run:

```elixir
iex -S mix
```

To run your tests in an Elixir or Phoenix project in the Elixir Interactive shell run:

```elixir
iex -S mix test
```

To run your Phoenix app in the Elixir Interactive shell, you can run:

```elixir
iex -S mix phoenix.server
```

IEx.pry()
---------

IEx.pry() allows you to set a breakpoint in your code and inspect values. It’s great when you want to quickly inspect many values at a particular spot in your code without digging through tons of print statements.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/816/1*0leSfUPmEZXnqFQX_TO-Ig.png" width="408" height="144" srcSet="https://miro.medium.com/max/552/1*0leSfUPmEZXnqFQX_TO-Ig.png 276w, https://miro.medium.com/max/816/1*0leSfUPmEZXnqFQX_TO-Ig.png 408w" sizes="408px" role="presentation"/>

Now when elixir evaluates the code where the IEx.pry() function is, you’ll be prompted with a request to pry. If you accept, then you can inspect values in the Interactive Elixir shell.

Ignore that I run `iex.bat` instead of `iex`. That’s a quirk of using Elixir on a Windows computer.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*2sQWggCP-dxqNUzlKOCD_Q.png" width="700" height="275" srcSet="https://miro.medium.com/max/552/1*2sQWggCP-dxqNUzlKOCD_Q.png 276w, https://miro.medium.com/max/1104/1*2sQWggCP-dxqNUzlKOCD_Q.png 552w, https://miro.medium.com/max/1280/1*2sQWggCP-dxqNUzlKOCD_Q.png 640w, https://miro.medium.com/max/1400/1*2sQWggCP-dxqNUzlKOCD_Q.png 700w" sizes="700px" role="presentation"/>

You can accomplish the same thing when running a phoenix application in the Interactive Elixir shell.

Here’s an example from a [phoenix blog app](https://github.com/BrooklinJazz/phoenix_blog) where the user navigates to `[http://localhost:4000/author/1](http://localhost:4000/author/1)` to see a list of posts by an author.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1328/1*xCl5_yNPAauHT0tPTa7QLw.png" width="664" height="173" srcSet="https://miro.medium.com/max/552/1*xCl5_yNPAauHT0tPTa7QLw.png 276w, https://miro.medium.com/max/1104/1*xCl5_yNPAauHT0tPTa7QLw.png 552w, https://miro.medium.com/max/1280/1*xCl5_yNPAauHT0tPTa7QLw.png 640w, https://miro.medium.com/max/1328/1*xCl5_yNPAauHT0tPTa7QLw.png 664w" sizes="664px" role="presentation"/>

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*YmS-5IOpaUablUtS9NhdVA.png" width="700" height="156" srcSet="https://miro.medium.com/max/552/1*YmS-5IOpaUablUtS9NhdVA.png 276w, https://miro.medium.com/max/1104/1*YmS-5IOpaUablUtS9NhdVA.png 552w, https://miro.medium.com/max/1280/1*YmS-5IOpaUablUtS9NhdVA.png 640w, https://miro.medium.com/max/1400/1*YmS-5IOpaUablUtS9NhdVA.png 700w" sizes="700px" role="presentation"/>

Using the Visual Studio Code debugger
=====================================

While using IEx for quickly viewing values at a particular spot in the code base is great. However, using an actual debugger with a visual interface is much more convenient when you want to view multiple locations, step through the code, and monitor data as your application runs.

Set up the debugger
-------------------

Setting up the debugger for phoenix or elixir is done automatically for you by Visual Studio Code.

When you open a phoenix or elixir project in Visual Studio Code, you should have a Run and Debugger option in your menu. If you don’t see it, you can run a `Show Run and Debug` command with `ctrl-shift-D` .

If you want to run the example code for yourself, then you can clone [the example repository](https://github.com/BrooklinJazz/debugging_elixir).

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*dhsuGKjfUUaKTNUcrxUscQ.png" width="700" height="348" srcSet="https://miro.medium.com/max/552/1*dhsuGKjfUUaKTNUcrxUscQ.png 276w, https://miro.medium.com/max/1104/1*dhsuGKjfUUaKTNUcrxUscQ.png 552w, https://miro.medium.com/max/1280/1*dhsuGKjfUUaKTNUcrxUscQ.png 640w, https://miro.medium.com/max/1400/1*dhsuGKjfUUaKTNUcrxUscQ.png 700w" sizes="700px" role="presentation"/>

Make sure you have an elixir .ex file open and click **_create a launch.json file_**. This should create a launch.json file for you.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*PCSyZZHOMPse1OmdOdNhZw.png" width="700" height="282" srcSet="https://miro.medium.com/max/552/1*PCSyZZHOMPse1OmdOdNhZw.png 276w, https://miro.medium.com/max/1104/1*PCSyZZHOMPse1OmdOdNhZw.png 552w, https://miro.medium.com/max/1280/1*PCSyZZHOMPse1OmdOdNhZw.png 640w, https://miro.medium.com/max/1400/1*PCSyZZHOMPse1OmdOdNhZw.png 700w" sizes="700px" role="presentation"/>

Running elixir project with the debugger.
-----------------------------------------

You can run your tests with the debugger using the mix test configuration.

However, you might want to run your project using the `iex -S mix` command to use the Interactive Elixir shell with the debugger.

At the time of writing, I experienced a bug when running the default mix task for the elixir project.

I would get an error:`:elixir_ls_expression_timeout`

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*sNiXig6ncpZ4Wnrse6cKDg.png" width="700" height="480" srcSet="https://miro.medium.com/max/552/1*sNiXig6ncpZ4Wnrse6cKDg.png 276w, https://miro.medium.com/max/1104/1*sNiXig6ncpZ4Wnrse6cKDg.png 552w, https://miro.medium.com/max/1280/1*sNiXig6ncpZ4Wnrse6cKDg.png 640w, https://miro.medium.com/max/1400/1*sNiXig6ncpZ4Wnrse6cKDg.png 700w" sizes="700px" role="presentation"/>

Thank you to [Ralphe Maute](https://www.linkedin.com/in/ralphmaute/) who figured out the solution. The problem was there was no entry point into the application.

If you experience the same issue, make sure you have an application.ex file in /lib.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1176/1*UiWqF_kCB0nmfq5sck0XQQ.png" width="588" height="273" srcSet="https://miro.medium.com/max/552/1*UiWqF_kCB0nmfq5sck0XQQ.png 276w, https://miro.medium.com/max/1104/1*UiWqF_kCB0nmfq5sck0XQQ.png 552w, https://miro.medium.com/max/1176/1*UiWqF_kCB0nmfq5sck0XQQ.png 588w" sizes="588px" role="presentation"/>

Then reference the file in mix.exs.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1276/1*raFFETeglJk6UWwd4myceQ.png" width="638" height="221" srcSet="https://miro.medium.com/max/552/1*raFFETeglJk6UWwd4myceQ.png 276w, https://miro.medium.com/max/1104/1*raFFETeglJk6UWwd4myceQ.png 552w, https://miro.medium.com/max/1276/1*raFFETeglJk6UWwd4myceQ.png 638w" sizes="638px" role="presentation"/>

The [Example Repository](https://github.com/BrooklinJazz/debugging_elixir) has been updated so that if you set a breakpoint and run the default mix task, it should work:

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*hfgDztnzX0XjrnI9bPekXg.png" width="700" height="208" srcSet="https://miro.medium.com/max/552/1*hfgDztnzX0XjrnI9bPekXg.png 276w, https://miro.medium.com/max/1104/1*hfgDztnzX0XjrnI9bPekXg.png 552w, https://miro.medium.com/max/1280/1*hfgDztnzX0XjrnI9bPekXg.png 640w, https://miro.medium.com/max/1400/1*hfgDztnzX0XjrnI9bPekXg.png 700w" sizes="700px" role="presentation"/>

Running a phoenix project with the debugger.
--------------------------------------------

If you are using phoenix, add “task”: “phx.server” to the config.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*GnMWyTpFt55qTtOiX8YEpg.png" width="700" height="619" srcSet="https://miro.medium.com/max/552/1*GnMWyTpFt55qTtOiX8YEpg.png 276w, https://miro.medium.com/max/1104/1*GnMWyTpFt55qTtOiX8YEpg.png 552w, https://miro.medium.com/max/1280/1*GnMWyTpFt55qTtOiX8YEpg.png 640w, https://miro.medium.com/max/1400/1*GnMWyTpFt55qTtOiX8YEpg.png 700w" sizes="700px" role="presentation"/>

Set a breakpoint
----------------

Now you can set breakpoints in your code by clicking the red dot to the left of any line. I’ve set up some example code and a test below to show the start of a breakpoint.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*-CBhuz4xu3Zcl2br_zqHeA.png" width="700" height="305" srcSet="https://miro.medium.com/max/552/1*-CBhuz4xu3Zcl2br_zqHeA.png 276w, https://miro.medium.com/max/1104/1*-CBhuz4xu3Zcl2br_zqHeA.png 552w, https://miro.medium.com/max/1280/1*-CBhuz4xu3Zcl2br_zqHeA.png 640w, https://miro.medium.com/max/1400/1*-CBhuz4xu3Zcl2br_zqHeA.png 700w" sizes="700px" role="presentation"/>

Here’s the test that will execute the code above.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*LC6hFytaiJkp1LqqcWGSpA.png" width="700" height="212" srcSet="https://miro.medium.com/max/552/1*LC6hFytaiJkp1LqqcWGSpA.png 276w, https://miro.medium.com/max/1104/1*LC6hFytaiJkp1LqqcWGSpA.png 552w, https://miro.medium.com/max/1280/1*LC6hFytaiJkp1LqqcWGSpA.png 640w, https://miro.medium.com/max/1400/1*LC6hFytaiJkp1LqqcWGSpA.png 700w" sizes="700px" role="presentation"/>

Then select the mix test configuration and run it using the green play button.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*dhIaF3twTXnu_f5M31ab3A.png" width="700" height="360" srcSet="https://miro.medium.com/max/552/1*dhIaF3twTXnu_f5M31ab3A.png 276w, https://miro.medium.com/max/1104/1*dhIaF3twTXnu_f5M31ab3A.png 552w, https://miro.medium.com/max/1280/1*dhIaF3twTXnu_f5M31ab3A.png 640w, https://miro.medium.com/max/1400/1*dhIaF3twTXnu_f5M31ab3A.png 700w" sizes="700px" role="presentation"/>

Step Over
---------

You can step through your code by pressing the blue step-over button. Notice that the step0 variable is listed now because it’s been defined, but variables defined below the yellow line are not listed because they don’t exist yet.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*BNZf6o3p5JGA9BGhFlLEGw.png" width="700" height="284" srcSet="https://miro.medium.com/max/552/1*BNZf6o3p5JGA9BGhFlLEGw.png 276w, https://miro.medium.com/max/1104/1*BNZf6o3p5JGA9BGhFlLEGw.png 552w, https://miro.medium.com/max/1280/1*BNZf6o3p5JGA9BGhFlLEGw.png 640w, https://miro.medium.com/max/1400/1*BNZf6o3p5JGA9BGhFlLEGw.png 700w" sizes="700px" role="presentation"/>

Step Into
---------

You can step into a function using the blue step-into button. This allows you to see the inside of a function rather than jumping to the next line.

First, step over until you are on the line with the function you want to step into.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*NLWUG_RN35zZLQ3YdiKq_g.png" width="700" height="303" srcSet="https://miro.medium.com/max/552/1*NLWUG_RN35zZLQ3YdiKq_g.png 276w, https://miro.medium.com/max/1104/1*NLWUG_RN35zZLQ3YdiKq_g.png 552w, https://miro.medium.com/max/1280/1*NLWUG_RN35zZLQ3YdiKq_g.png 640w, https://miro.medium.com/max/1400/1*NLWUG_RN35zZLQ3YdiKq_g.png 700w" sizes="700px" role="presentation"/>

Then press the blue step-into button. Notice that the variables and arguments change because we’re inside of a different function now.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*rYACjtBbHQutgCntLlSR_w.png" width="700" height="306" srcSet="https://miro.medium.com/max/552/1*rYACjtBbHQutgCntLlSR_w.png 276w, https://miro.medium.com/max/1104/1*rYACjtBbHQutgCntLlSR_w.png 552w, https://miro.medium.com/max/1280/1*rYACjtBbHQutgCntLlSR_w.png 640w, https://miro.medium.com/max/1400/1*rYACjtBbHQutgCntLlSR_w.png 700w" sizes="700px" role="presentation"/>

Continue
--------

To conveniently navigate your code without stepping over and into every function, set another breakpoint and hit the blue continue button.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*BVvqxf4fffHuV0d6Ogz0BQ.png" width="700" height="267" srcSet="https://miro.medium.com/max/552/1*BVvqxf4fffHuV0d6Ogz0BQ.png 276w, https://miro.medium.com/max/1104/1*BVvqxf4fffHuV0d6Ogz0BQ.png 552w, https://miro.medium.com/max/1280/1*BVvqxf4fffHuV0d6Ogz0BQ.png 640w, https://miro.medium.com/max/1400/1*BVvqxf4fffHuV0d6Ogz0BQ.png 700w" sizes="700px" role="presentation"/>

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*zwIyU7xFhFr34lFzr4MMCg.png" width="700" height="290" srcSet="https://miro.medium.com/max/552/1*zwIyU7xFhFr34lFzr4MMCg.png 276w, https://miro.medium.com/max/1104/1*zwIyU7xFhFr34lFzr4MMCg.png 552w, https://miro.medium.com/max/1280/1*zwIyU7xFhFr34lFzr4MMCg.png 640w, https://miro.medium.com/max/1400/1*zwIyU7xFhFr34lFzr4MMCg.png 700w" sizes="700px" role="presentation"/>

Watch variables
---------------

You can also set variables to watch so you can track the progress of a value.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*XgqnxCdwLzT5GjxQhbGMfg.png" width="700" height="397" srcSet="https://miro.medium.com/max/552/1*XgqnxCdwLzT5GjxQhbGMfg.png 276w, https://miro.medium.com/max/1104/1*XgqnxCdwLzT5GjxQhbGMfg.png 552w, https://miro.medium.com/max/1280/1*XgqnxCdwLzT5GjxQhbGMfg.png 640w, https://miro.medium.com/max/1400/1*XgqnxCdwLzT5GjxQhbGMfg.png 700w" sizes="700px" role="presentation"/>

Conditional Breakpoints
-----------------------

You can set a breakpoint to trigger only if a condition is true. Right-click where you would normally add a breakpoint and select the conditional breakpoint option.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*ut9oyjhrJKgWreFCEwU1AQ.png" width="700" height="394" srcSet="https://miro.medium.com/max/552/1*ut9oyjhrJKgWreFCEwU1AQ.png 276w, https://miro.medium.com/max/1104/1*ut9oyjhrJKgWreFCEwU1AQ.png 552w, https://miro.medium.com/max/1280/1*ut9oyjhrJKgWreFCEwU1AQ.png 640w, https://miro.medium.com/max/1400/1*ut9oyjhrJKgWreFCEwU1AQ.png 700w" sizes="700px" role="presentation"/>

This set the condition for the breakpoint to trigger. For example, this breakpoint will only trigger if a equals 1.

<img alt="" class="t u v kt aj" src="https://miro.medium.com/max/1400/1*VjN9gK2alBWruSzxog5W6Q.png" width="700" height="420" srcSet="https://miro.medium.com/max/552/1*VjN9gK2alBWruSzxog5W6Q.png 276w, https://miro.medium.com/max/1104/1*VjN9gK2alBWruSzxog5W6Q.png 552w, https://miro.medium.com/max/1280/1*VjN9gK2alBWruSzxog5W6Q.png 640w, https://miro.medium.com/max/1400/1*VjN9gK2alBWruSzxog5W6Q.png 700w" sizes="700px" role="presentation"/>

Conclusion
==========

Knowing how to debug your code means you spend more time delivering valuable new features and less time fixing the bugs you create along the way. I hope this article helps save you some headaches the next time you have a tricky bug to fix. If you have a comment or question, please reply to this article, and I would be happy to get back to you.