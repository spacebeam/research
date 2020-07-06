title: Stage 2 Supervision
date: 2020-07-06
description: A collection of tools for managing UNIX services.. Supervision means the system will restart the process immediately if it crash for some reason!

At its core, `runit` is a process supervision suite.

The concept of process supervision comes from several observations:

- UNIX systems, even minimalistic ones, need to run long-lived processes, aka daemons.

That one is the core design principle of UNIX: one service -> one daemon.

- Daemons can die at all times. Maybe they are missing a vital resource and cannot handle certain failure;
- Automatically restarting daemons when they die is generally a good thing.

A process supervsion system organizes the process hierarchy in a radical different way.

- A process supervision system starts independen hierarchy of processes at boot time, called a supervision tree.
- Your daemon is identified by the specific directory which contains all the information about it; then you send a message to the supervision tree. The supervision tree start the daemon as a leaf.
- The parent of your daemon is a supervisor. Since your daemon is its direct child, the supervisor always knows the correct PID of your daemon.
- To send signals to your daemons, you send a message to its supervisor, which will then send the signal to the daemon in your behalf.

The design of `runit` takes a very familiar approach by breaking down functionality into several small utilities
responsible for a single task. This approach allows the simple components to be composed in various ways to suit
our needs. The core runit utilities are `runsvdir`, `runsv`, `chpst`, `svlogd`, and `sv`.

## Service supervision

Each service is associated with a service directory, and each service daemon runs as a child process of a supervising `runsv` process runing in this directory.

The `runsv` program provides a reliable interface for signalling the service daemon and controlling the service and supervisor.
