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

Normally the `sv` program is used to send commands throught this interface, and to query status information about the service.

The `runsv` program supervises the corresponding service daemon. By default a service is defined to be up, that means, if the service daemon dies, will be restarted. Of course you can tell it otherwise.

The promise is that this reliable interface to control daemons and supervisors obsolete pid-guessing programs, such as pidoff, killall, start-stop-daemon, which, due to guessing are prone to failures by design.

It also obsoletes so called pid-files, no need for each and every service daemon to include code to daemonize, to write the new process id into a file, and to take care that file is removed properly on shutdown, which might be very difficult in case of a crash!

## Clean process state

`runit` guarantees each service a clean process state, no matter if the service is activated for the first time or automatically at boot time, reactivated, or simply restarted. This means that the service always is started with the same environment, resource limits, open file descriptors, and controlling terminals.

## Reliable logging facility

The `runsv` program provides a reliable logging facility for the service daemon. If configured, `runsv` creates a pipe, starts and supervises an additional log service, redirects the log daemon's standard input to read from the pipe, and redirects the service daemon's standard output to write to the pipe.

Restarting the service does not require restarting the log service, and vice versa.

A good choice for log daemon is runit's service logging daemon `svlogd`.

The service daemon and log daemon run with different process statesm and can run under different user id's.

`runit` supports easy and realiable logging for service daemons running inside `singularity` containers.

## Stage 2


