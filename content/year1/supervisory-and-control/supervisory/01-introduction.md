---
title: 01 - Introduction on Systems and Formal Languages
tags: []
draft: false
date: 2025-09-29
---
# Dynamical Systems and Mathematical Models

A dynamical system changes with time following some set properties and a mathematical model that describes its evolution. They are different from neural-network as the latter are data-driven, instead of being dependent on a formula.

## Time Driven Systems

### Continuous Time-Driven System

> [!info] Time-Driven Systems
> 
> On a CTDS, change depends only on _time_. These systems can be described by differential equations, where the independent variable is time $t$. If we have $t \in \mathbb{R}$, then the system is called _continuous-time time-driven_.
>
>$$
>\dot{x}(t) = f(x(t), u(t))
>$$
>with $\dot{x}(t) \in \mathbb{R}^n$ being the state, and $u(t) \in \mathbb{R}^n$ being the input at time $t$.

An example is a _tank_:

$$
\frac{d}{dt}V(t) = q_1(t) - q_2(t)
$$

with $v$ being the volume as the **state**, and $q_1,q_2$ the in/out flow of the pump.
In this case, the state is only dependent on the time variable $t$, and is calculated as the difference between the _input_ flow at $t$ and the _output_ flow at the same time.

### Discrete-time Time-Driven System

> [!info] Discrete-time Time Driven Systems
> 
> Same as CTDS, but the variable $t$ is _discrete_ $t \in Z$:
>
>$$
>x(k + 1) = f(x(k), u(k))
>$$

These are described by a system of difference equations.

## Event driven Systems

> [!info] Event-driven Systems
> 
> In event-driven systems, the space of the states is _discrete_. These systems do not take time into consideration, but only the _states_ and the _transitions_.

An example is a robot which has three states: 

* _idle_
* _loading_
* _error_

These states are purely logical, not numerical, and the events that drive the states are not dependent on time. For example, they might be:

* $a$: the robot takes a part
* $b$: part loaded correctly
* $c$: part incorrectly positioned
* $d$: part repositioned

![](https://i.imgur.com/blBeWog.png){width=50%}

In this case, we can distinguish between:

* Logical discrete-event systems: where the model _does not_ specify the timing of event occurrences
* Timed discrete-event systems: where the timing structure is also specified. In this case, if the timing is known a priori the model is called **non-stochastic**, otherwise it is **stochastic**.

### Relation between TDS and EDS

The two systems are not intrinsically distinct: a system might change from an event one to a time one.
For example: taking the tank case from before, we want to guarantee that a level of the liquid stays between the interval $[h_{min}, h_{max}]$. We can use a supervisor to control the pumps so that it works like this:

* The input of $q_1$ is blocked when $h_{max}$ is reached
* The output of $q_2$ is blocked when $h_{min}$ is reached

This system is defined by the following FDA:

![](https://i.imgur.com/6H94gOa.png)

## Hybrid system

An hybrid system is a system that is both time-driven and event-driven.

An example might be a thermostat. We want to keep the temperature $x(t)$ between $T_{ON} = 20°C$ and $T_{OFF} = 22°C$, with a heat pump. The temperature of the environment might be $T_E < T_{ON}$, meaning that the temperature decreases spontaneously when the pump is off.
This means that we have a **differential equation** to describe the variation of the temperature when the pump is on:

$$
x = -k[x-T_e] + q
$$

and another one for when it is off:

$$
x = -k[x-T_e]
$$

The change between these two states is defined by the events of the temperature being above or under $22$°C:

![](https://i.imgur.com/2f1Jlcu.png)

Because this system is both time-driven and event-driven, it is called _hybrid_.

