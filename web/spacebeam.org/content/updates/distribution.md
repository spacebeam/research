title: Distributed memory 
date: 2019-12-28
description: The auto-associator learning paradigm, in which the goal is to store specific patterns for future retrieval. Notes from the PDP.17

## Benefits of Distribution
Connection information distribution allows us to instruct parallel processing structures from outside the network, making their behavior contingent on instructions originating elsewhere in the network. This means, for example, that the way a network responds to a particular input can be made contingent on the state of some other network in the system, thereby greatly increasing the flexibility of parallel processing mechanisms.

Perhaps the most general way of stating the benefit of connection information distribution is to note that it is analogous, in a way, to the invention of the stored program. The use of centrally stored connection information to program local processing structures is analogous. This allows the very same processing structures to be programmed to perform a very wide range of different tasks.

## A Distributed Model Of Memory
The auto-associator models are a class of related models that share the auto-associative architecture. That is, they all consist of a single set of units that are completely interconnected, auto-associators are limited by the fact thatthey can only train connections between units whose target activations can be specified from outside the network.

In spite of this limitation, auto-associators have several interesting properties. They can learn to do pattern completion and to restore distorted versions of learned patterns to their original form. They can learn to extract the prototype of a set of patterns from distorted exemplars presented during training.

In all versions of the auto-associator input patterns consist of vectors specifying positive and negative inputs to the
 units from outside the network, based on these external inputs and on the connections they receive from other units inside the network.

Patterns that are scaled by a network are called eigenvectors, eigenvector simply means "same vector." The magnitude of the eigenvector, as it is processed by the network, is called its eigenvalue.

The view that human memory is physiologically distributed within circumscribed regions of the brain seems to be quite a reasonable and plausible assumption.

But given the rather loose coupling between a psychological or cognitive theory of physiological implementation, we can ask, does the notion of distributed memory have anything to offer us in terms of an understanding of human cognition?

## General Properties
Our model shares a number of basic assumptions about the nature of the processing and memory system with most other distributed models.

In particular, the processing system is assumed to consist of a highly interconnected network of units that take on activation values and communicate with other units by sending signals modulated by weights associated with the connections between the units. Sometimes we may think of the units as corresponding to particular representational primitives, but they need not. For example, even what we might consider to be a primitive feature of something, like having a particular color, might be a pattern of activation over a collection of units.

### Connection information distribution 
We argue that connection information distribution provides a way of overcoming some apparent limitations of parallel distributed processing mechanisms. Using connection information distribution, we can create local copies of relevant portions of the contents of a central knowledge store. These local copies then server as the basis for interactive processing among the conceptual entities they program local hardware units to represent.

With this mechanism, models can now be said to be able to create multiple instantiations of the same schema, bound appropriately to the correct local variables, subject to just the kinds of binding errors humans seem to make, we have not really done anything more than show how existing tools in the arsenal of parallel distributed processing mechanisms can be used to create local copies of networks.

### Modular structure
We assume that the units are organized into modules. Each module receives inputs from other modules; the units within the module are richly interconnected with each other; and they send outputs to other modules. The state of each module represents a synthesis of the states of all the modules it receives inputs from.

Others will come from relatively more abstract modules, which themselves receive inputs from and send outputs to other modules placed at the abstract end of several different modalities. Thus, each module combines a number of different sources of information.

### Units play specific roles within patterns
A pattern of activation only counts as the same as another if the same units are involved.

## Relation to Basic Concepts in Memory
1. **State as pattern of activation**; In a distributed memory system, a mental state is a pattern of activation over the units in some subset of the modules. The patterns in the different modules capture different aspects of the content of the states in a kind of a partially overlapping fashion. Alternative mental states are simply alternative patterns of activations over the modules. Information processing is the process of evolution in time of mental states (?).

2. **Memory traces as changes in the weights**; Patterns of activation come and go, leaving traces behind when they have passed. What are the traces? They are changes in the strengths or weights of the connections between the units in the modules. Each memory trace is distributed over many different connections, and each connection participates in many different memory traces. The traces of different mental states are therefore superimposed in the same set of weights.

3. **Retrieval as reinstatement of prior pattern of activation**; Retrieval amounts to partial reinstatement of a mental state, using a cue which is a fragment of the original state. For any given module, we can see the cues as originating from outside of it. Some cues could arise ultimately from sensory input. Others would arise from the results of previous retrieval operations, feedback to the memory system under the control of a search or retrieval plan.
