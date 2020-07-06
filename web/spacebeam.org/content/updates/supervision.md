title: Stage 2 Supervision
date: 2020-07-06
description: runit is a collection of tools for managing UNIX services.. Supervision means the system will restart the process immediately if it disappers for some reason, e.g a crash!

## Process supervision

At its code, runit is a process supervision suite.

The concept of process supervision comes from several observations:

- UNIX systems, even minimalistic ones, need to run long-lived processes, aka daemons.

That one is the core design principle of UNIX: one service -> one daemon.


