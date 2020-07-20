title: 8 Supply, 11 Gas, 12 Rax, 14 Scout 
date: 2020-07-11
description: Let's train some workers when we have the minerals for them!

That's the basics you go out, 16 supply, 16 factory, train 2 marines and put them with 1 scv at front on the ramp, 22 cc, 24 supply, 25 tank, 26 ebay.

## Asynchronous and non-Blocking I/O

Real-time features require (?)

Python 3 uses a single-threaded event loop to enable concurrent actions. This means that all aplication code should aim to be asynchronous and non-blocking because only one operation can be active at a time.

Asynchronous operations generally return placehorlder objects (Futures), with the expecion of some low-level components like the `IOLoop` that use callbacks.
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

Anything you can do with coroutines you can also do by passing callback objects around, but coroutines
provide an important simplification by letting you organize your code in the same way you would if it
were synchronous.

The is especially important for error handling, since in coroutines `try/expect` blocks work as you would expect

## Coroutines

Coroutines are the recommended way to write asynchronous code in Python.

*Coroutines* use the Python `await` or `yield` keyword to suspend and resume execution instead of a chain of callbacks, all coroutines use explicit context switches and are called as asynchronous functions.

Coroutines are almost as simple as synchronous code, but without the expense of a thread. They make concurrency easier to reason about by reducing the number of places where a context switch can happen.

### How to call a coroutine

Coroutines do not raise exceptions in the normal way: any exception they raise will be trapped in the awaitable object until it is yielded. This means it is important to call coroutines in the right way, or you may have errors that do unnoticed:


