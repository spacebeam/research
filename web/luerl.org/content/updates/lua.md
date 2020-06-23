title: Lua in Erlang
date: 2020-02-20
description: Luerl is an implementation of standard Lua written in Erlang/OTP a powerful, efficient, lightweight, embeddable scripting language common in games, IoT, artificial intelligence and scientific computing research.

"Scripting is a relevant technique for any programmer's toolbox." &mdash; Roberto Ierusalimschy

Luerl is an implementation of standard Lua 5.3 written in Erlang/OTP.

A powerful, efficient, lightweight, embeddable scripting language common in games, IoT, artificial intelligence and scientific computing research.

It supports procedural, object-oriented, functional, data-driven, reactive, organizational programming and data description.

Being an extension language, Lua has no notion of a "main" program: it works as a library embedded in a host. The host program can invoke functions to execute a piece of Lua code, can write and read Lua variables, and call Erlang functions by Lua code.

Luerl is written in clean Erlang/OTP. For more information, check out the [get started](https://github.com/rvirding/luerl/wiki/0.2-Getting-started) tutorial. You may want to browse the [examples](https://github.com/rvirding/luerl/tree/develop/examples) source code.

## Luerl goal
A proper implementation of the Lua language
- It SHOULD look and behave the same as Lua 5.3
- It SHOULD include the Lua standard libraries
- It MUST interface well with Erlang

## Embedded language
Lua is an embeddable language implemented as a library that offers a clear API for applications inside a register-based virtual machine.

This ability to be used as a library to extend an application is what makes Lua an extension language. 

At the same time, a program that uses Lua can register new functions in the Luerl environment; such functions are implemented in Erlang (or another language) and can add facilities that cannot be written directly in Lua. This is what makes any Lua implementation an extensible language.

These two views of Lua (as extension language and as extensible language) correspond of two kinds of interaction between Erlang and Lua. In the first kind, Erlang has the control and Lua is the library. The Erlang code in this kind of interaction is what we call application code. 

In the second kind, Lua has the control and Erlang is the library. Here, the Erlang code is called library code. Both application code and library code use the same API to communicate with Lua, the so called Luerl API.

Modules, Object Oriented programming and iterators need no extra features in the Lua API. They are all done with standard mechanisms for tables and first-class functions with lexical scope.

Exception handling and code load go the opposite way: primitives in the API are exported to Lua from the base system C, JIT, BEAM.

Lua implementations are based on the idea of closures, a closure represents the code of a function plus the environment where the function was defined.

Like with tables, Luerl itself uses functions for several important constructs in the language. The use of constructors based on functions helps to make the API simple and general.

## The result
Luerl is a native Erlang implementation of standard Lua 5.3 written for the BEAM ecosystem.

- Easy for Erlang to call 
- Easy for Lua to call Erlang
- Erlang concurrency model and error handling

Through the use of Erlang/OTP, Luerl can be augmented to cope with a wide range of different domains, creating a customized language sharing a syntactical framework.
