title: 8 Supply, 11 Gas, 12 Rax, 14 Scout 
date: 2020-07-11
description: Let's train some workers when we have the minerals for them!

That's the basics you go out, 16 supply, 16 factory, train 2 marines and put them with 1 scv at front on the ramp, 22 cc, 24 supply, 25 tank, 26 ebay.

This tutorial will walk you through StarCraft: Brood War bot development with Python, but first we are going to dive deep into [Coroutines](https://en.wikipedia.org/wiki/Coroutine)!

Real-time strategy (RTS) games are known to be one of the most complex game genres for humans and machines to play. To tackle the task we focus on a message-passing divide-and-conquer approach with [ZMQ](https://zeromq.org) and multiple languages, splitting the game into separate components and developing separate systems to solve each task.

This trend gives rise to a new problem: how to tie these systems together into a functional StarCraft: Brood War playing bot?

## Coroutines

*Coroutines* are computer-program components that generalize subroutines for non-preemptive multitasking by allowing multiple entry points for suspending and resuming execution at certain locations.

Subroutines are short programs that perform functions of a general nature that can occuir in varios types of computation.

A sequence of program instructions that perform a specific task, packaged as a unit. This unit can then be used in programs wherever that particular task should be performed.

Subprograms may be defined within programs, or separately in libraries that can be used by multiple programs.

In different programming languages, a subroutine may be called a procedure, a function a routine, a method, a subprogram.

### Difference with processes

Processes are idependent units of execution instead of a subroutine that lives inside a process.

### Cooperative multitasking

Also known as non-preemptive multitasking, is a style of computer multitasking in which the operating system never initiates a context switch from a running process to another process.

Instead, processes voluntary yield control periodically or when idle in order to enable multiple applications to be run concurrently.

## Python 3 `await` and `yield`

Python uses a single-threaded event loop to enable concurrent actions. This means that all real-time aplication code should aim to be asynchronous and non-blocking because only one operation can be active at a time.

Asynchronous operations generally return placeholder objects (Futures).
`Futures` are usually transformed into their result with the `await` and `yield` keywords.

### Examples

Here is a sample synchronous function:

```
:::python
from tornado.httpclient import HTTPClient

def synchronous_fetch(url):
    http_client = HTTPClient()
    response = http_client.fetch(url)
    return response.body
```

And here the same function rewritten asynchronously as a native coroutine:

```
:::python
from tornado.httpclient import AsyncHTTPClient

async def asynchronous_fetch(url):
    http_client = AsyncHTTPClient()
    response = await http_client.fetch(url)
    return response.body
```

Anything you can do with coroutines you can also do by passing callback around, but coroutines
provide an important simplification by letting you organize your code in the same way you would if it
were synchronous, important for error handling since in coroutines `try/expect` blocks work as you would expect.

## Why ZeroMQ helps?
ZeroMQ is a community of projects focused on decentralized message passing. They agree on protocols (RFCs) for connecting to each other and exchanging messages. Messages are blobs of useful data of any reasonable size.

You can use this feature to queue, route, and filter messages according to various `patterns`.

Multilingual Distributed Messaging thanks to the ZeroMQ Community.

- Carries messages across inproc, IPC, TCP, multicast.
- Smart patterns like pub-sub, push-pull, request-reply.
- Backed by a large and active open-source community.

It's asynchronous I/O model gives you scalable multicore applications, built as asynchronous message-processing subroutines. Read the guide and learn the basics.

### Protocols
TBD

### Community
TBD

## Coroutines again

Coroutines are the recommended way to write asynchronous code.

*Coroutines* use the Python 3 `await` or `yield` keyword to suspend and resume execution instead of a chain of callbacks, all coroutines use explicit context switches and are called as asynchronous functions.

Coroutines are almost as simple as synchronous code, but without the expense of a thread. They make concurrency easier to reason about by reducing the number of places where a context switch can happen.

### How to call a coroutine

Coroutines do not raise exceptions in the normal way: any exception they raise will be trapped in the awaitable object until it is yielded. This means it is important to call coroutines in the right way, or you may have errors that do unnoticed:


