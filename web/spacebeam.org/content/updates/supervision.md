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

The service daemon and log daemon run with different process states and can run under different user id's.

## Stage 2

Stage 2 handles the systems's uptime tasks (via the `runsvdir` program) and is running the whole system's uptime life spawn.

Stage 2 is portable across UNIX systems. `runit` is well suited for [autopilot nodes](https://old.reddit.com/r/teslamotors/comments/arfwvm/some_sw_internals_of_tesla_autopilot_node_hw2/), servers and embedded systems, and also does its job well on everyday working environments.

Stage 2 is packaging friendly: all software package that provides a service needs to do is to include a service directory in the package, we provide a symbolic link mechanism to this directory in `/etc/service/`. The service will be started within five seconds, and automatically at boot time.

The package's install and update scripts can use the reliable control interface to stop, start, restart or send signal to the service.

On package removal, the symbolic link simply is removed. The service will be taken down automatically.

## Service dependencies

runit's service supervision resolves dependencies for service daemons designed to be run by a supervisor process automatically.

The service daemon (or the corresponding run script) should behave as follows:

- before providing the service, check if all services it depends on are available. If not, exit with an error, the supervisor will then try again.
- write all logs through runit's logging facility. The `runsv` program takes care that all logs for the service are written safely to disk.
- optionally when the service is told to become down, take down other services that depend on this one after disabling the service.
