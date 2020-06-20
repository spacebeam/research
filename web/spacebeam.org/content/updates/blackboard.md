title: The Seed Mechanism
date: 2020-06-20
description: We are now ready to move up to a complete connection information distribution mechanism containing a number of programable modules along with the structure to program them.

The seed mechanism consist of a central knowledge store, a set of programmable modules, and connections between them.

The structure is set in a way that all of the connection information that is specific to recognition
of zergs is stored in the central knowledge store.

Incoming lines from the programmable module allow information in each module to access the central knowledge,
and output lines from the central knowledge store to the programmable modules allow connection activation information
to be distributed back to the programmable modules.

The two programmable modules are *just copies* of the module. It is assumed that lower-level mechanisms, outside
of the model itself, are responsible for aligning inputs with the two modules, so that shown two units are presented,
the zergling activates appropriate programmable zergling units in the module, and the hydralisk activates
appropriate programmable hydralisk units in the right module.

In summary, the mechanism consists of 

- (a) the programmable modules
- (b) the central knowledge store
- (c) converging inputs to the central knowledge store from the programmable modules
- (d) diverging outputs from the central knowledge store back to the programmable modules

## Benefits

Connection information distribution allow us to instruct parallel processing structures from outside the network
making their behavior contingent on instructions originating elsewhere in the network.

This means, that the way a network responds to a particular input can be made contingent on the state of some other
network in the system, thereby greatly increasing the flexibility of parallel processing mechanisms.

Perhaps the most general way of stating the benefit of connection information distribution is to note that is in a way,
analogous to the invention of the stored program!

## Conclusion

Using connection information distribution, we can create local copies of relevant portions of the contents of a central
knowledge store. These copies then serve as the basis for interactive processing amount the conceptual entities they
program local hardware units to represent.

With this mechanism, parallel distributed processing models can now be said to be able to create multiple
*instantiations* of the same *schema*, bound appropriately to the correct local variables, though subject to just
the same kind of crashes and errors human programmers seem to make.

We have not really done anything more than show how existing tools in the arsenal of parallel distributed processing
mechanisms can be used to create local copies of networks.
