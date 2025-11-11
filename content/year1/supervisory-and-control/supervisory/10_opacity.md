---
title: 10 - Opacity in DES
draft:
---
# Opacity

Opacity, in a distributed event system, is the capability of hiding some kind of information about the system. In particular, considering a DES as a DFA, the "attacker" is assumed to:

* Know the structure of the DFA
* Partially observe the behavior of the system (a subset $E_I$ of events)

The secret is a subset of states, or a language. A system is "_opaque_" if the intruder can never infer the secret starting from these assumptions.

Opacity is either for states (we call these "**state-based opacity**") or for languages ("**language-based opacity**").

## State-based opacities

### Current state opacity

The goal of current-state opacity is to prevent an intruder from knowing whether or not the current state the DFA is at is _in the secret_. Formally:

> [!info] Current-state opacity
> 
> Given a projection $P_{E_I} : E^* \to E_I^*$, a DFA $G$, a secret $S \subseteq X$ and a set $E_I$ of observable events (by the intruder), the system is _current-state opaque_ (CSO) with respect to $S$ and $E_I$ if:
> 
> $$
> \forall \sigma \in L(G) \mid \delta(x_0, x) \in S, \exists \sigma' \in L(G) : P_{E_I}(\sigma') = P_{E_I}(\sigma) \land \delta(x_0, \sigma') \not\in S
> $$

This can be read as: for all evolution leading to a secret state, there is always another evolution that produces the same observation, but leads to a _non secret case_.

Consider this example with $S = \{3,5\}, E_I = \{b,c\}$:

![](https://i.imgur.com/HrXrMEb.png)

We have three different scenarios from the intruder:

* Observing nothing: $x \in \{0,1\}$
* Observing $b$: $x \in \{2,4,5\}$
* Observing $bc$: $x \in \{3,6\}$

Since in $b$ and $bc$ we might be observing other states outside of the secret ones, the DFA is CSO w.r.t $S$ and $E_I$.

### Initial state opacity

Now we assume that the intruder is able to read the system at any time, so we want to know if it is also able to infer the _initial state_ from which the current observation was generated.

Given $x \in X$, the language generated from $x$ is:

$$
L(G,x) = \{\sigma \in E^* \mid \delta(x, \sigma)!\}
$$

If we have a subset of states $Y \subseteq X$, the generated language from $Y$ is:

$$
L(G,Y) = \bigcup_{x \in Y} L(G,x)
$$

We can now define initial-state opacity like this:

> [!info] Initial-state opacity
> 
> Given a DFA $G$, a secret $S \subseteq X$ and a set $E_I$ of observable events by the intruder, the system is _initial-state opaque_ (ISO) w.r.t. $S$ and $E_I$ if:
> 
> $$
> \forall \sigma \in L(G,S), \exists \sigma' \in L(G,X \setminus S) : P_{E_I}(\sigma') = P_{E_I}(\sigma)
> $$

This can be read as: for all evolution generated from a secret state, there is always at least a non-secret state from which the same observation can be generated.

As an example, consider the following $G$ with $S = \{0,2\}, E_I = \{b,c\}$:

![](https://i.imgur.com/VFfA9Kr.png)

We might have:

* No observations: the initial state $x$ could be one of $\{0,1,2,3,4,5,6\}$ (all of them)
* Observing $b$: $x_0$ might be either $0$ or $1$
* Observing $c$: $x_0$ might be either $2$, $4$ or $5$
* Observing $bc$: $x_0$ might be either $0$ or $1$.

Since, from all observations, there are multiple possibilities for the initial state and non of these consists of all secret states, then the DFA is ISO w.r.t. $S$ and $E_I$.

## Language opacity

Our goal here is to prevent the observer from being sure if the observed sequence is in the secret. Formally:

> [!info] Language opacity
> 
> Given a DFA $G$, a secret $S \subseteq L(G)$ and a set $E_I$ of observable events by the intruder, the system is _language opaque_ (LO) w.r.t. $S$ and $E_I$ if:
> 
> $$
> \forall \sigma \in S, \exists \sigma' \in L(G) \setminus S : P_{E_I}(\sigma') = P_{E_I}(\sigma)
> $$

This can be read as: for any secret string that $G$ might generate, there is always at least another non-secret string that $G$ might generate by producing the same observation.

As an example, consider this DFA with $S = \{abc\}, E_I=\{b,c\}$:

![](https://i.imgur.com/03hMtYl.png)

We have:

* If the intruder observes nothing: the generated sequence could either be $\epsilon$ or $a$
* If the intruder observes $b$: the generated sequence could either be $b$, $ba$ or $ab$
* If the intruder observes $bc$: the generated sequence could either be $bac$ or $abc$

This means that $G$ is LO w.r.t. $S$ and $E_I$.

## Opacity verification

Given a DFA $G$, we might want to check whether it has any opacity property.

### Current-state opacity

To help us do so, we introduce the notion of states consistent with a word $w$.

> [!info] States consistent with $w$
> 
> Given an observation $w \in E_I^*$, we define:
> 
> $$
> C(w) = \{x \in X \mid \exists \sigma \in E^* : \delta(x_0, \sigma) = x, P_{E_I}(\sigma) = w\}
> $$
> 
> as the states consistent with $w$.

These are all the states where the DFA could be at the time that the word $w$ is observed.

We can now outline the necessary and sufficient condition for a DFA to be CSO:

> [!info] CSO verification
> 
> A DFA $G$ is current-state opaque w.r.t. $S$ and $E_I$ if and only if:
> 
> $$
> \forall w \in E_I^*, C(w) \subset S
> $$

This means that the consistent states of all observable words of the DFA must be a subset of all the states (i.e.: all words must be generated with at least one unobservable event).

In order to perform this verification, we need to compute $C(w)$ for all $w \in P_{E_I}(L(G))$. To do so, we construct an _observer_ (which is the equivalent DFA of an NFA).

In this case, considering a plant $G$, we build an observer $G_o = (X_o, E_I, \delta_o, x_{0_o})$ by:

1. Replacing all unobservable events with $\epsilon$ from $G$
2. Constructing the equivalend DFA $G_o$ of the obtained new $G$ in step 1.

By doing so, each state $y \in X_o$ of $G_o$ is $y \subseteq X$. Given an observation $w \in E_o^*$, we have that:

$$
\delta(x_{0_o},w) = C(w)
$$
meaning that the production of $w$ starting from the initial state of $G_o$ is equal to the set of states consistent with $w$.

As an example, taking the automaton from the previous example, we first substitute unobservable $a$'s with $\epsilon$ to obtain an NFA, and then we translate to a DFA:

![](https://i.imgur.com/YwpjDxH.png)

> [!info] CSO verification algorithm
> 
> To verify if the DFA $G$ is CSO, we:
> 
> 1. Build the observer $G_o$ w.r.t. $E_I$
> 2. If all states $y \in X_o$ do not constitute the secret ($y \subset S$), then the system is CSO, otherwise it isn't.

The worst case complexity is $O(2^n)$, with $n$ being the number of states of $G$.

Here, for example, none of the states of the observer is a subset of $S = \{3,5\}$, and thus $G$ is CSO w.r.t. $S$ and $E_I$.

![](https://i.imgur.com/gzZUrOu.png)

### Initial-state opacity

To verify initial-state opacity, we first need to define the set of states that generate a word $w$ formally:

> [!info] Set of states generating $w$
> 
> Given an observation $w \in P_{E_I}(L(G,X))$, we define the set of states generating $w$ as:
> 
> $$
> \mathcal{L}(w) = \{x \in X \mid \exists \sigma \in L(G,X) : \delta(x, \sigma)!, P_{E_I}(\sigma) = w\}
> $$

For example, in this DFA $\mathcal{L}(b) = \{0,1\}$:

![](https://i.imgur.com/WN5qjRk.png)

Now we can define a proof for initial-state opaqueness:

> [!info] ISO verification
> 
> A DFA $G$ is initial-state opaque w.r.t. $S$ and $E_I$ if and only if:
> 
> $$
> \forall w \in E_I^*, \mathcal{L}(w) \not\subseteq S
> $$ 

Meaning that the sets of generating states for all observable words must not be contained in $S$. To compute all $\mathcal{L}$ of the words of $G$, we define a reverse automaton $G_r = (X,E,\delta_r)$, obtained by reversing all arcs in G:

![](https://i.imgur.com/4vRrzY3.png)

From this, we can build an initial state estimator $G_e$ of $G$ as the observer of a reverse automaton, with the initial state being $X$. Given an observation $w \in E_o^*$:

$$
\delta_e(x_{e_0}, w) = \mathcal{L}(w^r)
$$

where $w^r$ is the reverse of $w$.

![](https://i.imgur.com/OYV5u43.png)

> [!info] ISO verification algorithm
> 
> To verify if the DFA $G$ is ISO, we:
> 
> 1. Build the reverse automaton $G_r$ of $G$
> 2. Build the estimator $G_e$ (the observer of $G_r$)
> 3. If all states $y \in X_e$ do not constitute the secret ($y \not\subseteq S$), then the system is ISO, otherwise it isn't.

The worst-case complexity is still $O(2^n)$, where $n$ is the number of states of $G$.

Here, for example, since none of the state of the estimator is a subset of $S = \{0,2\}$, then $G$ is ISO w.r.t. $S$ and $E_I$.

![](https://i.imgur.com/tT3blzM.png)

## CSO Enforcement

Now that we have defined current-state opacity, we might want to build a maximally permissive supervisor $Sup$ for a DFA $G$ that makes the controlled system $Sup / G$ CSO w.r.t. $S$ and $E_I$.

We assume that:

1. The supervisor can observe all events
2. The supervisor knows $E_I$ (the events observable by the intruder)
3. The intruder does not know of the supervisor

In this DFA, for example, sequences $abc$ and $bac$ leak the secret. This means that the supervisor must prevent them from being produced.

![](https://i.imgur.com/CtO5Ecs.png)

To do this, we define an augmented I-observer (AIO):

> [!info] Augmented I-observer
> 
> The AIO of a DFA $G$ is the concurrent composition of $G$ and its observer: $G_a = G \lvert \rvert G_o = (Q,E,\delta_a, q_o)$, where $Q \subseteq X \times X_o$ and $q_o = (x_0, x_{o_0})$.

The AIO has these properties:

* $L(G_a) = L(G)$
* Given $\sigma \in L(G_a)$ and $\delta_a(q_0, \sigma) = (x,C_w)$, then $x = \delta(x_0, \sigma)$ and $C_w = C(P_{E_I}(\sigma))$.

![](https://i.imgur.com/G5BvOQs.png)

### Forbidden states

> [!info] Forbidden states in an AIO
> We define $F$ as the set of forbidden states in an AIO $G_a$
> 
> $$
> F = \{q = (x,C_w) \in Q \mid C_w \subseteq S\}
> $$
> 
> for any $\sigma \in L(G_a)$ such that $\delta_a(q_0, \sigma) \in F \to C(P_{E_I}(\sigma)) \subseteq S$

Meaning that the sequence $\sigma$ that leads to a state in $F$ corresponds to a sequence that will leak the secret in $G$.

We can now define an algorithm to design a supervisor:

1. Construct the observer for $G$, $G_o$, w.r.t. $E_I$
2. Compute the AIO $G_a$ as $G_a = G \lvert \rvert G_o$
3. Compute the set of forbidden states in $G_a$, $F = \{q = (x,C_w) \in Q \mid C_w \subseteq S\}$
4. Design $Sup$ of $G_a$ for state specification $F$.

![](https://i.imgur.com/CmgRalz.png)

![](https://i.imgur.com/52s6CNn.png)
