title: Brood War AI Tournament RFC 1
date: 2019-10-06
description: We are excited to announce the first draft for the Brood War AI competition We've been working on. For those interested, it also listed some of our design rationale, which may be helpful if you are looking to create or extend an existing bot and make it your own using the Linux environment.

Current StarCraft: Brood War AI tournaments claim to be using Windows because that is the OS that the game was written for 20 years ago, they want to keep things as close to the original game environment as possible.

Organizers argue that anything you write from Linux should also compile and run inside an old version of the Windows 32-bit environment.

The purpose of this AI competition is offer a stable Linux environment with access to modern multicore machines and GPU, supporting anything that you could package inside a Linux container and all existing BWAPI wrappers outside the current Java and C++ options.

The only way to compete right now with a bot that is built on to run on a Linux environment using all this available data analytics and deep learning framework tools that exist today is creating a new competition, because right now, the current state of affairs don't let you do that, you required to follow a tournament rule that current tournaments require bots to run as 32-bit Windows application executable or DLL, coded using only C++ or Java. This from our point of view limits you.

We want a competition that run inside a standard Linux 64-bit environment that let developers use whatever language they want, even LISP interpreters, the only requirement that you have is a working BWAPI wrapper so you can prove that you can through that build a bot and run it no matter how simple it is.

If you are thinking on start with a 4pool like we have in other competitions using Linux we don't see why there are more dificulties for your 4pool if you build on Linux that if you use Visual Basic with C++ or Java.

We are not asking people to stop using what works, what we propose is that if someone out there want to use Linux to code the bot he or she have now the possibility to do so at the same level as we can use if we want Scala because the JVM is supported or the C++ language. 

If you want to use Linux now you have the possibility to do so, you are no more conditioned by how a Java manager software works!
