title:  Gathering Minerals to someday Build a Refinery and extract Vespene Gas
date: 2020-07-10
description: Let's learn to order our workers to gather some resources closest to them!

{% img [class name(s)] /images/blueberry.jpg %}

Learn to run the game and configure bwapi.ini before we can continue!

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

parser = argparse.ArgumentParser(description='host a game with bwheadless')

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

Let's start the game for the first time and test the original examples again to see what gives?

### Run the original `example.py` again

```
$ python3 /usr/src/TorchCraft/examples/py/example.py -t 127.0.0.1

```

### Run the `launcher.py` script

```
$ python3 /usr/src/starcraft-sif/examples/launcher.py
```

If everything works as expected, you will see Chaoslauncher, the first time it will ask for the location of StarCraft.exe, you will find it on `/opt/StarCraft/` confirm, it will ask probably to restart the Chaoslauncher program, kill the current execution with Control-C in the terminal where you execute the `launcher.py` and run it again.


```
$ python3 /usr/src/starcraft-sif/examples/launcher.py
```

Now with Chaoslauncher ready, enable the `BWAPI 2.4.0 Injector [RELEASE]` and and `W-MODE 1.02` plugins and click on `Start` hopefully that will launch StarCraft: Brood War on your new environment for the first time, Check on Multiplayer -> Local PC and confirm that you see a `blueberry` waiting for us on the lobby.

### Analyzing TorchCraft `example.py`

What is the original [example.py](https://github.com/TorchCraft/TorchCraft/blob/master/examples/py/example.py) actually doing?

```
:::python
while not state.game_ended:
    nloop += 1
    state = cl.recv()
    actions = []
    if state.game_ended:
        break
    elif state.battle_just_ended:
        dprint("BATTLE ENDED", 0)
        if state.battle_won: battles_won += 1
        battles_game += 1
        total_battles += 1
        frames_in_battle = 0
        if battles_game >= 10:
            actions = [
                [tcc.set_map, maps[nrestarts % len(maps)], 0],
                [tcc.quit],
            ]
            print(maps[nrestarts % len(maps)])
    elif state.waiting_for_restart:
        dprint("WAITING FOR RESTART", 0)
    else:
        myunits = state.units[0]
        enemy = state.units[1]
        if state.battle_frame_count % skip_frames == 0:
            for unit in myunits:
                target = get_closest(unit.x, unit.y, enemy)
                if target is not None:
                    actions.append([
                        tcc.command_unit_protected,
                        unit.id,
                        tcc.unitcommandtypes.Attack_Unit,
                        target.id,
                    ])
    if frames_in_battle > 2 * 60 * 24:
        actions = [[tc.quit]]
        nrestarts += 1
    dprint("Sending actions: " + str(actions), 1)
    cl.send(actions)
cl.close()
```

### What is TorchCraft again?

TBD

## Minerals and Vespene Gas

Minerals are a form of crystal resource. Terran and Protoss melt these minerals down to create the armored hulls of starships, behicles and personal armor. Even the `Zerg` require minerals to harder their caparaces and develop strong teeth and lungs.

Extracting minerals takes time and the specilized equipment or anatomy found on SCVs, probes and drones.

Workers mine 8 minerals per trip. Minerals are the more important of the two physical resources, for all units produces from buildings or larvae require at least some minerals to be produces, while more basic units and structures do not require `Vespene Gas`. In addition, gas harvesting is possible only by building a gas-extracting structure on a geyser (`Extractor` for `Zerg`, `Refinery` for `Terran` and `Assimilator` for `Protoss`).

### Gathering Minerals

```
TBD
```

if all went well, the workers should now start gathering the mineral patches closest to them!

```
TBD
```

Don't expect an optimal spread of workers, but that is left as an exercise to the reader.

## We Require More Vespone Gas

### Build a Refinery

```
TBD
```

Next we will [train different units](https://spacebeam.org/2020/07/11/8-supply-11-gas-12-rax-14-scout/) to improve our Terran skills!
