---
title: 01 - Introduction
draft: true
---
# Control

## System

A system is a set of things working together as parts of a mechanism or an interconnecting network. It is composed by a number of entities, separated from the environment by a boundary. It reacts to inputs and produces outputs.

Systems typically have two properties:
* **Robustness**: which is the capability of the system to stay healthy in perturbed conditions.
* **Resilience**: which is the capacity of recovering its behavior and performances after external stresses.

Usually we represent systems with models of the time domain, using _differential_ and _difference_ equations. Based on these properties, we can define a couple of system prototypes:

**Open-loop** systems have very poor robustness and resilience. They are composed of two subsystems $E_1$ and $E_2$, with:

* $E_1$ taking an input $u$ and outputting $w$
* $E_2$ taking the input both from $w$ and an external $d$. As a result, the output $y$ is very easily influenced.

We can fix these problems by translating to a **closed-loop** system: this is basically identical to the previous one, but in addition:
* The output $y$ is passed back to $E_1$
* $E_1$ generates $w$ based on $u$ and $y$, so that the input taken by $E_2$ is less influenced by $d$. This is simply a _feedback_ mechanism.

## Stability

A system is _stable_ if it is able to stay in a point near (or, at least, easily come back) to a point of equilibrium after a perturbation. In this definition, we say that:

* An _equilibrium point_ is a state of the system where it does not change in the absence of inputs
* A _working point_ is a state and output that does not change in the presence of _constant inputs_.

So we say that an _equilibrium point_ $x_{eq}$ is _asymptotically stable_ if for all $R \gt 0$, there exists an $r(R) \ge 0$ so that

$$

$$