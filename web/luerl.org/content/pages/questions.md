Title: Questions
Date: 2019-11-08 16:20

## How does Lua call Erlang?
`i.e, Lua want to send socket through Erlang, or tell other Erlang node some information, how to do this?`

You cannot directly call Erlang from the Lua inside luerl. To do this you need to define an interface module written in Erlang with functions you can call from Lua. There is a predefined way of building and loading such a module so it can be reached from Lua through a table like any other Lua function. There is also a predefined way of passing data in and out of these functions. If you look in the src directory all the modules luerl_lib_XXXX.erl are interface modules like this.

Sandboxing is very easy as Lua code cannot do this loading, it has to be done in the surrounding Erlang. Which makes it trivial to set up a limited environment.

## Howto set Lua script search path? (!)
Luerl uses (package.config, loaded, preload, path, seachers, searchpath) as per the manual. At least that is the intent.

## Reading files
Try this from the Erlang shell putting the code in a file "test.lua" then doing

`1> luerl:do("local local = dofile(\"test.lua\")", S0).`

## it is possible in luerl to identify on which line we are now?
So while a stack trace is of course possible with the current implementation it won't tell you that much. 

## But you still have stacktrace there? 

Currently I have keep minimal information on the for function calls and the information is split between the luerl stack and the erlang functions it references.

It was never designed for doing stacktraces and would need a reworking to do it.

The stack traces are a problem. One reason they look like they do is that I am internally using erlang calls directly to implement lua calls which in a way hides them. I am thinking about how to fix this so we get a reasonable Lua stack trace.

## Luerl internal and external formats

## (!) nicer names for functions that handle internal data structures (!?)

## Lua coroutines in Luerl?

When we have needed something like coroutines we have instead used Erlang's processes. We then run Luerl inside each process and use Erlang messages for communication and leave the scheduling to Erlang. This works very well but it is not quite the same thing and it does mean you can't just use already coroutine-based code must it must be specially written for this.

Another issue is that as all these "Lua processes" are running in separate Erlang processes they can't share any state.

## Does Luerl provide persistent data structures?
Luerl is an implementation of Lua 5.3 where instead of a C API we have Erlang at the lowest level, this means you can have the full power of the Lua language at the same time that you benefit from Erlang and all it features like immutable data and the powerful OTP and BEAM VM.

Luerl processes live inside the Erlang environment and not in the OS and interact with an Erlang API instead of C.


## Is there any way to use Lua as an immutable language (thanks to luerl)? 
`My understanding is that this is something that can be implemented globally on a generic way. Is this correct?`

No, there are no generic global things in the Erlang environment.

We don't share memory, there is no global state or central thread of execution, in Luerl you could have global things that only apply to the execution of that process runing the Luerl VM but in practice is common to have more than one Lua process running and the way those interact between each other and the environment is not by reading a global state but by passing messages.

## how to call erlang function from lua file?
