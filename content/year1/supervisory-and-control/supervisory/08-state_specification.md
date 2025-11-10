---
title: 08 - State Specifications
draft:
---
# State specification

Building a "_state specification_" consists in describing the desired behavior of a controlled system. This might mean that we could have a plant $G$ capable of entering some states, but we would like to use a supervisor $S$ to restrict the set of possible events to a limited series of so-called "_legal states_".

> [!note] State specification
> 
> Given a plant with a state space $X$, a state specification consists in set $L \subseteq X$ of legal states:
> 
> ![](https://i.imgur.com/TlWHzJ0.png)
> 
> States in $F = X \textbackslash L$ are called "_forbidden states_".


We can apply the same definition for a language:

> [!info] Language specification
> 
> Given a plant with language $L(G) \subseteq E^*$, a _language specification_ is a language $K \subseteq E^*$ of _legal words_.
> 
> ![](https://i.imgur.com/kkivRnE.png)
> 
> Here, strings in $L^k = L(G) \cap K$ are called _allowed_ (generated and legal), while strings in $F^k = L(G) \textbackslash K$ are called _forbidden_ (generated, but illegal).
> 


## Control problem for state specifications

Outside of legal and forbidden states, we can introduce the notion of **weakly forbidden states**. These are all the states of a plant which are legal, but from which a _forbidden_ state can be reached by a sequence consisting of only _uncontrollable_ events. This means that once a weakly forbidden state is reached, the supervisor has no capability of stopping the plant from reaching a forbidden state.

> [!info] Weakly forbidden state
> 
> In a plant $G$ having a set of legal states $L$ and a set of forbidden states $F$, a _weakly forbidden state_ is the set of state $F_{weak}$:
> 
> $$
> F_{weak} = \{x \in L \mid (\exists e_{uc} \in E^*_{uc}) \delta^*(x, w_{uc} = x' \in F\}
> $$
> 
> A supervisor that only prevents _forbidden_ and _weakly forbidden_ states from being reached is called **maximally permissive**.

### Design

We can design a maximally permissive supervisor $S$ for a plant $G$ by following these steps:

1. Compute the set of forbidden and weakly forbidden states of $G$: $F \cup F_{weak}$.
2. If the initial state is forbidden/weakly forbidden, than _stop_, because there is no solution to the problem.
3. Trim $G$ by removing all forbidden/weakly forbidden states and their input output arcs
4. The resulting structure is $S$ and $S/G$.
5. Optional - trim the resulting automata to remove unreachable states.

The resulting automata is thus:

* Admissible, meaning it only disables controllable events
* Correct, meaning no occurrence leads to a forbidden state
* Maximally permissive
* Coinciding with the close loop $S/G$.

## Control problem for language specifications

We can extend the definition of weakly forbidden states to languages by introducing _weakly forbidden words_. These are all allowed words $w$ that, once generated, provoke a firing of a series of uncontrollable events that eventually produce a forbidden word $w' = ww_{uc} \in F^k$.

> [!info] Weakly forbidden word
> 
> In a plant $G$ having a prefix closed language specification $K$ and a set of forbidden words $F^k$, a _weakly forbidden state_ is the set of state $F^K_{weak}$:
> 
> $$
> F_{weak}^k = \{w' \in L^k \mid (\exists w_{uc} \in E^*_{uc}) w = w'w_{uc} \in F^K\}
> $$
> 
> A supervisor that only prevents _forbidden_ and _weakly forbidden_ words from being reached is called **maximally permissive**.

## Specification Automaton

> [!info] Specification Automaton
> 
> Given a language specification $K \subseteq E^*$, the corresponding specification automaton $H = (X', E, \delta', x_0', X_m')$ is such that this DFA accepts $K$ and all its generated prefixes: $L_m(H) = K \land L(H) = \bar{K}$.

When $K$ is prefix closed, we have $L_m(H) = L(H) = K$, thus $X'_m=X'$ (all its states are final).

## Admissible DFA

Given a plant $G$, an automaton $H$ is admissible for $G$ if, when used as a supervisor, it always produces admissible control inputs.

We can check if $H$ is admissible for $G$ by constructing $F = G \mid \mid H$ generating the set of allowed words $L^K$. We do this by constructing each state $(x, x')$ where $x \in X$ is a state of $G$ and $x' \in X'$ is a state of $H$. States can thus be:

* Uncontrollable, if there is a $e \in E_{uc}$ such that the uncontrollable event $e$ is active in $G$ at state $x$, but not active in $F$ at state $(x, x')$: $e \in A_G(x) \land e \not\in A_F((x,x'))$.
	* We have this when we generate an allowed word $w'$ but firing an uncontrollable event that generates a forbidden word
* Weakly controllable, if there is a word (possibly empty) $w \in E_{uc}^*$ of uncontrollable events $w$ that in $F$ from the state $(x,x')$ yields an uncontrollable state.
	* We have this when we generate an allowed word $w'$ but firing a series of uncontrollable events that generate a forbidden word
	* Of course, all words leading to a weakly uncontrollable state are weakly forbidden

We can thus determine two sets:
* $U$ as the set of uncontrollable states
* $U_{weak}$ as the set of weakly uncontrollable states
	* We have $U \subseteq U_{weak}$.

Finally:

> [!info] Admissible automaton
> 
> An automaton $H$ is admissible to a plant $G$ if $F = G \mid \mid H$ has no uncontrollable states.

### Supervisory design for language specification

Since an admissible supervisor $H$ is also the desired one, we need an algorithm to construct a supervisor for a plant $G$. This algorithm will take a plant $G$ as input and a language specification $K \subseteq E^*$ described by $H$, and will produce as output a maximally permissive supervisor $S$. These are the steps to do it

1. Build the composed automaton $F = G \mid \mid H$
2. Compute the set of weakly uncontrolled states of $F$ $U_{weak}$.
3. If the automaton has no weakly uncontrolled states, then stop, since $S = H$ is admissible and $S/G = F$.
4. If the initial state is uncontrollable, then stop, as there is no solution
5. Trim $F$ by removing all weakly uncontrollable states, with their input/output arcs
6. The remaining structure is $S$ and $S/G$.
7. Optional - trim to remove unreachable states.

This automaton is also:

* Admissible
* Correct
* Maximally permissive

> [!info] :D
> 
> ho tante noci di cocco splendide, ti tiri ti ti, in fila per tre per tre per treeee.
> Grandi, grosse, anche più grandi di teeeee!!!!


