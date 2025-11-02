---
title: 04 - Knowledge Representation and Logical Languages
draft:
---
The goal of AI agents is to solve a specific instance of a problem. However, human beings use several innate characteristics of our brains to elaborate a solution strategy, including some high-level functions, including **abstraction**.

Take, for example, the following game, named "the wumpus world":

![](https://i.imgur.com/chvkPwo.png)

The player's goal is to start from $(1,1)$, get the goal and go back to the starting points. The rules are:

* You get the content of a room entering it
* You can infer pits and wumpus, respectively, by the adjacent cells' breeze and stench. Going into either is game-over.

We use knowledge representation to understand symbols, and reasoning to formalize a solution. However, knowledge-based systems (KBS) have neither of these characteristics, but must follow the same human path to get to a solution. In particular, we might have two instances of KBS:

* **Procedural**: where the desired behavior is _encoded in the program_ (so we need no explicit knowledge representation or reasoning).
* **Declarative**: where a KBS must find a solution, so we have an explicit representation of:
	* A background knowledge (the rules, for example)
	* The knowledge on the specific problem instance (what the agent knows about the current cave)
	* The knowledge about the goal (like finding the goal without losing).

KBS share the following architecture:

![](https://i.imgur.com/qtcon2i.png)
where:

* The _knowledge base_ contains the agent's knowledge about the environment (in a _declarative_ form)
* The _inference engine_ implements a reasoning process

## Logic

_Logic_ is a discipline which traces back to the 4th century B.C. It is one of the most used tools in AI for _knowledge representation_ (with logical languages) and _reasoning_.

> [!info] Possible definition of logic
> **Logic** is the study of conditions under which an _argumentation_ (reasoning) is _correct_.

Declarative statements are called **propositions**, which is a concept that is either _true_ or _false_. These can be either _simple_ or _complex_, whether they are made of multiple propositions or not. An example is the phrase "_Socrates is a man_", or "_A tennis match can be won or lost_".

Logic only cares about the structure of an argumentation (it gives no information on whether a proposition is actually true or false). So, for example, given the following:

> All men are mortal; Socrates is a man; them, Socrates is mortal

This structure can be represented as:

```
all P are Q; x is P; then x is Q.
```

So its correctness only depends on its structure, and is independent on the value of $P$, $Q$ and $x$.