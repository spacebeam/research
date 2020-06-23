Title: About
Date: 2020-06-23 16:20

Luerl is an implementation of standard Lua 5.3 written in Erlang/OTP a powerful, efficient, lightweight, embeddable scripting language common in games, IoT, artificial intelligence and scientific computing research.

It supports procedural, object-oriented, functional, data-driven, reactive, organizational programming and data description.

Being an extension language, Lua has no notion of a "main" program: it works as a library embedded in a host. The host program can invoke functions to execute a piece of Lua code, can write and read Lua variables, and call Erlang functions by Lua code.

The Luerl VM is a mixture of interpreting Lua VM instructions and using Erlang directly to implement function calls.

Through the use of Erlang functions, Luerl can be augmented to cope with a wide range of different domains, creating a customized language sharing a syntactical framework. 

Luerl is a library, written in clean Erlang/OTP. For more information, click on the [get started](https://github.com/rvirding/luerl/wiki/0.2-Getting-started) tutorial. You may also browse the [examples](https://github.com/rvirding/luerl/tree/develop/examples) and learn from the source code.

## Luerl goal

A proper implementation of the Lua language

- It SHOULD look and behave the same as Lua
- It SHOULD include the Lua standard libraries
- It MUST interface well with Erlang/OTP

## The result

Luerl is a native Erlang implementation of standard Lua 5.3 written for the BEAM ecosystem.

- Easy for Erlang to call
- Easy for Lua to call Erlang
- Erlang concurrency model and error handling

Through the use of Erlang/OTP, Luerl can be augmented to cope with a wide range of different domains, creating
a customized language sharing a syntactical framework.
