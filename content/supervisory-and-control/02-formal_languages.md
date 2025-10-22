---
title: 02 - Formal Languages and DFA
tags: []
draft: true
date: 2025-09-30
---
> [!summary] Index
> Lezione precedente: [[uni/master/year1/supervisory-and-control/01-introduction|01-introduction]]

# Languages

> [!info] Language definition
> A language $L$ is a set of words of an alphabet $E$. The cardinality is defined as $|L|$

Some examples:
* $L_1 = \set{aab, aa, bbba}$ has $|L_1|=3$
* $L_2 = \set{a,b}$ has $|L_2| = 2$, both of length 1, and $L = E$
* $L_3 = \set{\epsilon,a}$ has $|L_3| = 2$, and contains also the empty word
* $L_4 = \set{\epsilon}$ has $|L_4| = 1$, and contains only the empty word
* $L_5 = \set{w \in E^*\ |\ |w| = 5}$ contains all words of length 5
* $L_6 = \set{w \in E^*\ |\ |w| > 3}$ contains all words of length greater than 3
* $L_7 = \emptyset$, contains no words, **but it is different to $L_4$**
* $L_8 = E^*$, contains all the words defined on $E$

## Operators
### Inclusion

If we have two languages and one is a subset of the other, we can say that $L_1 \subset L_2$ (read as "$L_1$ includes $L_2$"). For example:

$$
L_1 = \set{a} \subset L_2 = \set{a, aa}
$$

If $L$ is defined inside an alphabet $E$ we have:

$$
\emptyset \subset L \subset E^*
$$

### Union and Intersection

They work the same as they do in set theory.

Having $\bar{E} = E_1 \cap E_2$, $E = E_1 \cup E_2$, we have: 

* For the union, we have that the union is given by the words that belong either to $L_1$ or $L_2$:

$$
L_1 \cup L_2 = \set{w \in E^*\ |\ w \in L_1 \lor w \in L_2}
$$

* For the intersection, we have that it is given by the set of words that belong to both $L_1$ and $L_2$. 

$$
L_1 \cap L_2 = \set{w \in \bar{E}^*\ |\ w \in L_1 \lor w \in L_2}
$$

Properties:
* _Associativity_
* _Commutativity_
* _Identity element_:
	* Intersection: $E^*$. Because for all $L \subseteq E^*$ we have $L \cap E^* = E^*  \cap L = L$
	* Union: $\emptyset$. Because for all $L \subseteq E^*$ we have $L \cap \emptyset = \emptyset \cap L = L$

## Concatenation

> [!info] Concatenation of Languages
> Consider $L_1, L_2 \subseteq E^*$ be two languages. We define the concatenation of $L_1, L_2$ as:
>
> $$
> L_1L_2 = \set{w = w_1w_2 \in E^*\ |\ w_1 \in L_1, w_2 \in L_2}
> $$

For example, having:

$$
L_1 = \set{\epsilon, a}, L_2 = \set{a,b,ab}
$$

we have:

$$
L_1L_2 = \set{\epsilon \cdot a} \cup \set{\epsilon \cdot b} \cup \set{\epsilon \cdot ab} \cup \set{a \cdot a} \cup \set{a \cdot b} \cup \set{a \cdot ab} \cup \set{a,b,aa,bb,abb} \
$$

Properties:
* _Associativity_
* _Non-commutativity_
* _Identity element_: $L = \set{\epsilon}$. Because for $L \subseteq E^*$ we have $L\set{\epsilon} = \set{\epsilon}L = L$
+ _Distributive with the union_

We can also use exponents as we do for words: $L^0 = \set{\epsilon},\ L^1 = L,\ L^2 = LL, ...$

## Kleene Star

> [!info] Kleene Star for Languages
> Given $L \subseteq E^*$, its _Kleene Star_ is the language:
> 
> $$
> L^* = \epsilon \cup L \cup LL \cup LLL \cup LLLL \cup ... = \bigcup\limits_{k=1}^{\infty} L^k
> $$

For example: if $L = \set{bb}$ is a language on $E = \set{b}$ we have 

$$
L^* = \set{\epsilon} \cup \set{bb} \cup \set{bbbb} \cup\ ... = \set{(bb)^n\ |\ n \geq 0} \in E^*
$$

## Prefix Closure

> [!info] Prefix Closure
> A prefix language $\bar{L}$ of a language $L$ is the language that contains all prefixes of the words in $L$:
> 
> $$
> \bar{L} = \set{u \in E^*\ |\ \text{there is } w \in L: u \preceq w}
> $$

For example:
* $L_1 = \set{\epsilon, a, aa}$, we have $L_1 = \bar{L}_1$. In this case, we say that $L_1$ is prefix closed.
* $L_2 = \set{a, b, ab}$, we have $L_2 \not\subseteq \bar{L}_2 = \set{\epsilon, a, b, ab}$

## Complement

The complement of a language $L \subseteq E^*$ is the language of all the words that do not belong to $L$, but to $E^*$.

$$
C L = \set{w \in E^*\ |\ w \not\in L}
$$

For example, given $L_1 = \set{\epsilon, a, aa}$ on $E = \set{a}$ we have $CL_1 = \set{a^n\ |\ n \geq 3}$.


## Concurrent Composition

We use this when describing a system which consists of several subsystems. 

> [!info] Concurrent Composition
> We consider two languages $L_1 \subseteq E_1^*$, $L_2 \subseteq E_2^*$ and $E = E_1 \cup E_2$. The concurrent composition of $L_1$ and $L_2$ is defined as the language:
>
> $$
> L_1 || L_2 = \set{w \in E^*\ |\ w \uparrow E_1 \in L_1, w \uparrow E_2 \in L_2}
> $$

Example: consider $E_1  = \set{a,b}, E_2 = \set{b,c}, L_1 = \set{ab^n\ |\ n \geq 0}$ and $L_2 = \set{cbc^nb\ |\ n \geq 0}$. The concurrent composition is:

$$
L = \set{acbc^nb\ |\ n \geq 0} \cup \set{cabc^nb\ |\ n \geq 0}
$$

> [!help] Explanation
> This is because if we take the left operator of the union and we project it on the alphabet $E_1$ (meaning, we remove the symbols of the operator that are not defined in $E_1$) we get $abb$, which is part of the language $L_1 = \set{ab^n\ |\ n \geq 0}$. We can take the same reasoning for the projection to $E_2$, as we get $cbc^n$, which again is part of $L_2$. The same logic applies to the right operand of the union. Take note that this is just a proof, not an algorithm for the calculation of the concurrent composition.

A special case happens when the alphabets of the two languages are identical: in this cases, the concurrent composition of the two languages is equal to their intersection:

$$
E_1 = E_2 = E \text{ we have } w \uparrow E_1 = w \uparrow E_2 = w
$$

> [!help] Demonstration
> This is trivial: consider $E_1 = \set{a}, E_2 = \set{a}$, if we have $w = a$ $w \uparrow E_1 = a$, as we have to remove symbols from $w$ which are not in $E_1$, and since there are none, we get the same word. Since $E_1 = E_2$, it's the same for $w \uparrow E_2$.

and therefore:

$$
L_1 || L_2 = \set{w \in E^*\ |\ w \uparrow E_1 \in L_1, w \uparrow E_2 \in L_2} = \set{w \in E^*\ |\ w \in L_1, w \in L_2} = L_1 \cap L_2
$$

If we have $L_1 = L_2$, we get as well $L_1 || L_2 = L_1 \cap L_2 = L$

Properties:
* _Associativity_
* _Commutativity_
* _Identity element_: $E^*$

# Deterministic Finite Automaton

We use DFAs to describe _discrete event driven systems_. 

> [!info] Deterministic Finite Automaton
> A DFA is defined as:
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

The transition function $\delta$ is a function taking two inputs: a state $x \in X$ and an event $e \in E$ and returns a second state. Basically, it is a function that describes which is the successive state given one and an event that triggers a transition. It is a _partial function_: not all events can happen at all states.

An automaton can be described by a graph, having one node per state, represented by a circle. The transitions are defined by arc.

An example:
![](https://i.imgur.com/6gcwDnD.png)

Here, we have:
* Set of states: $X = \set{x_0, x_1, x_2}$
* Alphabet: $E = \set{a,b,c,d}$
* Initial state: $x_0$
* Final states: $X_m = \set{x_0}$
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

## Events

The events that trigger a state change of a DFA $G = (X, E, \delta, x_0, X_m)$ are not always possible. The set of enable events at a state $x \in X$ is:

$$
A(x) = \set{e \in E\ |\ \delta(x, e) \text{ is defined}}
$$

To say that $e \in A(x)$ we can write $\delta(x, e)!$, meaning that $\delta$ is defined for the given pair. T

This definition implies that $A(x)$ is a subset of $E$, but can never be equal to $E$. 

Since $\delta$ is a function, we cannot have multiple transitions with the same label outputting from a state $x$.

## Productions

The behavior of an automaton is given by the evolution of its states, described by their productions. Given a DFA $G$, we define a production of length $k$ a sequence of states and transitions:

$$
x_{j_0} \rightarrow^{e_1} x_{j_1} \rightarrow^{e_2}\ ...\ x_{j_{k-1}} \rightarrow^{e_k} x_{j_k} 
$$
where for all $i = 0,\ ..., k$ we have $x_{j_i} \in X$ and for all $i = 1,\ ...,k$ we have $x_{j_i} = \delta(x_{j_{i-1}, e_i})$

