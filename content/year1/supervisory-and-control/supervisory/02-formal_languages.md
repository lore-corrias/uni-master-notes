---
title: 02 - Formal Languages and DFA
tags: []
draft: false
date: 2025-09-30
---
# Formal Languages

> [!warning] Note from the professor
> 
> Pay attention to the notation!

A formal language is a set of strings of symbols with a set of rules. The set of symbols is called _alphabet_. We use formal languages to describe the evolution of dynamical systems.

## Alphabet and Words

An alphabet is a finite and non empty set of symbols, with a cardinality of $|E|$. Some examples might be:

$$
E_1 = \{0, 1\},\ \ \ \ \ \ \ E_2 = \{a,b,c,...,x,y,z\}
$$

A **word** $w$ is a sequence of symbols of $E$. The length of a word is $|w|$, while $|w|_e$ counts the occurrences of the symbol $e$ inside $w$. Some examples:

$$
w_1 = 0001111 \text{ defined on } E_1 \rightarrow |w_1| = 5, |w_1|_0 = 3
$$

$$
w_2 = hello \text{ defined on } E_2
$$

The empty word has length zero, and is defined  on all alphabets. It is denoted by the symbol $\epsilon$.

The set of all words of an alphabet $E$ is $E^*$, called _Kleene Star_ (or _Kleene closure_). This set is infinite, in contrast to $E$ which is finite. If a word is part of an alphabet we say that $w \in E^*$.

### Concatenation Operator

Given $w_1 \in E^*$ and $w_2 \in E^*$, $w = w_1 \cdot w_2 \in E^*$ is defined as the _concatenation_ of $w_1$ and $w_2$. For example:

$$
w_1 = aa, w_2 = bb, w = w_1 \cdot w_2 = aabb
$$

> [!info] Properties:
>
> * Associativity: $(w_1w_2)w_3 = w_1(w_2w_3)$
> * Non-commutativity: $w_1 = ab, w_2 = cd \rightarrow abcd \neq cbad$
> * The identity element is the empty word $\epsilon$: $w\epsilon = w$
> * Repetition: if $k$ identical symbols are concatenated we indicate the final result as $e^k$ : for example, $aabbb = a^2b^3$. The empty word can be written as $e^0 = k$

If we have a word $w \in E^*$ that can be written as $w=uvz$, with $u,v,z$ being words in the language $E$, then:

* $u$ is called a _prefix_
* $v$ is called a _substring_
* $z$ is called a _suffix_

For example, having $w = abcd$:

* The prefixes are $P = \{\epsilon, a, ab, abc, abcd\}$
* The suffixes are $S = \{\epsilon, d, cd, bcd, abcd\}$
* The substrings are all its prefixes, suffixes, and the words $\{b, c, bc\}$

### Projection Operator

Given $w \in E^*$ and a subset alphabet $\hat{E} \subseteq E$ the projection of $w$ on $\hat{E}$ is the word obtained from $w$ all symbols not in $\hat{E}*$. For example, if:

$$
E = \{a, b, c\}\ \ \ \hat{E} = \{a,b\}
$$

given $w= abccacba$, we have $w \uparrow \hat{E} = ababa$.

# Languages

> [!info] Language definition
>
> A language $L$ is a set of words of an alphabet $E$. The cardinality is defined as $|L|$

Some examples:

* $L_1 = \{aab, aa, bbba\}$ has $|L_1|=3$
* $L_2 = \{a,b\}$ has $|L_2| = 2$, both of length 1, and $L = E$
* $L_3 = \{\epsilon,a\}$ has $|L_3| = 2$, and contains also the empty word
* $L_4 = \{\epsilon\}$ has $|L_4| = 1$, and contains only the empty word
* $L_5 = \{w \in E^*\ |\ |w| = 5\}$ contains all words of length 5
* $L_6 = \{w \in E^*\ |\ |w| > 3\}$ contains all words of length greater than 3
* $L_7 = \emptyset$, contains no words, **but it is different to $L_4$**
* $L_8 = E^*$, contains all the words defined on $E$

## Inclusion Operator

If we have two languages and one is a subset of the other, we can say that $L_1 \subset L_2$ (read as "$L_1$ includes $L_2$"). For example:

$$
L_1 = \{a\} \subset L_2 = \{a, aa\}
$$

If $L$ is defined inside an alphabet $E$ we have:

$$
\emptyset \subset L \subset E^*
$$

## Union and Intersection Operators

They work the same as they do in set theory.

Having $\bar{E} = E_1 \cap E_2$, $E = E_1 \cup E_2$, we have: 

* For the union, we have that the union is given by the words that belong either to $L_1$ or $L_2$:

$$
L_1 \cup L_2 = \{w \in E^*\ |\ w \in L_1 \lor w \in L_2\}
$$

* For the intersection, we have that it is given by the set of words that belong to both $L_1$ and $L_2$. 

$$
L_1 \cap L_2 = \{w \in \bar{E}^*\ |\ w \in L_1 \lor w \in L_2\}
$$

> [!info] Properties
>
> * _Associativity_
> * _Commutativity_
> * _Identity element_:
> 	* Intersection: $E^*$. Because for all $L \subseteq E^*$ we have $L \cap E^* = E^*  \cap L = L$
>	* Union: $\emptyset$. Because for all $L \subseteq E^*$ we have $L \cap \emptyset = \emptyset \cap L = L$

## Concatenation Operator

> [!info] Concatenation of Languages
> 
> Consider $L_1, L_2 \subseteq E^*$ be two languages. We define the concatenation of $L_1, L_2$ as:
>
> $$
> L_1L_2 = \{w = w_1w_2 \in E^*\ |\ w_1 \in L_1, w_2 \in L_2\}
> $$

For example, having:

$$
L_1 = \{\epsilon, a\}, L_2 = \{a,b,ab\}
$$

we have:

$$
L_1L_2 = \{\epsilon \cdot a\} \cup \{\epsilon \cdot b\} \cup \{\epsilon \cdot ab\} \cup \{a \cdot a\} \cup \{a \cdot b\} \cup \{a \cdot ab\} \cup \{a,b,aa,bb,abb\} \
$$

> [!info] Properties
>
>* _Associativity_
>* _Non-commutativity_
>* _Identity element_: $L = \{\epsilon\}$. Because for $L \subseteq E^*$ we have $L\{\epsilon\} = \{\epsilon\}$
>* _Distributive with the union_

We can also use exponents as we do for words: $L^0 = \{\epsilon\},\ L^1 = L,\ L^2 = LL, ...$

## Kleene Star

> [!info] Kleene Star for Languages
> 
> Given $L \subseteq E^*$, its _Kleene Star_ is the language:
> 
> $$
> L^* = \epsilon \cup L \cup LL \cup LLL \cup LLLL \cup ... = \bigcup\limits_{k=1}^{\infty} L^k
> $$

For example: if $L = \{bb\}$ is a language on $E = \{b\}$ we have 

$$
L^* = \{\epsilon\} \cup \{bb\} \cup \{bbbb\} \cup\ ... = \{(bb)^n\ \mid \ n \geq 0\} \in E^*
$$

## Prefix Closure

> [!info] Prefix Closure
> 
> A prefix language $\bar{L}$ of a language $L$ is the language that contains all prefixes of the words in $L$:
> 
> $$
> \bar{L} = \{u \in E^*\ |\ \text{there is } w \in L: u \preceq w\}
> $$

For example:

* $L_1 = \{\epsilon, a, aa\}$, we have $L_1 = \bar{L}_1$. In this case, we say that $L_1$ is prefix closed.
* $L_2 = \{a, b, ab\}$, we have $L_2 \not\subseteq \bar{L}_2 = \{\epsilon, a, b, ab\}$

## Complement

The complement of a language $L \subseteq E^*$ is the language of all the words that do not belong to $L$, but to $E^*$.

$$
C L = \{w \in E^*\ |\ w \not\in L\}
$$

For example, given $L_1 = \{\epsilon, a, aa\}$ on $E = \{a\}$ we have $CL_1 = \{a^n\ |\ n \geq 3\}$.

## Concurrent Composition

We use this when describing a system which consists of several subsystems. 

> [!info] Concurrent Composition
> 
> We consider two languages $L_1 \subseteq E_1^*$, $L_2 \subseteq E_2^*$ and $E = E_1 \cup E_2$. The concurrent composition of $L_1$ and $L_2$ is defined as the language:
>
> $$
> L_1 || L_2 = \{w \in E^*\ |\ w \uparrow E_1 \in L_1, w \uparrow E_2 \in L_2\}
> $$

Example: consider $E_1  = \{a,b\}, E_2 = \{b,c\}, L_1 = \{ab^n \mid n \geq 0\}$ and $L_2 = \{cbc^nb\ |\ n \geq 0\}$. The concurrent composition is:

$$
L = \{acbc^nb \mid n \geq 0\} \cup \{cabc^nb \mid n \geq 0\}
$$

> [!help] Explanation
> 
> This is because if we take the left operator of the union and we project it on the alphabet $E_1$ (meaning, we remove the symbols of the operator that are not defined in $E_1$) we get $abb$, which is part of the language $L_1 = \{ab^n\ |\ n \geq 0\}$. We can take the same reasoning for the projection to $E_2$, as we get $cbc^n$, which again is part of $L_2$. The same logic applies to the right operand of the union. Take note that this is just a proof, not an algorithm for the calculation of the concurrent composition.

A special case happens when the alphabets of the two languages are identical: in this cases, the concurrent composition of the two languages is equal to their intersection:

$$
E_1 = E_2 = E \text{ we have } w \uparrow E_1 = w \uparrow E_2 = w
$$

> [!help] Demonstration
> 
> This is trivial: consider $E_1 = \{a\}, E_2 = \{a\}$, if we have $w = a$ $w \uparrow E_1 = a$, as we have to remove symbols from $w$ which are not in $E_1$, and since there are none, we get the same word. Since $E_1 = E_2$, it's the same for $w \uparrow E_2$.

and therefore:

$$
L_1 || L_2 = \{w \in E^* \mid w \uparrow E_1 \in L_1, w \uparrow E_2 \in L_2\} = \{w \in E^* \mid w \in L_1, w \in L_2\} = L_1 \cap L_2
$$

If we have $L_1 = L_2$, we get as well $L_1 || L_2 = L_1 \cap L_2 = L$

> [!info] Properties
>
>* _Associativity_
>* _Commutativity_
>* _Identity element_: $E^*$

