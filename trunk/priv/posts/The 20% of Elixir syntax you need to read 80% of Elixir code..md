---
title: The 20% of Elixir syntax you need to read 80% of Elixir code.
subtitle: A quick cheat sheet of the most common elixir syntax.
description: This is a brief guide using the Pareto Principle (80/20 rule) to the most common Elixir syntax you’re going to encounter. If you want a crash course or a quick refresher on common Elixir concepts, then this article is for you.
tags: elixir,phoenix,testing
published_at: 2021-10-31
published: true
cover_image: ""
---

## Elixir
>  Elixir is a dynamic, functional language for building scalable and maintainable applications.
>  Elixir leverages the Erlang VM, known for running low-latency, distributed, and fault-tolerant systems. Elixir is successfully used in web development, embedded software, data ingestion, and multimedia processing, across a wide range of industries.
>  [- https://elixir-lang.org/](https://elixir-lang.org/)

## Getting started with Elixir

Skip this section and move on to data types if you already know how to run elixir code.

You can choose to run elixir using a Repl (an online code editor) by executing .ex files on your computer or in the Interactive Elixir (iex) environment.

### Using a Repl

If you’d like to get started with Elixir quickly, you can use a website to run elixir code in a web-based code editor.

* Open the [Elixir Repl](https://replit.com/languages/elixir)

* Make sure it works by typing the following in the editor and press Run.

```elixir
IO.puts “Hello World”
```

It should look like this:

![](https://cdn-images-1.medium.com/max/3840/1*sG1nT2Pr8oauym_DaexqVw.png)

### Running Elixir on your computer

You can also install Elixir onto your computer and then run elixir files (.ex) directly.

* [Install Elixir](https://elixir-lang.org/install.html) if you don’t have it already

* Make a new file called test.ex

* Write the following in the file:

```elixir
IO.puts “Hello World”
```

* In your Terminal In the folder with your file, run

    elixir test.ex

You may be using a different editor, but it should look something like this:

![](https://cdn-images-1.medium.com/max/3840/1*RCbhALGOsvR6nKDl8KnjHw.png)

### Using the Interactive Elixir (iex) environment.

You can open the Interactive Elixir environment to experiment with Elixir code. You must already have [Installed Elixir](https://elixir-lang.org/install.html) on your machine.

On Mac & Linux run:

```elixir
# On Mac and Linux run:
iex
# On Windows run:
iex.bat
```

## Data Types

In Elixir will commonly encounter the following data types:
{% gist https://gist.github.com/BrooklinJazz/86b7ca1cd58db2012ca0f1c3a4aabd39.js %}
## Variables

Variables allow you to store data to be referenced throughout your application. In Elixir, you can define a variable as such:

```elixir
my_integer = 4
my_float = 4.0
my_string = "Hello"
```

Variables in Elixir use snake_case. A variable can store any data type; it is not restricted to the examples above.

## Comments

Comments in elixir use #. There is no multi-line comment for Elixir.
```elixir
# comments can be on their own line
5 + 5 # or after your code on the same line.
# but not before, because everything after the # is a comment 5 + 5
```
## String

Strings in elixir are series of Unicode Characters written between double quotes “”.

### Writing double-quotes inside of a string

you can put double-quotes inside of a string using backslash \
```elixir
"a string with \"double quotes\""
```
### String concatenation (adding strings)
```elixir
"Brooklin" <> " " <> "Myers" # "Brooklin Myers"
```
### String interpolation

Elixir code can execute inside of a string using #{}.
```elixir
name = "Brooklin"
"Hi #{name}" # Hi Brooklin
"What is 5 + 4? #{5 + 4}." # What is 5 + 4? 9.
```
### [The String module](https://hexdocs.pm/elixir/1.12/String.html#content)

You can access string-related functionality with the built-in [String](https://hexdocs.pm/elixir/1.12/String.html#content) module.
{% gist https://gist.github.com/BrooklinJazz/aa987e42cf3fdf912d83363cd55c349b.js %}
## Integer and Float

Elixir provides a variety of mechanisms to operate on integers and floats.

### Arithmetic operators

Arithmetic operators allow you to manipulate numbers.
```elixir
# plus (+)
5 + 5 # 10
# minus (-)
5 - 5 # 0
# multiply (*)
5 * 5 # 25
# divide (/)
5 / 5 # 1
```
### Integer Functions

Elixir provides functions rem and div for working with integer division and remainder.
```elixir
rem(5, 4) # 1
rem(10, 6) # 4
div(3, 2) # 1 (normally 1.5 with divide /)
div(1, 2) # 0 (normally 0.5 with divide /)
div(8, 3) # 2 (normally 2.6666 with divide /)
```
## Booleans

Booleans are true/false values.

### and, or, not

Used to compare booleans only:
```elixir
true and true # true
true and false # false
true or false # true
false or false # false
false or not false # true
true and not true # false
```
## Comparison Operators

Comparison operators are used to compare values. They are commonly used to compare integers and floats but can also be used to compare other data types for sorting purposes.

### exactly equals ===
```elixir
5 === 5   # true
5 === 5.0 # false
4 === 5   # false
4 === "4" # false
```
### equals ==
```elixir
5 == 5   # true
5 == 5.0 # true
4 == "4" # false, equals still checks type unlike some languages.
```
### not exactly equals !==
```elixir
5 !== 5   # false
5 !== 5.0 # true
4 !== 5   # true
```
### not equals !=
```elixir
5 != 5   # false
5 != 5.0 # false
5 != 4   # true
```
### greater than >
```elixir
4 > 5 # false
5 > 5 # false
6 > 5 # true
```
### less than <
```elixir
4 < 5 # true
5 < 5 # false
6 < 5 # false
```
### greater than or equal (>=)
```elixir
4 >= 5 # false
5 >= 5 # true
6 >= 5 # true
```
### less than or equal ≤
```elixir
4 <= 5 # true
5 <= 5 # true
6 <= 5 # false
```
### Value Comparison: or (||), and (&&), not (!)

You can use this to compare any data types. Anything other than false and nil will evaluate as true. This means even 0 will be evaluated as true. It’s important to remember the returned value is not a boolean. The returned value is the actual value evaluated.
```elixir
1 && 1           # 1
1 && false       # false
1 || false       # 1
nil || false     # false
false || !nil    # true
1 && "hey"       # "hey"
"hey" && 1       # 1
"hey" || "hello" # "hey"
```
## Atom

Atoms are constants whose value is their own name. They are often used to represent distinct values important to your application. They are often used for handling the state of an operation such as :ok and :error.
```elixir
    :ok
```
true, false, and nil are all atoms which Elixir allows you to skip the leading colon (:).
```elixir
:true === true   # true
:false === false # true
:nil === nil     # true
```
## List

Lists in Elixir are implemented as linked lists. Linked lists hold zero, one, or more elements in the chosen order.

### Add and Subtract lists with ++ and --
{% gist https://gist.github.com/BrooklinJazz/8fae045d8a8131eeaa35c40007f44138.js %}
### [The List Module](https://hexdocs.pm/elixir/1.12/List.html#content)

You can access list-related functionality with the built-in [List](https://hexdocs.pm/elixir/1.12/List.html#content) module.
{% gist https://gist.github.com/BrooklinJazz/15af60aaab5e3f03495be1958bd057df.js %}
Elixir lists are linked lists, so you can access the head (first element of the list) and the tail (the rest of the list)
{% gist https://gist.github.com/BrooklinJazz/9b4ac057ac051a39e778373f67d40bbb.js %}
## Tuple

Use tuples when you want to store a fixed number of elements. Do not use Tuples when you want to iterate through elements as it does not support Enum operations.

A common use of Tuples would be to store known values in an expected order. For example, you might have a tuple for a user with {name, age, city}
```elixir
{"Brooklin", 23, "Montreal"}
```
### [The Tuple module](https://hexdocs.pm/elixir/1.12/Tuple.html#content)

You can access tuple-related functionality with the built-in [Tuple](https://hexdocs.pm/elixir/1.12/Tuple.html#content) module.
{% gist https://gist.github.com/BrooklinJazz/9c2d1442c1ad4e22da7d648b0b5476d0.js %}
## Map

Maps are a key-value data structure in Elixir. The keys in a map must be unique, unlike with key-value lists.

### Dot notation

You can access map values using dot notation.
```elixir
my_map = %{"key" => "value"}
my_map.key # value
```
Dot notation can throw non_existing_key errors

```console
map.non_existing_key **** (KeyError) key :non_existing_key not found in: %{"key" => "value"}**
```

### [The Map module](https://hexdocs.pm/elixir/1.12/Map.html#content)

You can access map-related functionality with the built-in [Map](https://hexdocs.pm/elixir/1.12/Map.html#content) module.

For example, you can avoid the non_existing_key error above by using Map.get:
{% gist https://gist.github.com/BrooklinJazz/ab8135bf5eb8bbf14cc3af44380d1315.js %}
### Map update syntax

You can use a special syntax to update map keys. You can only update existing keys.
{% gist https://gist.github.com/BrooklinJazz/7900a49e08ce0e2ce74a002397227c63.js %}
## [The Enum module](https://hexdocs.pm/elixir/1.12/Enum.html#content)

When iterating over data, usually a list, you can use the [Enum module](https://hexdocs.pm/elixir/1.12/Enum.html#content) provided by Elixir. lists, ranges, and maps all work with the [Enum module](https://hexdocs.pm/elixir/1.12/Enum.html#content).
{% gist https://gist.github.com/BrooklinJazz/a2afba2f310d0ac1ee6eef32667d5ce7.js %}
## Conditional statements

Conditional statements are used for branching logic in your application.

### if/else
{% gist https://gist.github.com/BrooklinJazz/58a08bdb8ac9b2a405920b0d868c7656.js %}
### unless/else
{% gist https://gist.github.com/BrooklinJazz/2677ef308e7f689e63586d099710af25.js %}
### Ternary

Ternary is a handy shorthand for if/else statements.
{% gist https://gist.github.com/BrooklinJazz/71aae4802cf80241e2db12f76057072e.js %}
### case

case takes in a value and executes a different path in the case statement depending on the value. It may be helpful to relate case to switch-case statements found in other languages.
{% gist https://gist.github.com/BrooklinJazz/c659a563863097b62517dc6e999d58d2.js %}
### Variables in a case statement

You can use variables to represent values in the case argument. See n in this example:
{% gist https://gist.github.com/BrooklinJazz/5e6b2dba0ec9e10b215088672cb07823.js %}
### cond

cond executes the code for the first true condition. It is a lot like case, except instead of evaluating a single value and executing the path that matches the value, you can define various conditions, making this conditional statement much more versatile at the possible expense of clarity.
{% gist https://gist.github.com/BrooklinJazz/ebc4f4ab7aed6376398247393e89921c.js %}
## Modules and functions

Modules provide a way to organize the behavior of your program. For example, you might have a Greeting module with a say_hello function to return “Hello”.

### How to create a module and function
{% gist https://gist.github.com/BrooklinJazz/987a6ffeb4b1249d3e907b677e8709c6.js %}
You’ll notice that modules are CapitalCase and functions are snake_case.

### Calling a function
```elixir
Greeting.say_hello() # Hello
```
### Calling a function from inside the same module

You do not have to reference the Module when calling a function from inside the same module. So Greeting.say_hello becomes say_hello.
{% gist https://gist.github.com/BrooklinJazz/e79a7d8eed7d20ff52aa5e85a0cc7fc4.js %}
### Functions with different parameters

One really cool feature of Elixir is to treat two functions with the same name but different parameters as two different functions. For example, the Greeting.say_hello function can be referred to as say_hello/0. 0 because it didn’t take any parameters.
{% gist https://gist.github.com/BrooklinJazz/bbd545ffebcfeb4aff64d9f441ddccc6.js %}
### A function that returns a boolean should end with a question mark (?)
{% gist https://gist.github.com/BrooklinJazz/4f11a59a53001a6b80f322b93ccec029.js %}
### Default Arguments

Elixir supports default arguments using \\
{% gist https://gist.github.com/BrooklinJazz/fbec694efad33667461ba9942f9b3adb.js %}
### Brackets are optional

Use brackets when you think it adds to the clarity of the code, or don’t!
{% gist https://gist.github.com/BrooklinJazz/a5989a22d94a86d8b8bfd81ad4637114.js %}
### Handling functions with context using when

You can use when syntax to say what should happen under a specific condition.
{% gist https://gist.github.com/BrooklinJazz/e4f71bc5f3cafd1a3b76778b5956ccbe.js %}
The order of your functions matters, as the first function to be true always runs first. Here’s an example of when used with the wrong function order.
{% gist https://gist.github.com/BrooklinJazz/327976604524c7c89e414b8ce75c8607.js %}
## Reusing Modules

Elixir provides directives for reusing modules in your project.

It’s important to note that Elixir is a compiled language. It is usually compiled using a tool called [mix](https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html). So unlike a language like Javascript or Ruby, you do not import one file into another. Instead, modules are compiled together and can be accessed from any .ex files in the project.

### Alias

alias allows you to import a module into another module and access it using a different name. This is commonly used to access nested modules more conveniently.
{% gist https://gist.github.com/BrooklinJazz/de354888d62b4f8a6856e2aa2b6926fe.js %}
### import

import is used to conveniently access functions from other modules.

For example, here is how you would access the puts/1 function from the IO module.
{% gist https://gist.github.com/BrooklinJazz/75ba3e9828e9b099744adeb744c9cbfc.js %}
### use

use allows you to inject functionality from one module into another.

Initially, you will most often use…use… 😅 with modules from third parties. For example, to write tests with the ExUnit framework, you will use the ExUnit.Case module
{% gist https://gist.github.com/BrooklinJazz/7a4e7da6e5da14e8b6b40e38e6d80b4a.js %}
use is a reasonably complicated topic, and it’s good enough if you understand it at a surface level early on. For further reading, see an [elixirschool tutorial on use](https://elixirschool.com/en/lessons/basics/modules/#use) or [read the documentation](https://elixir-lang.org/getting-started/alias-require-and-import.html#use).

## Pipe

Elixir allows you to pass the return value of a function into another using pipe syntax (|>)
{% gist https://gist.github.com/BrooklinJazz/41b0112dac42e1af4c1f9d8880c0f069.js %}
## Pattern Matching

In Elixir, the = symbol is called the match operator. It is useful for assigning simple values, or it can also destructure more complex data types.
```elixir
{name, age, city} = {"Brooklin", 23, "Montreal"} # using a tuple
[a, b, c] = [1, 2, 3] # using a list
[head | tail] = [1, 2, 3] # you saw this before with lists
```
### MatchError

If your destructuring doesn’t match the right-hand side value, you will get a MatchError
```elixir
{a, b, c} **=** {:hello, "world"}
    ****** (MatchError) no match of right hand side value: {:hello, "world"}
```
## Conclusion

Hopefully, this article helps you rapidly get familiar with some of the most important bits of Elixir.

I left out a lot to keep the article concise. To learn more, the [Elixir Documentation](https://elixir-lang.org/getting-started/introduction.html) is a great place to start.

Please comment if you notice any inaccuracies or if you think there’s some other Elixir syntax I should h