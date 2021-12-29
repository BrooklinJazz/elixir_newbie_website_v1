%{
  title: "The 20% of Elixir syntax you need to read 80% of Elixir code.",
  tags: ~w(elixir),
  description: "A quick cheat sheet of the most common elixir syntax",
  cover_image: "06-08-the_elixir_syntax_you_need.jpeg"
}
---

This is a brief guide using the Pareto Principle (80/20 rule) to the most common Elixir syntax you’re going to encounter. If you want a crash course or a quick refresher on common Elixir concepts, then this article is for you.

Elixir
======

> Elixir is a dynamic, functional language for building scalable and maintainable applications.
> 
> Elixir leverages the Erlang VM, known for running low-latency, distributed, and fault-tolerant systems. Elixir is successfully used in web development, embedded software, data ingestion, and multimedia processing, across a wide range of industries.
> 
> [\- https://elixir-lang.org/](https://elixir-lang.org/)

Getting started with Elixir
===========================

Skip this section and move on to data types if you already know how to run elixir code.

You can choose to run elixir using a Repl (an online code editor) by executing .ex files on your computer or in the Interactive Elixir (iex) environment.

## Using a Repl

If you’d like to get started with Elixir quickly, you can use a website to run elixir code in a web-based code editor.

*   Open the [Elixir Repl](https://replit.com/languages/elixir)
*   Make sure it works by typing the following in the editor and press Run.

```elixir
IO.puts “Hello World”
```

It should look like this:

![](https://miro.medium.com/max/875/1*sG1nT2Pr8oauym_DaexqVw.png)

Running Elixir on your computer
-------------------------------

You can also install Elixir onto your computer and then run elixir files (.ex) directly.

*   [Install Elixir](https://elixir-lang.org/install.html) if you don’t have it already
*   Make a new file called test.ex
*   Write the following in the file:

```elixir
IO.puts “Hello World”
```

*   In your Terminal In the folder with your file, run

```elixir
elixir test.ex
```

You may be using a different editor, but it should look something like this:

![](https://miro.medium.com/max/875/1*RCbhALGOsvR6nKDl8KnjHw.png)

Using the Interactive Elixir (iex) environment.
-----------------------------------------------

You can open the Interactive Elixir environment to experiment with Elixir code. You must already have [Installed Elixir](https://elixir-lang.org/install.html) on your machine.

On Mac & Linux run:

```elixir
# On Mac and Linux run:  
iex  
# On Windows run:  
iex.bat
```

Data Types
==========

In Elixir will commonly encounter the following data types:

```elixir
1                        # integer
0b1010                   # 10 integer in binary
0o777                    # 511 integer in octal
0x1F                     # 31 integer in hexadecimal
1.2                      # float
:example                 # atom
"hello"                  # string
true                     # boolean
false                    # boolean
[1, 2, 3]                # list
1..3                     # list written as a range
[key: "val", key: "val"] # key-value list (non-unique keys allowed)
{1, 2, 3}                # tuple
%{"key" => "val"}        # map (unique keys only)
%{key: "val"}            # map with atom key syntax
```

Variables
=========

Variables allow you to store data to be referenced throughout your application. In Elixir, you can define a variable as such:

```elixir
my_integer = 4  
my_float = 4.0  
my_string = "Hello"
```

Variables in Elixir use snake_case. A variable can store any data type; it is not restricted to the examples above.

Comments
========

Comments in elixir use #. There is no multi-line comment for Elixir.

```elixir
# comments can be on their own line  
5 + 5 # or after your code on the same line.  
# but not before, because everything after the # is a comment 5 + 5
```

String
======

Strings in elixir are series of Unicode Characters written between double quotes “”.

Writing double-quotes inside of a string
----------------------------------------

you can put double-quotes inside of a string using backslash \\

```elixir
"a string with \"double quotes\""
```

String concatenation (adding strings)
-------------------------------------

```elixir
"Brooklin" <> " " <> "Myers" # "Brooklin Myers"
```

String interpolation
--------------------

Elixir code can execute inside of a string using #{}.

```elixir
name = "Brooklin"  
"Hi #{name}" # Hi Brooklin  
"What is 5 + 4? #{5 + 4}." # What is 5 + 4? 9.
```

[The String module](https://hexdocs.pm/elixir/1.12/String.html#content)
-----------------------------------------------------------------------

You can access string-related functionality with the built-in [String](https://hexdocs.pm/elixir/1.12/String.html#content) module.

```elixir
String.length "a string" # 8 
String.contains?("string", "str") # true
String.at("mystring", 2) # s
String.slice("mystring", 2, 3)
String.split("my string", " ") # ["my", "string"]
String.reverse("string") # gnirts
String.upcase("string") # STRING 
String.downcase("STRING") # string
String.capitalize("string") # "String"
```

Integer and Float
=================

Elixir provides a variety of mechanisms to operate on integers and floats.

Arithmetic operators
--------------------

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

Integer Functions
-----------------

Elixir provides functions rem and div for working with integer division and remainder.

```elixir
rem(5, 4) # 1  
rem(10, 6) # 4  
div(3, 2) # 1 (normally 1.5 with divide /)  
div(1, 2) # 0 (normally 0.5 with divide /)  
div(8, 3) # 2 (normally 2.6666 with divide /)
```

Booleans
========

Booleans are true/false values.

and, or, not
------------

Used to compare booleans only:

```elixir
true and true # true  
true and false # false  
true or false # true  
false or false # false  
false or not false # true  
true and not true # false
```

Comparison Operators
====================

Comparison operators are used to compare values. They are commonly used to compare integers and floats but can also be used to compare other data types for sorting purposes.

exactly equals ===
------------------

```elixir
5 === 5   # true  
5 === 5.0 # false  
4 === 5   # false  
4 === "4" # false
```

equals ==
---------

```elixir
5 == 5   # true  
5 == 5.0 # true  
4 == "4" # false, equals still checks type unlike some languages.
```

not exactly equals !==
----------------------

```elixir
5 !== 5   # false  
5 !== 5.0 # true  
4 !== 5   # true
```

not equals !=
-------------

```elixir
5 != 5   # false  
5 != 5.0 # false  
5 != 4   # true
```

greater than >
--------------

```elixir
4 > 5 # false  
5 > 5 # false  
6 > 5 # true
```

less than <
-----------

```elixir
4 < 5 # true  
5 < 5 # false  
6 < 5 # false
```

greater than or equal (>=)
--------------------------

```elixir
4 >= 5 # false  
5 >= 5 # true  
6 >= 5 # true
```

less than or equal ≤
--------------------

```elixir
4 <= 5 # true  
5 <= 5 # true  
6 <= 5 # false
```

Value Comparison: or (||), and (&&), not (!)
--------------------------------------------

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

Atom
====

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

List
====

Lists in Elixir are implemented as linked lists. Linked lists hold zero, one, or more elements in the chosen order.

Add and Subtract lists with ++ and --
-------------------------------------

```elixir
[1, 2] ++ [3, 4] # [1, 2, 3, 4]
[1, 2, 3] -- [1, 3] # [2]
[1, 2, 3] -- [1] # [2, 3]
[1, 2, 3] -- [3, 1] # [2]
```

[The List Module](https://hexdocs.pm/elixir/1.12/List.html#content)
-------------------------------------------------------------------

You can access list-related functionality with the built-in [List](https://hexdocs.pm/elixir/1.12/List.html#content) module.

```elixir
List.last([1,2,3]) # 3
List.first([1, 2, 3]) # 1
List.delete([1,2,3], 1) # [2, 3]
List.delete_at([1,2,3], 0) # [2, 3]
```

Elixir lists are linked lists, so you can access the head (first element of the list) and the tail (the rest of the list)

```elixir
[head | tail] = [1,2,3]
head # 1
tail # [2, 3]
```

Tuple
=====

Use tuples when you want to store a fixed number of elements. Do not use Tuples when you want to iterate through elements as it does not support Enum operations.

A common use of Tuples would be to store known values in an expected order. For example, you might have a tuple for a user with {name, age, city}

```elixir
{"Brooklin", 23, "Montreal"}
```

[The Tuple module](https://hexdocs.pm/elixir/1.12/Tuple.html#content)
---------------------------------------------------------------------

You can access tuple-related functionality with the built-in [Tuple](https://hexdocs.pm/elixir/1.12/Tuple.html#content) module.

```elixir
Tuple.append({1}, 2) # {1, 2}
Tuple.duplicate(0, 5) # {0, 0, 0, 0, 0}
Tuple.insert_at({1, 3}, 1, 2) # {1, 2, 3}
```

Map
===

Maps are a key-value data structure in Elixir. The keys in a map must be unique, unlike with key-value lists.

Dot notation
------------

You can access atom map values using dot notation.

```elixir
my_map = %{key: "value"}  
my_map.key # value
```

Dot notation can throw non_existing_key errors

```elixir
map.non_existing_key **** (KeyError) key :non_existing_key not found in: %{"key" => "value"}**
```

[The Map module](https://hexdocs.pm/elixir/1.12/Map.html#content)
-----------------------------------------------------------------

You can access map-related functionality with the built-in [Map](https://hexdocs.pm/elixir/1.12/Map.html#content) module.

For example, you can avoid the non_existing_key error above by using Map.get:

```elixir
# with string syntax
map = %{"key" => "value"}
Map.get(map, "key") # value

# with atom syntax
map = %{key: "value"}
Map.get(map, :key) # value
```

Map update syntax
-----------------

You can use a special syntax to update map keys. You can only update existing keys.

```elixir
map = %{"key" => "value"}
%{map | "key" => "value2"} # %{"key" => "value2"}
%{map | "key2" => "value2"}
# ** (KeyError) key "key2" not found
    main.exs:3: (file)
```

[The Enum module](https://hexdocs.pm/elixir/1.12/Enum.html#content)
===================================================================

When iterating over data, usually a list, you can use the [Enum module](https://hexdocs.pm/elixir/1.12/Enum.html#content) provided by Elixir. lists, ranges, and maps all work with the [Enum module](https://hexdocs.pm/elixir/1.12/Enum.html#content).

```elixir
Enum.map([1, 2, 3], fn x -> x * 2 end) # [2, 4, 6]
Enum.sum([1, 2, 3]) # 6
Enum.map(1..3, fn x -> x * 2 end) # [2, 4, 6]
Enum.sum(1..3) # 6

map = %{"a" => 1, "b" => 2}
Enum.map(map, fn {k, v} -> {k, v * 2} end) # [{"a", 2}, {"b", 4}]
```

Conditional statements
======================

Conditional statements are used for branching logic in your application.

if/else
-------

```elixir
if true do
 # code to run when true 
else
 # code to run when false
end
```

unless/else
-----------

```elixir
unless false do
 # code to run when false
else
 # code to run when true
end
```

Ternary
-------

Ternary is a handy shorthand for if/else statements.

```elixir
if(true, do: "code to run when true", else: "code to run when false")
# brackets are optional
if true, do: "code to run when true", else: "code to run when false"
```

case
----

case takes in a value and executes a different path in the case statement depending on the value. It may be helpful to relate case to switch-case statements found in other languages.

```elixir
case 1 do
    1 -> "the 1 path is executed"
    2 -> "the 2 path is skipped"
    _ -> "the default path is skipped"
end

case 2 do
    1 -> "the 1 path is skipped"
    2 -> "the 2 path is executed"
    _ -> "the default path is skipped"
end

case 3 do
    1 -> "the 1 path is skipped"
    2 -> "the 2 path is skipped"
    _ -> "the default path is executed"
end
```

Variables in a case statement
-----------------------------

You can use variables to represent values in the case argument. See n in this example:

```elixir
case {:ok, 5} do
  {:ok, n} -> "this will match and n is 5: #{n}"
  {:error, n} -> "this will not match"
end
```

cond
----

cond executes the code for the first true condition. It is a lot like case, except instead of evaluating a single value and executing the path that matches the value, you can define various conditions, making this conditional statement much more versatile at the possible expense of clarity.

```elixir
cond do
   5 < 3 -> "this will be skipped"
    4 == 4 and 5 > 3 -> "this code will execute"
end
```

Modules and functions
=====================

Modules provide a way to organize the behavior of your program. For example, you might have a Greeting module with a say_hello function to return “Hello”.

How to create a module and function
-----------------------------------

```elixir
defmodule Greeting do
  def say_hello do
    "Hello"
  end
end
```

You’ll notice that modules are CapitalCase and functions are snake_case.

Calling a function
------------------

```elixir
Greeting.say_hello() # Hello
```

Calling a function from inside the same module
----------------------------------------------

You do not have to reference the Module when calling a function from inside the same module. So Greeting.say_hello becomes say_hello.

```elixir
defmodule Greeting do
  def main do
    say_hello()
  end
  def say_hello do
    "Hello"
  end
end

Greeting.main() # Hello
```

Functions with different parameters
-----------------------------------

One really cool feature of Elixir is to treat two functions with the same name but different parameters as two different functions. For example, the Greeting.say_hello function can be referred to as say_hello/0. 0 because it didn’t take any parameters.

```elixir
defmodule Greeting do
  def say_hello do
    "Hello"
  end
  def say_hello(name) do
    "Hello #{name}"
  end
  def say_hello(name1, name2) do
    "Hello #{name1}, Hi #{name2}"
  end

end

IO.puts Greeting.say_hello() # Hello
IO.puts Greeting.say_hello("Bob") # Hello Bob
IO.puts Greeting.say_hello("Bob", "Bill") # Hello Bob, Hi Bill
IO.puts Greeting.say_hello("Bob", "Bill", "Billy") 
# (UndefinedFunctionError) function Greeting.say_hello/3 is undefined or private. Did you mean one of:
      * say_hello/0
      * say_hello/1
      * say_hello/2
```

A function that returns a boolean should end with a question mark (?)
---------------------------------------------------------------------

```elixir
defmodule M do
  def above_20?(val) do
     val > 20
  end
end
M.above_20?(21) # true
```

Default Arguments
-----------------

```elixir
defmodule Greeting do
  def say_hello(name \\ "Brooklin") do
    "Hello #{name}"
  end
end

Greeting.say_hello() # Hello Brooklin
``` 

Elixir supports default arguments using \\\\

Brackets are optional
---------------------

Use brackets when you think it adds to the clarity of the code, or don’t!

```elixir
defmodule Greeting do
  def say_hello name, name2 do
    "Hello #{name}, Hi #{name2}"
  end
end


Greeting.say_hello "Bob", "Bill" # Hello Bob, Hi Bill
``` 

Handling functions with context using when
------------------------------------------

You can use when syntax to say what should happen under a specific condition.

```elixir
defmodule Greeting do
  def say_hello(name) when name === "Brooklin" do
    "Oh it's just you again"
  end
  def say_hello(name) do
    "Hello #{name}"
  end
end

Greeting.say_hello("Brooklin") # Oh it's just you again
```

The order of your functions matters, as the first function to be true always runs first. Here’s an example of when used with the wrong function order.

```elixir
defmodule Greeting do
  def say_hello(name) do
    "Hello #{name}"
  end  
  def say_hello(name) when name === "Brooklin" do
    "Oh it's just you again"
  end
end

Greeting.say_hello("Brooklin") # Hello Brooklin
```

Reusing Modules
===============

Elixir provides directives for reusing modules in your project.

It’s important to note that Elixir is a compiled language. It is usually compiled using a tool called [mix](https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html). So unlike a language like Javascript or Ruby, you do not import one file into another. Instead, modules are compiled together and can be accessed from any .ex files in the project.

Alias
-----

alias allows you to import a module into another module and access it using a different name. This is commonly used to access nested modules more conveniently.

```elixir
defmodule Me do
  defmodule Info do
    def name do
      "Brooklin"
    end
  end
end

defmodule Greeting do
  alias Me.Info, as: Info
  # You can more conveniently write the above as:
  # alias Me.Info
  def say_hello do
   "Hello " <> Info.name()
  end
end

Greeting.say_hello() # Hello Brooklin
```

import
------

import is used to conveniently access functions from other modules.

For example, here is how you would access the puts/1 function from the IO module.

```elixir
defmodule Greeting do
  # syntax: import ModuleName only: [method_name: number_of_parameters]
  import IO, only: [puts: 1]
  def print_greeting(name) do
   puts "Hello " <> name
  end
end

Greeting.print_greeting("Brooklin") # Hello Brooklin
```

use
---

use allows you to inject functionality from one module into another.

Initially, you will most often use…use… 😅 with modules from third parties. For example, to write tests with the ExUnit framework, you will use the ExUnit.Case module

```elixir
defmodule AssertionTest do
  use ExUnit.Case, async: true

  test "always pass" do
    assert true
  end
end
```

use is a reasonably complicated topic, and it’s good enough if you understand it at a surface level early on. For further reading, see an [elixirschool tutorial on use](https://elixirschool.com/en/lessons/basics/modules/#use) or [read the documentation](https://elixir-lang.org/getting-started/alias-require-and-import.html#use).

Pipe
====

Elixir allows you to pass the return value of a function into another using pipe syntax (|>)

```elixir
# the first argument for string.split is the return value of String.upcase("Hello Brooklin")
# for functions with more than 1 parameter such as String.split, 
# skip the first argument because it's provided implicitly by the Pipe |>
"Hello Brooklin" |> String.upcase |> String.split(" ") 
```

Pattern Matching
================

In Elixir, the = symbol is called the match operator. It is useful for assigning simple values, or it can also destructure more complex data types.

```elixir
{name, age, city} = {"Brooklin", 23, "Montreal"} # using a tuple  
[a, b, c] = [1, 2, 3] # using a list  
[head | tail] = [1, 2, 3] # you saw this before with lists
```

MatchError
----------

If your destructuring doesn’t match the right-hand side value, you will get a MatchError

```elixir
{a, b, c} **\=** {:hello, "world"}  
****** (MatchError) no match of right hand side value: {:hello, "world"}
```

Conclusion
==========

Hopefully, this article helps you rapidly get familiar with some of the most important bits of Elixir.

I left out a lot to keep the article concise. To learn more, the [Elixir Documentation](https://elixir-lang.org/getting-started/introduction.html) is a great place to start.