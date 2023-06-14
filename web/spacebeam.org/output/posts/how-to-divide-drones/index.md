---
category: ''
date: 2020-07-28 19:22:30 UTC-06:00
description: ''
link: ''
slug: how-to-divide-drones
tags: 'guide'
title: How to divide drones for mining minerals
type: text
---
Let's learn to order our workers to gather some resources closest to them!

[TorchCraft](https://github.com/TorchCraft/TorchCraft/) is a [BWAPI](https://bwapi.github.io/) module that sends StarCraft: Brood War data out over a [ZMQ](https://zeromq.org) connection.
This lets you parse game data and interact with the Brood War API from anywhere.

This tutorial will walk you through start the game for the first time after [installing the environment](https://spacebeam.org/2020/07/09/how-to-install-torchcraft-and-set-up-a-programming-environment-on-linux/),
we are going to dive into TorchCraft's Python API and its provided [example.py](https://github.com/TorchCraft/TorchCraft/blob/master/examples/py/example.py), learn to train a SCV, gather minerals, build a refinery and start harvesting-gas!

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
 --name Blueberry --game Blueberry --race T\
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
                    default='Blueberry')
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

### Run the original `example.py`

```
$ python3 /usr/src/TorchCraft/examples/py/example.py -t 127.0.0.1

```

### Run the `launcher.py` script

```
$ python3 /usr/src/starcraft-sif/examples/launcher.py
```


If everything works as expected, you will see `Chaoslauncher`, the first time it will ask for the location of `StarCraft.exe`, you will find it on `/opt/StarCraft/` confirm and it will ask probably to restart `Chaoslauncher.exe`, kill the current session with `Control-C` in the terminal where you start `launcher.py` and run it again.

```
$ python3 /usr/src/starcraft-sif/examples/launcher.py
```

{% img [class name(s)] /images/1.png %}

Now with Chaoslauncher ready, enable the `BWAPI 4.2.0 [RELEASE]` and and `W-MODE` plugins and click on `Start` hopefully that will launch the game on your new environment, check `Multiplayer -> Local PC` and confirm that you see `Blueberry` waiting in the lobby.

{%img [class name(s)] /images/2.png %}

{%img [class name(s)] /images/3.png %}
## Step 1 - What is TorchCraft again?

{%img [class name(s)] /images/4.png %}

TorchCraft is a library that enables machine learning research in the real-time strategy game of StarCraft: Brood War, by making easier to control the game from a machine learning framework, here [PyTorch](https://pytorch.org).

TorchCraft advocate to have not only the pixels as input and keyboard/mouse for commands, but also a structured representation of the game state. This makes it easier to try a broad variety of models.

StarCraft: Brood War is a highly competitive game with professional players, which provides interesting datasets, human feedback, and a good benchmark of what is possible to achieve within the game.

### BWAPI

BWAPI is a programming interface written in C++ which allows users to read data and send game commands to a StarCraft: Brood War game client. BWAPI contains all functionality necessary for the creation of a competitive bot. Examples of BWAPI functionality are:

- Perform unit actions, i.e: `Attack`, `Move`, `Build`
- Obtain current data about any visible unit, such as: `Position`, `HP`, `Energy`
- Obtain offline data about any unit type, such as: `MaxSpeed`, `Damage`, `MaxHP`, `Size`

Programs written with BWAPI alone are usually compiled into a Windows dynamically linked library (DLL) which is injected into the game. BWAPI allows the user to perform any of the aboce functionality while the game is running, after each logic frame update within the game's software.

After each logic frame, BWAPI interrupts the StarCraft process and allows the user to read game data and issue commands, which are stored in a queue to be executed during the game's next logic frame.

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
-- it acts as the machine learning client where we can integrate Torch7 to return in-game actions
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

## Step 2 - Analyzing TorchCraft `example.py`

What is TorchCraft's [example.py](https://github.com/TorchCraft/TorchCraft/blob/master/examples/py/example.py) actually doing?

```
:::python
import torchcraft as tc
import torchcraft.Constants as tcc
```

Get closest function, very self explanatory!

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

{%img [class name(s)] /images/5.png %}

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
    print("Sending actions: {}".format(str(actions)))
    client.send(actions)
client.close()
```

The TorchCraft API is a layer of abstraction on top of BWAPI, we don't interact with BWAPI directly, this is the biggest difference if compared with common C++ or Java bots.


## Step 3 - Minerals and Vespene Gas

Workers mine 8 minerals per trip. Minerals are the more important of the two physical resources, for all units produces from buildings or larvae require at least some minerals to be produced, while more basic units and structures do not require `Vespene Gas`. In addition, gas harvesting is possible only by building a gas-extracting structure on a geyser (`Extractor` for `Zerg`, `Refinery` for `Terran` and `Assimilator` for `Protoss`).

{%img [class name(s)] /images/6.png %}
### Run `gathering.py` example

```
$ python3 /usr/src/starcraft-sif/examples/gathering.py

```

### Run `launcher.py` script

```
$ python3 /usr/src/starcraft-sif/examples/launcher.py
```

### Train a SCV

```
:::python
for unit in units:
    if tcc.isbuilding(unit.type)\
     and tc.Constants.unittypes._dict[unit.type]\
     == 'Terran_Command_Center':
        if not producing\
         and state.frame.resources[bot['id']].ore >= 50\
         and state.frame.resources[bot['id']].used_psi\
         != state.frame.resources[bot['id']].total_psi:
            # Target, x, y are all 0
            actions.append([
                tcc.command_unit_protected,
                unit.id,
                tcc.unitcommandtypes.Train,
                0,
                0,
                0,
                tc.Constants.unittypes.Terran_SCV,
            ])
            # to train a unit you MUST input into "extra" field
            producing = True
```

### Gathering Minerals

if all went well, the workers should now start gathering the mineral patches closest to them!

```
:::python
gather = tcc.command2order[tcc.unitcommandtypes.Gather] 
build = tcc.command2order[tcc.unitcommandtypes.Build]
right_click_position = tcc.command2order[tcc.unitcommandtypes.Right_Click_Position]

for order in unit.orders:
    if order.type not in gather\
     and order.type not in build\\
     and order.type not in right_click_position\ 
     and not building_refinery:
        target = get_closest(unit.x, unit.y, neutral)
        if target is not None:
            actions.append([
                tcc.command_unit_protected,
                unit.id,
                tcc.unitcommandtypes.Right_Click_Unit,
                target.id,
            ])
```

Don't expect an optimal spread of workers, but that is left as an exercise.

###  Build a Refinery

We Require More Vespene Gas

```
:::python

vespene = 'Resource_Vespene_Geyser'

if tcc.isworker(unit.type):
    workers.append(unit.id)
    if state.frame.resources[bot['id']].ore >= 100\
     and not building_refinery:
        for nu in neutral:
            if tcc.unittypes._dict[nu.type] == vespene:
                gas_harvesting.append(unit.id)
                actions.append([
                    tcc.command_unit,
                    unit.id,
                    tcc.unitcommandtypes.Build,
                    -1,
                    nu.x - 8,
                    nu.y - 4,
                    tcc.unittypes.Terran_Refinery,
                ])
                building_refinery = True
```

###  Gas harvesting 
```
:::python
if building_refinery and gas_harvesting[0] != unit.id\
     and len(gas_harvesting) == 1 and refinery:
        gas_harvesting.append(unit.id)
        actions.append([
            tcc.command_unit_protected,
            unit.id,
            tcc.unitcommandtypes.Right_Click_Unit,
            refinery
        ])
elif refinery and gas_harvesting[0] != unit.id\
     and gas_harvesting[1] != unit.id\
     and len(gas_harvesting) == 2:
        gas_harvesting.append(unit.id)
        actions.append([
            tcc.command_unit_protected,
            unit.id,
            tcc.unitcommandtypes.Right_Click_Unit,
            refinery
        ])
```

## Further Reading

Here is a link to the complete [gathering.py](https://github.com/spacebeam/starcraft-sif/blob/master/examples/gathering.py) script if you are just curious,
Next we will [train different units](https://spacebeam.org/2020/07/11/8-supply-11-gas-12-rax-14-scout/) to improve our Terran skills!

