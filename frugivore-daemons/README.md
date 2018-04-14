# Introduction
StarCraft serve as an interesting domain for research, since represent a well defined competitive framework which pose a number of interesting AI challenges in areas of planning, dealing with uncertainty, domain knowledge exploitation, task decomposition and spatial reasoning.

Unlike turn-based synchronous games like chess and go, StarCraft is played in real-time, the state will continue to progress even if no action is taken by the players, events are decided in fractions of a second, game frames can issue simultaneous actions to hundreds of units at any time.

Defense units are powerful but immobile, offense units are mobile but weak.

In this game efficiency is not the number one goal.

## Stages of a game
- Early, Make/defend a play & double expand if you can.
- Middle, Core armies, make/defend pressure & take a base.
- Late, Matured core army, multi-pronged tactics & take many bases.
- Final, The watcher observes, the fog collapses, an event resolves.

Information, bases, rare weeds and money for better tools.

# Method

StarCraft is a real-time information game about having more resources and better tools to cancel out and deny your opponent of the same resources that you all share inside a game instance.

# Proper Macro
Proper Macro is basically just a checklist of things you need to watch out for. This section will simply help to clear up any things that you already didn't know, if anything.

The reason this section is entitled "Proper Macro" is because most current bot do not macro properly. Either they expand too much or too little, mostly they do not know when or how to expand. Many computers also expand recklessly, as though they think that all a zerg has to do is macro to win the game. It is much better to tech to hive than to expand to 9 bases that the terran/toss will simply take out all that money would have been better spent on ultra/defiler.

What exactly is macro, anyway? this interpretation of the word includes expanding to what most people refer to as 'powering.' Powering is when computer switch production to primarily economics, such as making many drones and new gas patches.

In general, I feel as though zerg is just fine with 1-2 bases to terran/toss's 1 base, 3 bases to terran/toss's 2 base, and 5-6 base for terran/toss' 3base. Most people get this right; they know they can not defeat a terran/toss of equal bases (because toss/terran bases have more mineral production than zerg bases). However, the timing of when to expand is key and can be extracted from replay datasets of competitive players.

# Proper Meta

The "Meta" of competitive play, or why certain units are used in certain matchups. It all comes down to the relationship between races simply put is a bunch of evolving "rules" and "patterns" players came up with after hours of practice and experimenting with the game environment.

In this triangle relationship Zerg beat Protoss, Protoss beat Terran, and Terran beat Zerg.

The reason is that the weaker race in that relationship has to tech up to put up an even fight.

## Mirror matchups
Mirror matchups are decided on two basic principles:

1. Who has a higher tech
2. Who has more resources

The weaker race in a matchup is forced to play defensively and tech up to those higher tech units in order to survive, the stronger race usually start with all the initiative and map control.


# Proper Micro
What is micro?  Micro is a way to turn concentration and good hand-eye coordination into practical gains.  With micro, you can easily kill 16 marine/med with 24 lings while losing only 7 lings yourself, instead of losing them all and killing 3 marines.

Micro is the basis of all tactics.  Micro is the basis of all harassment.  Micro is one of the best ways to improve cost-time efficiency.  Micro is the art of individually controlling small (or large) groups of units into positions that would give you maximum advantage.  Another part of micro is knowing what these best positions are. 

## Flanking

Flanking is a tactic that any unit can use. It is the art of surrounding your enemy to maximize the aggregate rate of attack. 

In melee vs melee battles, where you have many more units than your opponent, what you must do is move-click your units past and behind enemy units, and then collapse the formation, having all units engage the enemy at the same time.  This prevents your opponent from trying to use terrain or the dumb AI against you, by only allowing you to attack with as many units as he has, at one time.  If you have many less units than your opponent, this is exactly what you must do: try to find terrain on which your opponent can not run past your formation.  This way, even though your opponent has more units, not all of them can attack at the same time.   In battles where both you and your opponent have about the same size army, use flanking to make sure that your army has the outside arc of the battle.  The outside arc is the slightly longer one, and therefore can support a greater aggregate attack rate.

In melee vs ranged battles, move-click half your army around 1 side of the enemy, and the other half around the other side.  After your melee units have surrounded the enemy, break formation and collapse on the enemy by attack-clicking nearby ground.  Alternatively, you could flank first by setting up your army into 4 groups, each on a different side of the enemy army.  Once this formation is set up, collapse it onto the enemy.  Remember, these groups must attack at the very same time for maximum effectiveness. 

## Spreading the damage

You should be aware that if an army is killed one unit at a time, the army dies faster than if you spread the damage across the entire army.  Why not take advantage of this fact by not allowing the enemy to concentrate his attacks?  For example, in zealots vs zergling battles, you must pull the hurt zealots to the back of your army, so that they are no longer being hurt.  Then, you can tell them to attack, and they will be dispensing damage without being dealt any damage (other zealots are taking the damage).  An added benefit of this micro is that it costs the enemy unit’s time, since it takes a small amount of time to acquire a new target.  An added cost of doing this is that your zeal may get stuck, and get hurt without attacking.

In range vs melee battles, especially, this tactic can greatly increase your overall effectiveness.  You can even preemptively micro back ranged units, so that the enemy melee unit does not even get to attack.

## Concentrated fire
As previously discussed, killing an army one unit at a time is much more effective than letting the damage spread over all the units in that army.  The most effective way to kill an army one unit at a time (besides using luring tactics, as discussed in the harassment section) is to shift-attack-click and add a few units to the queue.  Just select a group of hydra, for example, and shift-attack-click about 6 mutes.  This way, the hydra will kill the mutes sequentially, instead of attacking random mutes and allowing the damage to spread.  In fact, this micro is absolutely essential when going hydra vs mute.  It is just as essential to be able to cancel the queue, by telling the hydra to attack ground, when you see that the mutes are running.  This way, you avoid a potential disaster, with a group of hydra running after mutes while lings eat them alive.

# The Power of Information
What good is knowing the perfect counter to a zerg that goes 1 base mutas, if the zerg doesn't go mutas?  Moreover, what good is knowing the perfect counter to every zerg strat if you do not know which strat the zerg is doing?  Absolutely nothing, unless, of course, you find out which strat the zerg is doing.  However, you can scout a zerg going 2 hatch (in base) gas pool, and see that is obviously teching, but after your scout dies, you have no more info.  For all you know, the zerg could cancel his gas or lair and expand. What use is countering zerg tech if the zerg doesn't tech?

The point of all this, you may think, is the constant need to scout.  That is definitely a point to make; however, this also demonstrate how you can use misinformation to your advantage.

One of the benefits of zerg is that they are good at countering misinformation.  Zerg have the cheapest and best scouts (25 mineral, half larva in production).  Overlords are extremely useful in providing early recon, although not as useful vs terran.  A overlord can allow you to know what initial style your opponent is playing, and most times, even terran.  Even if the threat of ranged units forces you to pull back, you can still use the overlord over a cliff for recon.  Knowing your opponent's initial style as well as when your opponent leaves his base is a tremendous advantage.  Also, given the benefit of zerg's slight idle-immunity, zerg can easily create a large army on demand.  In other words, zerg does not have to always be prepared; zerg can relax a tiny bit and go more economy than a protoss or terran can.  The small advantage of being able to have a very nonlinear relationship between economy and army translates into a continuously compounding economic gain that give zerg an even larger advantage.

Therefore, zerg have a great advantage over the other races early game.  Zerg can do almost whatever they want, and the enemy will be none the wiser.  Of course, the above statement is ruled by the condition of having a group of speedlings successfully microed to kill every scout, except for the very first one.  That first terran/toss scout must be destroyed before you can begin to use misinformation against your opponent. 

Once the initial scout is destroyed, zerg can begin to put uncertainty into the protoss and terran minds.  Perhaps the very first piece of misinformation you can show is even before the initial scout dies.  You can make a gas chamber.  This will make your opponent believe that you are teching.  However, you can easily take workers off your gas as soon as the enemy’s scout is dead.  If you are very lucky, you can kill the scout before the gas chamber finishes, and thereby cancel the chamber, or simply not use it at all.  From here, you can expand.  The benefit of exposing is, of course, offset by the cost of building gas when you don’t plan to use it.  However, nothing is free; misinformation costs money too.

# Opposing Force
It is almost as helpful to know your opponent as it is to be good at the game.

Many players will often have their own predictable strats, changes in strats, and counters.  This is information that you can use against them.  For example, if you know that in my first game ZvT vs a random person, I always begins with a burrowed speedling strat, you can use that knowledge against me by making more bats than you would otherwise in your rush.  That way, you effectively counter my strat without scouting much at all.  If I live through the attack, I will most likely be at a disadvantage the rest of the game, because I lost a lot of units as well as opportunity (e.g., to expand instead of go gas, or use the gas for a lair). 

In this way, however, you can use predictability to your advantage.  Suppose you practiced the same strat over and over, in preparation for a tournament.  Try to make it fairly known what you are practicing for.  In my case, since most people assume I will not rush, I could easily rush in a tournament against someone that I KNOW will take advantage of the fact that I never rush, and win.

Many other players are also predictable.  It also helps to know exactly what changes in strat your opponent makes in game.  For example, suppose you know that your opponent will definitely try to lurk drop you if you expand fairly early.  Knowing this, you can skip out on units not needed to beat a drop and just prepare for the drop (sometimes as easy as making two wraiths to prevent him from scouting that you are preparing... because if he knows you are preparing he will simply expand and forego the drop). 

Not only does knowing how your opponent's strat in game help, but knowing how he changes his strategy across games also helps.  In a tournament 3th game series where you won the first game, you can be fairly certain that he would do some sort of rush in an attempt to even the score early.  Therefore, all you have to do is prepare for a rush, and you will probably win the game.  The only way you can lose the game is to prepare for a rush that does not come, but even that is not such a big problem.  Alternatively, you can scout him with a peon on the 2nd game to determine his strat, and prepare accordingly.  Early scouting in the 2nd game is usually more important than scouting in the 1st game because people are more likely to rush in the 2nd game. Always use that fact on your advantage.

However, you can also take advantage of that fact by knowing in a 3th game series vs me where I won the 1st game that I will definitely prepare for rush and therefore power a little more than you would have otherwise, putting yourself in at a very slight advantage.  However, since all advantages grow over time, a slight advantage early game can lead to a large advantage late game.

# Footnotes

Example of footnote^[A footnote example]. Lorem ipsum dolor sit amet, consectetur
adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim
id est laborum.

# Cites

Zotero + Better BibTex. All cites are on the file bibliography.bib. This is
a cite[@djangoproject_models_2016].

# Conclusion

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,
no sea takimata sanctus est Lorem ipsum dolor sit amet.

# References

