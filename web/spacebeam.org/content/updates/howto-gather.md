title:  Gathering Minerals to someday Build a Refinery and extract Vespene Gas
date: 2020-07-10
description: Let's learn to order our workers to gather some resources closest to them!

[TorchCraft](https://github.com/TorchCraft/TorchCraft/) is a [BWAPI](https://bwapi.github.io/) module that sends StarCraft: Brood War data out over a [ZMQ](https://zeromq.org) connection.
This lets you parse game data and interact with the Brood War API from anywhere.

This tutorial will walk you through execute the game for the first time after [installing the environment](https://spacebeam.org/2020/07/09/how-to-install-torchcraft-and-set-up-a-programming-environment-on-linux/),
we are going to dive into TorchCraft example.py and start gathering minerals to someday extract vespene gas.

Let's start the game and learn a bit more about TorchCraft a general overview can be found in:

Synnaeve, G., Nardelli, N., Auvolat, A., Chintala, S., Lacroix, T., Lin, Z.,
Richoux, F. and Usunier, N., 2016. _TorchCraft: a Library for Machine Learning Research
on Real-Time Strategy Games_ - [arXiv:1611.00625](https://arxiv.org/abs/1611.00625).

## Step 0 - Build a `launcher.py` script

```
cd /opt/StarCraft
```

```
wine bwheadless.exe -e /opt/StarCraft/StarCraft.exe\
 -l /opt/StarCraft/bwapi-data/BWAPI.dll --host\
 --name blueberry --game blueberry --race T\
 --map maps/TorchUp/\(4\)FightingSpirit1.3.scx&\
wine Chaoslauncher/Chaoslauncher.exe
```

That is what we are actually executing, let's build a `launcher.py` script.

```
:::python
#!/usr/bin/env python3

# Run bwheadless.exe and Chaoslauncher.exe from here!

import argparse
import os

parser = argparse.ArgumentParser(
    description='host a game with bwheadless')

parser.add_argument('-p', '--path',
                    type=str,
                    default='/opt/StarCraft/',
                    help='StarCraft path')
parser.add_argument('-b', '--bot',
                    type=str,
                    default='blueberry')
parser.add_argument('-r', '--race',
                    type=str,
                    default='Terran')
parser.add_argument('-m', '--map',
                    type=str,
                    default='\(4\)FightingSpirit1.3.scx')

args = parser.parse_args()

execute = '''
wine bwheadless.exe -e {0}StarCraft.exe\
 -l {0}bwapi-data/BWAPI.dll --host\
 --name {1} --game {1} --race {2}\
 --map maps/TorchUp/{3}&\
wine Chaoslauncher/Chaoslauncher.exe
'''.format(args.path, args.bot, args.race[:1], args.map)

os.chdir(args.path)
os.popen(execute).read()
```

Start the original example again and run `launcher.py` to see what gives?

## Step 1 - Run the original `example.py`

```
$ python3 /usr/src/TorchCraft/examples/py/example.py -t 127.0.0.1

```

## Step 2 - Run the `launcher.py` script

```
$ python3 /usr/src/starcraft-sif/examples/launcher.py
```

{% img [class name(s)] /images/1.png %}

If everything works as expected, you will see `Chaoslauncher`, the first time it will ask for the location of `StarCraft.exe`, you will find it on `/opt/StarCraft/` confirm and it will ask probably to restart `Chaoslauncher.exe`, kill the current session with `Control-C` in the terminal where you start `launcher.py` and run it again.

```
$ python3 /usr/src/starcraft-sif/examples/launcher.py
```

{%img [class name(s)] /images/2.png %}

Now with Chaoslauncher ready, enable the `BWAPI 4.2.0 [RELEASE]` and and `W-MODE` plugins and click on `Start` hopefully that will launch the game on your new environment, check `Multiplayer -> Local PC` and confirm that you see `blueberry` waiting in the lobby.

{%img [class name(s)] /images/3.png %}

## Step 3 - What is TorchCraft again?

TorchCraft is a library that enables machine learning research in the real-time strategy game of StarCraft: Brood War, by making easier to control the game from a machine learning framework, here [PyTorch](https://pytorch.org).

TorchCraft advocate to have not only the pixels as input and keyboard/mouse for commands, but also a structured representation of the game state.

This makes it easier to try a broad variety of models, and may be useful in shaping loss functions for pixel-based models.

StarCraft: Brood War is a highly competitive game with professional players, which provides interesting datasets, human feedback, and a good benchmark of what is possible to achieve within the game.


{%img [class name(s)] /images/4.png %}

### TorchCraft Design

TorchCraft connects Torch to BWAPI low level interface to StarCraft: Brood War. TorchCraft's approach is to dynamically inject a piece of code in the game engine that will be a server. This server sends the state of the game to a client, and receives commands to send to the game.

The two modules are entirely asynchronous. TorchCraft execution model inject a DLL that provides the game interface to the bots, and one that includes all the instructions to communicate with the external client, interpreted by the game as player (or bot AI).

The server starts at the beginning of the match and stops when that ends.

TorchCraft is seen by the AI programmer as a library that provides: `connect()`, `receive()` to get the state, `send(commands)`, and some helper functions about specifics of StarCraft's rules and state representation.

```
:::lua
-- main game engine loop:
-- it acts as the server for our TorchCraft bot client to `connect`, `receive` and `send(commands)`
while true do
    game.receive_player_actions()
    game.compute_dynamics()
    -- our injected code:
    torchcraft.send_state()
    torchcraft.receive_actions()
end
```

A simplified client/server model that runs in the game engine (server, on top) and the machine learning framework (client, on the bottom).

```
:::lua
-- ilustrates a TorchCraft bot using the Lua client to `connect`, `receive` and `send(commands)`
-- it acts as the machine learning client where we can integrate Torch to return in-game actions
tc = require('torchcraft')
featurize, model = init()
tc:connect(port)
while not tc.state.game_ended do
    tc:receive()
    features = featurize(tc.state)
    actions = model:forward(features)
    tc:send(tc:tocommand(actions))
end
```

TorchCraft also provides an efficient way to store game frames data from past games so that existing replays can be re-examined.

TorchCraft is a library that enables machine learning reserch on real game data by interfacing PyTorch with StarCraft: Brood War.

### The frame data structure

In addition to visual data, the server extracts certain information for the game state and sends it over to the client in a structured "frame".

The frame is formatted in a table in roughly the following structure:
```
:::javascript
received_update: {
    // Number of frames in the current game
    frame_from_bwapi: int
    units_myself: {
        // Unit ID
        int: {
            // Unit ID
            target: int
            targetpos: {
                // Absolute x
                1: int
                // Absolute y
                2: int
            }
            // Type of air weapon
            awtype: int
            // Type of ground weapon
            gwtype: int
            // Frames before next air weapon attack
            awcd: int
            // Number of hit points
            hp: int
            // Number of energy points, if any
            energy: int
            // Unit type
            type: int
            // Position
            position: {
                // Absolute x
                1: int
                // Absolute y
                2: int
            }
            // Number of armor points
            armor: int
            // Frames before next ground weapon attack
            gwcd: int
            // Ground weapon attack damae
            gwattack: int
            // Protoss shield points
            shield: int
            // Air weapon attack damage
            awattack: int
            // Size of the unit
            size: int
            // Whether unit is enemy or not
            enemy: bool
            // Whether unit is idle or not
            idle: bool
            // Ground weapon max range
            gwrange: int
            // Air weapon max range
            awrange: int
        }
    }
    // Same format as "units_myself"
    units_enemy: ...
}
```

## Step 4 - Analyzing TorchCraft `example.py`

What is TorchCraft's [example.py](https://github.com/TorchCraft/TorchCraft/bilob/master/examples/py/example.py) actually doing?

```
:::python
import torchcraft as tc
import torchcraft.Constants as tcc
```

Get closest function, seem very self explanatory

```
:::python
def get_closest(x, y, units)
    dist = float('inf')
    u = None
    for unit in units:
        d = (unit.x - x)**2 + (unit.y - y)**2
        if d < dist:
            dist = d
            u = unit
    return u
```

TorchCraft Python API client initial setup

```
:::python
client = tc.Client()
client.connect(hostname, port)
# Initial setup
client.send([
    [tcc.set_speed, 0],
    [tcc.set_gui, 1],
    [tcc.set_cmd_optim, 1],
])
```

> Plays simple micro battles with an attack closest heuristic

{%img [class name(s)] /images/4.png %}

```
:::python
while not state.game_ended:
    loop += 1
    state = client.recv()
    actions = []
    if state.game_ended:
        break
    else:
        units = state.units[0]
        enemy = state.units[1]
        for unit in units:
            target = get_closest(unit.x, unit.y, enemy)
            if target is not None:
                actions.append([
                    tcc.command_unit_protected,
                    unit.id,
                    tcc.unitcommandtypes.Attack_Unit,
                    target.id,
                ])
    print("Sending actions: " + str(actions))
    client.send(actions)
client.close()
```
## Step 5 - Minerals and Vespene Gas

Workers mine 8 minerals per trip. Minerals are the more important of the two physical resources, for all units produces from buildings or larvae require at least some minerals to be produced, while more basic units and structures do not require `Vespene Gas`. In addition, gas harvesting is possible only by building a gas-extracting structure on a geyser (`Extractor` for `Zerg`, `Refinery` for `Terran` and `Assimilator` for `Protoss`).

## Step 6 -  Gathering Minerals

```
TBD
```

if all went well, the workers should now start gathering the mineral patches closest to them!

```
TBD
```

Don't expect an optimal spread of workers, but that is left as an exercise.

## Step 7 - Build a Refinery

We Require More Vespene Gas

```
TBD
```

## Step 8 - Vespene Gas 
```
TBD
```

Next we will [train different units](https://spacebeam.org/2020/07/11/8-supply-11-gas-12-rax-14-scout/) to improve our Terran skills!
