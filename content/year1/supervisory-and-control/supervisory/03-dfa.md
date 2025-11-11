---
title: 03 - Deterministic Finite Automaton
tags: []
draft: false
date: 2025-10-01
---
# Deterministic Finite Automaton

We use DFAs to describe _discrete event driven systems_. 

> [!info] Deterministic Finite Automaton
>
> A DFA is defined as the following 5-tuple:
>
> $$
> G = (X, E, \delta, x_0, X_m)
> $$
> 
> where:
> 
> * $X$ is the finite set of states
> * $E$ is an alphabet
> * $\delta: X \times E \rightarrow X$ is an transition function
> * $x_0 \in X$ is the initial state
> * $X_m \subseteq X$ is the subset of final states

The transition function $\delta$ is a function taking two inputs: a state $x \in X$ and an event $e \in E$, and it returns a second state. Basically, it is a function that describes which is the successive state given one and an event that triggers a transition. It is a _partial function_: not all events can happen at all states.

An automaton can be described by a graph, having one node per state, represented by a circle. The transitions are defined by arc.

\newpage

An example:

![](https://i.imgur.com/6gcwDnD.png)

Here, we have:

* Set of states: $X = \{x_0, x_1, x_2\}$
* Alphabet: $E = \{a,b,c,d\}$
* Initial state: $x_0$
* Final states: $X_m = \{x_0\}$
* The transition function can be represented by this table:

| $\delta$ | a     | b     | c     | d     |
| -------- | ----- | ----- | ----- | ----- |
| $x_0$    | $x_1$ |       |       |       |
| $x_1$    |       | $x_2$ |       | $x_0$ |
| $x_2$    |       |       | $x_2$ | $x_0$ |

This machine could describe the behavior of a machine that performs the following action:

* $a$: an operator turns on the machine
* $b$: set-up operation
* $c$: the machine processes parts
* $d$: an operator turns off the machine

\newpage

## Events

The events that trigger a state change of a DFA $G = (X, E, \delta, x_0, X_m)$ are not always possible. The set of enable events at a state $x \in X$ is expressed as the following set:

$$
A(x) = \{e \in E\ |\ \delta(x, e) \text{ is defined}\}
$$

To say that $e \in A(x)$ we can write $\delta(x, e)!$, meaning that $\delta$ is defined for the given pair. This definition implies that $A(x)$ is a subset of $E$, but can never be equal to $E$, as there are always some $e \in E$ that are not enabled, and thus do not belong to $A$. 

Since $\delta$ is a function, we cannot have multiple transitions with the same label outputting from a state $x$.

## Productions

The behavior of an automaton is given by the evolution of its states, described by their productions. 

> [!info] Productions
> 
> Given a DFA $G$, we define a production of length $k$ a sequence of states and transitions:
>
>$$
>x_{j_0} \rightarrow^{e_1} x_{j_1} \rightarrow^{e_2}\ ...\ x_{j_{k-1}} \rightarrow^{e_k} x_{j_k} 
>$$
>
>where, for all $i = 0,\ ..., k$ we have $x_{j_i} \in X$ and for all $i = 1,\ ...,k$ we have $x_{j_i} = \delta(x_{j_{i-1}, e_i})$



## Languages of DFA


> [!info] Words in a DFA
>
> Given a DFA $G$, we say that a word $w \in E^*$ is:
> 
> * generated if $\delta^*(x_0,w)!$, meaning that a production exists that generates $w$ from the initial state
> * accepted if $\delta^*(x_0,w) = x \in X_M$, meaning that a production exists that generates $w$ starting from an initial state _and_ reaching a final state

\newpage

For example, consider this automaton:

![](https://i.imgur.com/Hz1r5t8.png)

* Word $abcc$ is _generated_, since $\delta^*(x_0, abcc) = x_2$, but it is not accepted since $x_2$ is not final.
* Word $ad$ is accepted (meaning it is also generated), since $\delta^*(x_0, ad) = x_0$, _and_ $x_0$ is final.
* Word $ac$ is _not generated_ (meaning it is also not accepted), since $\delta^*(x_0 ,ac)$ is not defined.

So, one possible production for the word `ccda` can be described as:

$$
x_2 \to^{c} x_2 \to^{c} x_2 \to^{d} x_0 \to^{a} x_1
$$

The empty word $\epsilon$ can always be generated, but it is accepted only if the initial state is also final.

## Transitive and reflexive closure of $\delta$

In order to have a clear set of all productions of a DFA in a more compact way, we can define the function $\delta^*$ (which is the transitive and reflexive closure of $\delta$) as:

> [!info] Transitive and reflexive closure of $\delta$
> 
> Given a DFA $G$ we define $\delta^* : X \times E^* \to X$ such that $\delta^*(x,w) = \overline{x}$ only if there exists a production:
> 
>$$
> x \to^{e_1} x_{j_1} \to^{e_2} \dots \to^{e_k} \overline{x}
> $$

So, the transitive and reflexive closure of $\delta$ is just a functions that outputs _only the words $w_i$ that can be generated starting from $x$ and reaching $\overline{x}$_.

![](https://i.imgur.com/U7PGqvy.png)

In this case, for example, we have $\delta^*(x_0, abcc) = x_2$, because we can generate the word $abcc$ starting from $x$ and reaching the state $x_2$.

## Generated Languages

> [!info] Generated Language
> 
> Given a DFA $G$, its generated language is the set of all generated words:
> 
> $$
> L(G) = \{w \in E^*\ |\ \delta^*(x_0, w)!\} \subseteq E^*
> $$

In other words, the generated language of an automaton describes **all possible evolutions of a system**.

A _generated language_ is **always prefix closed**: $L(G) = \overline{L(G)}$. So if a word can be generated, so can all its prefixes.

> [!info] Accepted Language
>
> Given a DFA $G$, its accepted language is the set of all accepted words:
>
> $$
>L_m(G) = \{w \in E^*\ |\ \delta^*(x_0, w) \in X_m\} \subseteq L(G)
>$$

In other words, the accepted language describes the evolutions that correspond to the completion of certain tasks.

An _accepted language_ is not necessarily prefixed closed, meaning $L_m(G) \subseteq \overline{L_m(G)}$. It is prefixed closed only if $X_m = X$ (if all states are final, then all words that are generated are also accepted).

In general we can say that if a word is accepted, than _all of its prefixes can be generated_: $\overline{L_m(G)} \subseteq L(G)$. So we have:

$$
L_m(G) \subseteq \overline{L_m(G)} \subseteq L(G) = \overline{L(G)}
$$

## Class of Languages

> [!info] Class of Languages
> 
> The class of languages accepted by DFAs on an alphabet $E$ is defined as:
> 
> $$
> L_{DFA} = \{L \subseteq E^*\ |\ \text{there exsists a DFA G}: L = L_m(G)\}
> $$

If we define $L'_{DFA}$ as the class of languages generated by DFAs, we can show that the class of languages accepted by a DFA is _larger_ than that of languages generated by a DFA:

$$
L'_{DFA} \subset L_{DFA}
$$

This is because:

1. If a language is generated, then it is also accepted: if a language is generated from a DFA $G$, then there also exists a DFA $G'$ that accepts it, and it can be obtained from $G$ by redefining all states as final
2. Any language accepted by a DFA G where all states are not final is _not prefix closed_, so it does not belong to $L'_{DFA}$ (all languages generated are prefix closed). This means that the inclusion is _strict_.

## Properties of an Automaton

### Properties for a State

> [!info] State properties of a DFA
> 
> Given an automaton $G$, a state $x \in X$ is called:
>
> * **Reachable** from a state $\overline{x} \in X$: there exists a word $w \in E^*$ such that $\delta^*(\overline{x}, w) = x$.
> * **Co-reachable** to state $\overline{x} \in X$: there exists a word $w \in E^*$  such that $\delta^*(x,w) = \overline{x}$. This is basically the mirrored property of reachability.
> * **Blocking**: if it is reachable, but not co-reachable.
> * **Dead**: if $A(x) = \emptyset$. Meaning that no transition is enabled at $x$.

> [!warning] (Co)reachability
> 
> Since a state $x$ is always (co)reachable **with respect to another state** $\overline{x}$, when we are not making it explicit we usually refer to the _initial state_.

An example of blocking, but not dead state is $x_2$ in the following DFA. $x_3$, instead, is a dead state.

![](https://i.imgur.com/YJKKv0T.png)

Graphically, we can say that:

* $x$ is reachable from $\overline{x}$ if there is a path from $\overline{x}$ to $x$
* $x$ is co-reachable from $\overline{x}$ if there is a path from $x$ to $\overline{x}$
* $x$ is dead if there is no output arcs from that node

### Properties for a DFA

A DFA $G$ is called:

* **Reachable**, if all states are reachable
* **Co-reachable**, if all states are co-reachable
* **Non-blocking**, if all states are non-blocking (all reachable states are co-reachable)
* **Trim**: if it is reachable and co-reachable
* **Reversible**: if every state reachable from the initial state is also coreachable from the initial state

So, we can say that, graphically, an automaton is:

* **Blocking**, if there exists a _reachable ergodic component_ that does not contain _marked states_ (basically, once you reach that component you are stuck, and cannot reach any other state which is final)
* **Reversible**, if the graph is _fully connected_

> [!info] Extra: ergodic component
> 
> An ergodic component is a component of a graph which, graphically represented, can be entered but not exited. This means that it is a node which has an entry graph, but has some exit graphs that only bring back to it (it is like a cycle). The whole set of nodes that have this property create an _ergodic component_. A _transient component_ is ergodic, but has some nodes in the graph that has multiple arcs that can "lead out" of the cycle.

As an example, this automaton is not reachable ($x_2$ is not reachable), co-reachable and not blocking:

![](https://i.imgur.com/efJsX1R.png)

This automaton, instead, is reversible:

![](https://i.imgur.com/R5eFUcg.png)


> [!help] Physical representation
>
> Physically, the previous characteristics can be represented like this:
>
> * If a DFA is reachable, then one can study which are the possible states in which a system can be after an evolution that starts from the initial state
> * A blocking state is a condition in which a system cannot evolve towards a terminal state
> * A dead state is a condition in which no event can occur
> * Reversibility is the characteristic that allows a system to be brought back to the initial condition

## Non-Blocking Languages

We can say that a DFA $G$ is non-blocking _if and only if_ $\overline{L_m(G)} = L(G)$, meaning that the language is equal to the prefix closed language of accepted words (the automaton generates only accepted words, and the language is prefix closed).

> [!help] Explanation
> 
> The **if** part can be explained in the following way: if $\overline{L_m(G)}=L(G)$, then every generated word $u \in L(G)$ is, logically, also a prefix of another accepted word: this can be also re-expressed by saying that for all generated words $u$ there exists a word $v$ such that $uv \in L_m(G)$. Rewriting this using _states_, we can say that for every reachable state $x = \delta^*(x_0, u)$, there exists a word $v$ such that $\delta^*(x, v)$ is a final state. This proves that all reachable states are co-reachable, which is the fundamental assumption for saying that a DFA is non-blocking.

> [!help] Explanation
> 
> The **only if** part, instead, can be demonstrated by absurd. Let's assume that $\overline{L_m(G)} \subset L(G)$: this would mean that there exists a generated word $u \in L(G)$ that is not a prefix of an accepted word, meaning we have no word $v$ so that $uv \in L_m(G)$ is accepted. So, if we call $x = \delta(x_0, u)$ the state reached by generating $u$, we have no word $v$ such that $\delta^*(x,v)$ is a final state, since we said that we have no way to generate the accepted word $uv$. This means that $x$ is accessible, but _not_ co-reachable $\rightarrow$ $x$ is blocking, so the whole demonstration by absurd proves that $\overline{L_m(g)} \subset L(G)$ is not a sufficient assumption.

Let's make an example with the following DFA:

![](https://i.imgur.com/2ke9No4.png)

Here, we have that $L_m(G) = \{ba^n\mid n \geq 0\}$ (this DFA generates all words with exactly one $b$ and $n$ $a$'s). We also have that $\overline{L_m(G)} \subset L(G)$, since:

$$
\overline{L}_m(G) = \{\epsilon\} \cup \{ba^n \mid n \geq 0\}
$$

and

$$
L(G) = \{\epsilon, a, aa\} \cup \{ba^n\mid n \geq 0\}
$$

so we can say that the DFA is **blocking**.

## Trimming a DFA

> [!info] Trim component of a DFA
> 
> Given a DFA $G$ that is neither reachable nor co-reachable, its _trim component_ is the DFA:
> 
> $$
> G' = trim(G) = (X', E, \delta', x_0, X'_m)
> $$
> 
> where:
> 
> * $X' = \{x \in X \mid x \text{ is reachable and co-reachable in } G\}$
> * $\delta'(x,e) = \delta(x,e) \text{ if } x \in X' \text{ and } \delta(x,e) \in X'$, or otherwise it is _not defined_
> * $X'_m = X_m \cap X'$

So, in other words: we take $G$ and remove all states that are **not reachable nor co-reachable**, and the **transitions** that **input or output** from them. So, we have:

$$
L_m(G') = L_m(G) \text{ and } L(G') = \overline{L_m(G')} = \overline{L_m(G)}
$$

The trimming does **not** change the accepted language, but:

* For non-blocking DFAs, the trimming doesn't change the _generated language_ either, but it simply removes unreachable states
* For blocking DFAs, instead, the _generated language_ necessarily changes after trimming

![](https://i.imgur.com/AxX7UGL.png)

Here, for example, we obtain the DFA $c$ by trimming either $a$ or $b$.

## Automaton as Sequence Recognizer

Normally, automatons are considered as _sequence recognizer_: in this view, a DFA is like a device that reads input from a tape and translates to the next state. If the state reached is final, the word is accepted and the sequence is _recognized_. In this sense, we call an automaton _complete_ if it is able to read any input _regardless_ of the state it is in. Formally:

> [!info] Complete DFA
> 
> A DFA $G$ is called _complete_ if the transition function $\delta$ is defined for all states $x \in X$ and all symbols $e \in E$. Equivalently, we can also say that a DFA is complete if for all $x \in X$ we have $A(x) = E$.

### Complete a DFA

To complete a DFA, we can start from a non-complete one $G$ and generate a complete one, called $G' = (X', E', \delta', x_0', X_m')$, so that $L_m(G') = L_m(G)$ and $L(G') = E^*$. To do this, we proceed as follows:

1. Let $X' = X \cup \{x_c\}$ (we add a new state that we defined below)
2. Let $E' = E$, $x'_0 = x_0$ and $X'_m = X_m$ (these remain the same)
3. For all $x \in X'$ and for all $e \in E$:
   
   $$
	\delta(x', e) = \begin{cases}\delta(x, e) & \text{if } \delta(x,e) \text{ is defined}\\ x_c & \text{otherwise}\end{cases}
   $$

The resulting generated language $G'$ accepts the same language as $G$, but it does not **generate the same language**. Also, $G'$ is certainly blocking, since $x_c$ is not co-reachable.
