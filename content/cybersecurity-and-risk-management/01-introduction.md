---
title: 01 - Security and Risks
tags: []
draft: true
date: 2025-09-29
---
# Security in general

Security is based on understanding the risks of an environment and ponderate which are worth being mitigated and which aren't. This is because interacting with computers and other parties inherently assumes that you have **trust** towards that device. For example, you trust that the builder of the motherboard used the right components and that it is not acting maliciously, you trust other pcs in your network, etc.

> [!info] Trust
> Trust is a central concept in cybersecurity, and it can be described as:
> _The willing of an actor to be vulnerable to another party_

Trust is usually based on some security checks, like:
* Identification
* Authentication
* Authorization

The trust mechanisms in human beings are almost all of the times the first entrypoint for an attacker, as they can be hijacked much more easily than those of machines. The general problem is that, often, cybersecurity principles are _counter intuitive_, meaning that people often don't follow them.

> [!info] Example
> An example is the use of passwords, which, as the word suggests, should be _words_. However, from a security perspective, a password is safer if it is not easy to remember and is made of a random sequence of characterz.

The techniques to make a system safer are usually:
* Prevention
* Detection

Most often security mechanisms add an extra layer of complexity before completing an action, to prevent humans from acting too impulsively (an example might be the security checks at an airport).


# Risk management

Humans are exposed to risks basically at every time. Risk always stands when an individual tries to achieve a goal, as we are exposed to _threats_. However, some threats are relevant, while others are considered too improbable to be cared about.

For example: when crossing a road a major threat we might be exposed to would be being hit by a car, so it makes sense to worry about it by checking before crossing. However, we consider very improbable that a meteorite might hit us as we cross the road, so we don't check for it. This is because humans rank threats based on the _probability_ or _likelihood_ of them happening.

The other quantity that humans use to _quantify_ risks is the potential _impact_ that the event would have if it actually were to happen.

We take defenses to avoid preventable and highly impacting risks: checking the road before crossing is one example. However, the risk is almost never zero, unless we avoid taking the action entirely, but this is hardly ever possible (in this case, we would have to never walk or cross any road). 

Of course, defense measures require an actor to take some trade-off: we might walk with an helmet on out head when we walk in town to prevent being hit flower pot, but that would probably be heavily damaging to our reputation, which is an _intangible asset_, but still exists.

ISO (the international organization which emits official standards in various engineering sectors) defines a risk as: 

> [!info] ISO definition on risk
> Effect of uncertainty on objectives, expressed in terms of risk sources, potential events, their consequences and likelihood

While NIST (which only manages cybersecurity standards) defines it as:

> [!info] NIST definition on risk
> A measure of the extent to which an entity is threatened by a potential circumstance or event, and is a function of the adverse impacts that would arise if the circumstance or event occurs, and the likelihood of occurrence

