---
title: 05 - Automata with I/O
date: 2025-11-05
draft:
---
# Automata with Input/Output

There are two main models of automata that receive an input and output something: the _Moore Machine_ and the _Mealy Machine_

## Moore Machine

> [!info] Definition of a Moore Machine
> 
> A Moore Machine is a 6-tuple $G_{mo}=(X,E,\Theta,\delta,\lambda,x_0)$, where:
> 
> * $X,E,\delta,x_0$ follow the same definition as the one they have in DFAs ($E$ is an "input alphabet")
> * $\Theta$ is the _output alphabet_
> * $\lambda: X \to \Theta$ is the **output function**, with $\lambda(x) \in \Theta$ being the output produced by the machine when it is in state $x$.

This machine is **deterministic**, so if we have a word $w = e_1e_2\dots e_k \in E^*$, it will correspond to the production:

$$
x_{j_0} \to^{e_1} x_{j_1} \to^{e_2} \dots x_{j_{k-1}} \to^{e_k} x_{j_k}
$$

which corresponds to this **output sequence** (each element is the output of the $\lambda$ function in state $x$):

$$
v = \lambda(x_{j_0}) \lambda(x_{j_1}) \dots \lambda(x_{j_k}) \in \Theta^*
$$

> [!help] Properties
>
> When the machine has an input sequence of $\epsilon$ (when it is _initialized_), an output $\lambda(x_0)$ is produced, meaning that the output symbol corresponding to the initial state is _always_ produced. This implies that the length of the output sequence is always one unit greater than that of the input sequence.

The graphical representation is similar to that of a DFA. However, we label each state by the value of the function for $\lambda(x)$:

![](https://i.imgur.com/QIG4Enr.png)

We have $E = \{a,b\}, \Theta = \{A,B,Y\}$

In this case, this Moore machine:

* Monitors the number of $a$: if we observe two consecutive $a$'s, then we produce $A$ (the starting state is $x_0$)
* Monitors the number of $b$: if we observe two consecutive $b$'s, then we produce $B$
* In any other case, we produce $Y$

### Comparison with DFAs

Moore machines have a **non-defined** set of final states (while DFAs do).

However, if we take the output function of a Moore machine we can classify the states of a DFA in as many classes as there are output symbols. I.e.: for the Moore machine above, we'd have the set of states with $A$ as an output symbol being $\{x_2\}$. That for the symbol $Y$ would be $\{x_1,x_3\}$, and so on.

In this sense, a Moore Machine is a generalization of a DFA, with output alphabet:

$$
\Theta=\{m,\bar{m}\}
$$

where

$$
\lambda(x) = m \text{ if } x \text{ is marked and } \lambda(x) = \bar{m} \text{ if } x \text{ is not marked}
$$

## Mealy Machine

The definition is very similar to that of a Moore Machine:

> [!info] Definition of a Mealy Machine
> 
> A Moore Machine is a 6-tuple $G_{mo}=(X,E,\Theta,\delta,\lambda,x_0)$, where:
> 
> * $X,E,\delta,x_0$ follow the same definition as the one they have in DFAs ($E$ is an "input alphabet")
> * $\Theta$ is the _output alphabet_
> * $\lambda: X \times E \to \Theta$ is the **output function**, with $\lambda(x,e) \in \Theta$ being the output produced by the machine when it is in state $x$.

In this case, the production of a word $w = e_1e_2 \dots e_k \in E^*$ corresponds to:

$$
x_{j_0} \to^{e_1} x_{j_1} \to^{e_2} \dots x_{j_{k-1}} \to^{e_k} x_{j_k}
$$

producing an output of:

$$
v = \lambda(x_{j_0}, e_1)\lambda(x_{j_1}, e_2) \dots \lambda(x_{j_{k-1}}, e_k) \in \Theta^*
$$

> [!help] Properties
>
> In contrast to Moore machines, when a Mealy machine has an input sequence of $\epsilon$ (when it is _initialized_), _no output_ is produced. This implies that the length of the output sequence is always equal to that of the input sequence.

In contrast to Moore machines, the output symbol is influenced not only by the state $x$, but also by an event $e$. This means that, to be fired, a transition necessitates of a specific event: since firing a transition equals to producing an output symbol, the graphical representation of a Mealy machine is exactly the same of that of a Moore machine, but with the addition of a label $e/\lambda(x,e)$ to denote the event required to _fire_ the transition, and the output symbol _produced_.

![](https://i.imgur.com/ZCUTssX.png)

This machine is the same as that described in the Moore example. We can note that it has a smaller number of states than its equivalence, since labeling transitions allows us to build more compact models.

The only minor difference is that if the Moore machine produces an output in the form $Yw$, with $w \in \Theta^*$, then the same input on this machine will produce only $w$ (the reason why is explained in the property above about initializing a machine).