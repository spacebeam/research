---
category: ''
date: 2022-08-03 10:18:00 UTC-06:00
description: ''
link: ''
slug: install 
tags: ''
title: Install
type: text
---

<!-- WIKIDOC PDFONLY
<h1>Hello Luerl</h1>
WIKIDOC PDFONLY -->

Luerl works as a library embedded in a host simple called the embedding program. The host program can invoke functions to execute a piece of Lua code, can write and read Lua variables, and call Erlang functions by Lua code.

Through the use of Erlang, Luerl can be augmented to cope with a wide range of different domains, creating a customized language sharing a syntactical framework.

## Installing Luerl

[Luerl](https://luerl.org) implement standard [Lua](https://lua.org) 5.3 in pure Erlang to start using the project you need to include the luerl library as new dependency on your OTP application.

### Rebar

With [Rebar 3](https://rebar3.org), you can either install `luerl` from [hex.pm](https://hex.pm/packages/luerl) or from GitHub directly (for more info on Rebar dependencies, see the [dependency documentation](https://rebar3.org/docs/configuration/dependencies/)).

Add `luerl` as a dependency to your project `rebar.config` file using one of the two options below.

#### Hex

```erl
{deps, [luerl]}.
```

#### GitHub

```erl
{deps, [{luerl, {git, "git://github.com/rvirding/luerl.git", {branch, "develop"}}}]}.
```

### Erlang.mk
Or use [Erlang.mk](https://erlang.mk) to setup quickly your environment, build the code and project release.

Create a Makefile and include luerl to the project dependencies.

``` Makefile
DEPS = luerl
```

### Source code
`$ git clone https://github.com/rvirding/luerl.git`

## Getting started

For a quick starting tutorial we're going to use [Erlang.mk](https://erlang.mk) to setup quickly our environment, build our code and start or stop the project release.

Erlang.mk is very easy to setup: create a folder, put Erlang.mk in it, and write a Makefile:

`include erlang.mk`

For a step by step:

`$ mkdir luerl_demo`

`$ cd luerl_demo`

`$ curl https://erlang.mk/erlang.mk -o erlang.mk`

Create a Makefile and copy the next code snippet, there you can make the correct changes to reflect your project needs.

``` Makefile
PROJECT = ophelia
DEPS = luerl
include erlang.mk
```

`$ make`

From that point you can create an src/ folder or start using http://erlang.mk/ templates - [User guide](http://erlang.mk/guide/).
