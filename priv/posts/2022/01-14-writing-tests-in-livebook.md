%{
  title: "Writing Tests in Livebook.",
  tags: ~w(elixir livebook testing),
  description: "How to Use Variables and Kino Inputs in ExUnit Test Modules.",
  cover_image: "2022/1-14-writing-tests-in-livebook.jpg",
  livebook_url: "https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FBrooklinJazz%2Felixir_newbie_website%2Fblob%2Fmaster%2Flivebook%2Fwriting-tests-in-livebook.livemd"
}
---
## Overview

While creating the curriculum for an upcoming [Elixir developer bootcamp](https://twitter.com/BrooklinJMyers/status/1480614054360018951) I've started to use Livebook to deliver interactive instruction. It's incredibly useful, and allows me to write instruction in markdown and interactive examples or exercises to ensure that students understand core concepts.

[Livebook](https://github.com/livebook-dev/livebook) supports writing ExUnit tests. This empowers the students to recieve quick feedback on their answers. However, while creating these lessons, it wasn't immediately obvious to me how to connect student input with ExUnit tests.

There are 3 main types of student input to accept. Input as a variable, input as module function, and input as a Kino Input.
I'll cover how to handle all 3 and how to write effective tests that provide clear feedback to students. In addition, I'll share 
how to use :persistent_term to handle especially tricky student input.

## Writing Tests in Livebook

Check out the [Livebook Repository](https://github.com/livebook-dev/livebook#getting-started) If you are not already familiar with Livebook.
There you will find how to [run livebook locally](https://fly.io/launch/livebook) or [launch a cloud instance with Fly.io](https://fly.io/launch/livebook).

Once you have an environment to run livebook with, you can use the following code snippet in any
Elixir cell to setup ExUnit tests.

```elixir
ExUnit.start(auto_run: false)

defmodule ExampleTest do
  use ExUnit.Case, async: false

  test "example test" do
    assert true
  end
end

ExUnit.run()
```

## Student Input as a Variable

Elixir variables cannot be access outside a module. You'll see that the following code doesn't work
because `my_variable` is not defined inside of the `ExampleModule`'s `example_function`.

```elixir
my_variable = 4

defmodule ExampleModule do
  def example_function do
    my_variable
  end
end

ExampleModule.example_function()
```

You can get around this via module attributes like so:

```elixir
my_variable = 4

defmodule ExampleModule do
  @my_variable my_variable
  def example_function do
    @my_variable
  end
end

ExampleModule.example_function()
```

Here's that in an ExUnit test.

```elixir
ExUnit.start(auto_run: false)

defmodule ExampleTest do
  @my_variable my_variable
  use ExUnit.Case, async: false

  test "example_test_name" do
    assert @my_variable === 4
  end
end

ExUnit.run()
```

## Student Input as a Kino Input

[Kino](https://hexdocs.pm/kino/Kino.html) creates client-driven interactive widgets in your livebook. 
I primarily use it to create text or number inputs in my livebook lessons.

You can install Kino by including the following in an Elixir cell in your livebook.
You should check to make sure you use the latest version as this example may be out of date.

```elixir
Mix.install([
  {:kino, "~> 0.4.1"}
])
```

Once done, you can use Kino Inputs like so:

```elixir
example_input = Kino.Input.text("Input Label")
```

Then the student input can be read like so

```elixir
example_input = Kino.Input.read(example_input)
```

You can use the variable the same way that you did above via module attributes. There used to be a bug with this
but Jose Valim and Jonatan Klosko [resolved it](https://github.com/livebook-dev/kino/issues/72).

```elixir
defmodule ExampleModule do
  @example_input example_input
  def example_function do
    @example_input
  end
end

ExampleModule.example_function()
```

You can be more concise by simply reading the input in the module attribute. Here's that all together
in an ExUnit test.

```elixir
student_input = Kino.Input.number("Write the number 2")
```

```elixir
ExUnit.start(auto_run: false)

defmodule ExampleTest do
  @student_input Kino.Input.read(student_input)
  use ExUnit.Case, async: false

  test "example_test_name" do
    assert @student_input === 2
  end
end

ExUnit.run()
```

## Student Input as a Module Function

Student input as a module function is fairly straightforward, because it doesn't deal 
with any of the scoping issues that a variable or kino input do.

For example, if you gave the student an exercise to create a module that returns the first element in a list,
they could write their answer like so:

```elixir
defmodule StudentInput do
  def answer(list) do
    List.first(list)
  end
end
```

And then you can validate their solution with ExUnit.

```elixir
ExUnit.start(auto_run: false)

defmodule ExampleTest do
  use ExUnit.Case, async: false

  test "empty list" do
    assert StudentInput.answer([]) === nil
  end

  test "one element in list" do
    assert StudentInput.answer([1]) === 1
  end

  test "two elements in list" do
    assert StudentInput.answer([1, 2]) === 1
  end
end

ExUnit.run()
```

## Persistent Term Hack

You may run into types of input that do not allow you to inject them into the tests via module
attributes.

For example, you can not inject a function via module attributes.

```elixir
ExUnit.start(auto_run: false)

example_fn = fn list -> List.first(list) end

defmodule ExampleTest do
  @example_fn example_fn
  use ExUnit.Case, async: false

  test "example_test_name" do
    assert @example_fn.([1]) === 1
  end
end

ExUnit.run()
```

You cannot use `def` either because you cannot invoke `def` outside of a module.

```elixir
ExUnit.start(auto_run: false)

def my_fn(list) do
  List.first(list)
end

defmodule ExampleTest do
  @my_fn my_fn
  use ExUnit.Case, async: false

  test "example_test_name" do
    assert @my_fn.([1]) === 1
  end
end

ExUnit.run()
```

For cases like this, I've created a hack using `:persistent_term` that allows you to effectively handle these scenarios.

The student would create their function like so.

```elixir
example_fn = fn list -> List.first(list) end
```

Then you can store the input with the erlang :persistant_term library, and retrieve it
in the tests.

```elixir
ExUnit.start(auto_run: false)

:persistent_term.put("example_fn", example_fn)

defmodule ExampleTest do
  use ExUnit.Case, async: false

  test "example_test_name" do
    example_fn = :persistent_term.get("example_fn")
    assert example_fn.([1]) === 1
  end
end

ExUnit.run()
```

## Improved Test Feedback

To improve feedback in tests, you may wish to create custom error messages or hints.
You can do that by passing a value into the second argument of the assert function from ExUnit.

```elixir
student_input = 2
```

```elixir
ExUnit.start(auto_run: false)

defmodule ExampleTest do
  @student_input student_input
  use ExUnit.Case, async: false

  test "example_test_name" do
    assert @student_input <= 0,
           "Hint, make sure to enter a negative number. You entered: #{@student_input}"
  end
end

ExUnit.run()
```

## Conclusion

Livebook is enabling me to write interactive content to help people learn Elixir.
Infact, this entire article is interactive if you'd like to run any of the examples, make sure you click the "Run in Livebook" badge at the top.

If you're curious about the Elixir Bootcamp, I'm working full time with DockYard now to
help new and beginner developers learn Elixir. If you'd like to know more and/or help shape the curriculum,
please [reach out](https://twitter.com/BrooklinJMyers).
