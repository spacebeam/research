---
category: ''
date: 2020-08-11 19:56:29 UTC-06:00
description: ''
link: ''
slug: 8-supply-11-gas-12-rax-14-scout
tags: ''
title: 8 Supply, 11 Gas, 12 Rax, 14 Scout
type: text
---
Let's train some workers when we have the minerals for them!

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

Processes are idependent units of execution, a subroutine lives inside a process.

### Cooperative multitasking

Also known as non-preemptive multitasking, is a style of computer multitasking in which the operating system never initiates a context switch from a running process to another process.

Instead, processes voluntary yield control periodically or when idle in order to enable multiple applications to be run concurrently.

## Python 3 `await` and `yield`

Python uses a single-threaded event loop to enable concurrent actions. This means that all real-time aplication code should aim to be asynchronous and non-blocking because only one operation can be active at a time.

Asynchronous operations generally return placeholder objects ([Futures](https://docs.python.org/3.7/library/concurrent.futures.html)).
`Futures` are usually transformed into their result with the `await` and `yield`.

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

And here the same rewritten asynchronously as a native coroutine:

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
were synchronous, important for error handling since `try/expect` work as you would expect.

## Why ZeroMQ helps?
ZeroMQ is a community of projects focused on decentralized message passing. They agree on protocols (RFCs) for connecting to each other and exchanging messages. Messages are blobs of useful data of any reasonable size.

You can use this feature to queue, route, and filter messages according to various `patterns`.

Multilingual Distributed Messaging thanks to the ZeroMQ Community.

- Carries messages across inproc, IPC, TCP, multicast.
- Smart patterns like pub-sub, push-pull, request-reply.
- Backed by a large and active open-source community.

It's asynchronous I/O model gives you scalable multicore applications, built as asynchronous message-processing subroutines. [Read the guide](http://zguide.zeromq.org/).

## Coroutines again

Coroutines are the recommended way to write asynchronous code.

*Coroutines* use the Python 3 `await` or `yield` keyword to suspend and resume execution instead of a chain of callbacks, all coroutines use explicit context switches and are called as asynchronous functions.

Coroutines are almost as simple as synchronous code, but without the expense of a thread. They make concurrency easier to reason about by reducing the number of places where a context switch can happen.

### How to call a coroutine

Coroutines do not raise exceptions in the normal way: any exception they raise will be trapped in the awaitable object until it is yielded.
This means it is important to call coroutines in the right way, or you may have errors that do unnoticed:

```
:::python
async def divide(x, y):
    return x / y
    
def bad_call()
    # This should raise ZeroDivisionError, but it won't
    # because the coroutine is called incorrectly!
    divide(1, 0)
```
In nearly all cases, any function that calls a coroutine must be a coroutine itself, 
and use the `await` or `yield` keyword in the call.

```
:::python
async def good_call():
    # await will unwrap the object returned by divide()
    # and raise the expection.
    await divide(1, 0)
```
#### Fire and forget

Sometimes you may want to "fire and forget" a coroutine without waiting for its result. In this case it is recommended to use `IOLoop.spawn_callback`, which makes the `IOLoop` responsible for the call.
If it fails, the `IOLoop` will log a stack trace:

```
:::python
# The IOLoop will catch the expection and print a stack trace
# in the logs. Note that this doesn't look like a normal call,
# since we pass the function object to be called by the IOLoop.
IOLoop.current().spawn_callback(divide, 1, 0)
```

## Coroutine patterns

### Calling blocking functions

The simplest way to call a blocking function from a coroutine is to use `IOLoop.run_in_executor`, which returns `Futures` that are compatible:

```
:::python
async def call_blocking():
    await IOLoop.current().run_in_executor(None, blocking_func, args)
```

### Parallelism

The `multi` function accepts lists and dicts whose values are `Futures` and waits for all of those `Futures` in parallel:

```
:::python
from tornado.gen import multi

async def parallel_fetch(url1, url2):
    resp1, resp2 = await multi([http_client.fetch(url1),
                                http_client.fetch(url2)]

async def parallel_fetch_many(urls):
    res = await multi([http_client.fetch(u) for u in urls])
    # res is a list of HTTPResponses in the same order

async def parallel_fetch_dict(urls):
    res = await multi({url: http_client.fetch(url)
                      for url in urls})
    # res is a dict {url: HTTPResponse}
```

In decorated coroutines, it is possible to `yield` the list or dict directly:

```
:::python
@gen.coroutine
def parallel_fetch_decorated(url1, url2):
    resp1, resp2 = yield [http_client.fetch(url1),
                          http_client.fetch(url2)]
```

### Interleaving

Sometimes it is useful to save a `Future` instead of yielding it immediately, so you can start another operation before waiting.

```
:::python
from tornado.gen import convert_yielded

async def get(self):
    # convert_yielded() starts the native coroutine in the background.
    # This is equivalent to asyncio.ensure_future() (both work)
    fetch_future = convert_yielded(self.fetch_next_chunk())
    while True:
        chunk = yield fetch_future
        if chunk is None: break
        self.write(chunk)
        fetch_future = convert_yielded(self.fetch_next_chunk())
        yield self.flush()
```

This is a little easier to do with decorated coroutines, because they start immediately when called:

```
:::python
@gen.coroutine
def gen(self):
    fetch_future = self.fetch_next_chunk()
    while True:
        chunk = yield fetch_future
        is chunk is None: break
        self.write(chunk)
        fetch_future = self.fetch_next_chunk()
        yield self.flush()
```

### Looping

In native coroutines, `async for` can be used.

### Running in the background
`PeriodicCallback` is not normally used with coroutines. Instead, a coroutine can contain a `while True:` loop and use `tornado.gen.sleep`:

```
:::python
async def minute_loop():
    while True:
        await do_something()
        await gen.sleep(60)

# Coroutines that loop forever are generally started with
# spawn_callback().
IOLoop.current().spawn_callback(minute_loop)
```

Sometimes a more complicated loop may be desirable. For example, the previous loop runs every `60+N` seconds,
where `N` is the running time of `do_something()`. To run exactly every 60 seconds, use the interleaving pattern from above:

```
:::python
async def minute_loop2():
    while True:
        nxt = gen.sleep(60)  # Start the clock.
        await do_something() # Run while the clock is ticking.
        await nxt            # Wait fot he timer to run out.
```

## Further Reading

TBD

