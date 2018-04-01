Title: Lua in Erlang
Date: 2017-07-16 16:20
Category: About

Luerl is an implementation of standard Lua 5.2 written in Erlang/OTP.

Lua is a powerful, efficient, lightweight, embeddable scripting language common in games, IoT devices, AI bots, machine learning and scientific computing research.

It supports procedural programming, object-oriented programming, functional programming, data-driven programming, and data description.

**Fast Language Switch**: Luerl should allow you to switch between Erlang and Lua incredibly fast, introducing a new way to use very small bits of logic programmed in Lua, inside an Erlang application, with good performance.

**Multicore**: Luerl provides a way to transparently utilize multicores. The underlying BEAM Erlang VM takes care of the distribution.

**Microprocesses**: It should give you a Lua environment that allows you to effortlessly run zillion of Lua processes in parallel, leveraging the famed microprocesses implementation of the BEAM Erlang VM. The empty Luerl State footprint will be yet smaller than the C Lua State footprint.

**Forking Up**: Because of the immutable nature of the Luerl VM, it becomes a natural operation to use the same Lua State as a starting point for multiple parallel calculations.

**Scripting**: Scripting emphasizes inter-language communication a system written in at least two languages a scripting language and a system language.