---
title: Artificial Intelligence - 2025
draft: false
---
# Intelligence

Multi-faceted property, which includes the capabilities of:

* Thinking
* Reasoning
* Learning
* Self-conciousness

The first problem when talking about Artificial Intelligence, is that we can't even define correctly the term _intelligence_. To clear this confusion, it is best to look at the history of AI, which had contributions from many fields, such as:

* Logic
* Psychology
* Neurophisiology
* Ethology
* ...

Generally, the goal of the AI field is to build machines that are _capable of performing complex tasks_, usually associated to intelligence. As of today, two hypothesis are conflicting:

* **Weak AI** hypothesis: states that machine can _emulate_ intelligence, but not _be_ intelligence. Fundamentally, people who argue for this explanation assume that intelligence is a characteristic strictly reserved to human beings, due to the physical structure of our brains. As of now, this hypothesis provided the most contributions to the field.
* **Strong AI** hypothesis: on the other hand, argues that machines can _be_ intelligent, just like humans.

# History

The first attempts at building AI systems was based on trying to reproduce human reasoning. One example might be that of building _chess engines_: tools like this require _human instructions_ to build deterministic algorithms based on human logic.

The main problem of this strategy are, mainly:

* The lack of _computational complexity_: the total number of chess moves is higher than that of atoms in the observable universe.
* The lack of _background knowledge_. As an example, consider the phrases:
	* _John threw the ball to the window and broke **it**_
	* _John threw the glass to the wall and broke **it**_
	what does **it** refer to in these phrases?
	
Language processing relies, generally, on our **background knowledge**: we assume that in the first phrase the pronoun refers to _window_ as a ball can crash a window, but in the second case we link **it** to _glass_, as a wall hardly breaks from a glass crashing to it.

Eventually, AI evolved to handle more complex tasks passing from the _knowledge-driven_ approach to the _data-driven_ approach. Today, this strategy advanced research so that we today have:

* Machine learning - from the 2000s
* Deep Neural Networks - from the 2010s
* Generative Adversarial Networks and LLMs - from the 2020s

These last technologies could only be built thanks to the huge amount of data stored on the internet and various other enabling factors: geopolitical interests, processing powers and economic incentives.

# Agents

An agent is defined as a system that acts rationally, according to well-defined objective (regardless of whether they are "intelligent" or not, according to the weak AI hypothesis). They are given some sensors to perceive the environment and make actions through effectors.

![](https://i.imgur.com/AtANFl9.png)

# Problems

One important property of an intelligent agent is its ability to _solve problems_, which are usually delineated via:

1. A goal formulation
2. A problem formulation

## Search problems

An agent should then be able to provide a _solution_ with a _search_ process. These are called **search problems**

Search problems typically have these characteristics:

* **Static** vs **Dynamic**: if the environment changes or not
* **Fully** vs **Partially** observable: if the current state of the problem is known entirely
* **Discrete** vs **Continuous** set of actions
* **Deterministic** vs **Non-deterministic**: if the outcome of any sequence of actions is certain or not.

> [!info] Search problem: formal definition
>
>A formal definition of a search problem is provided via these 4 terms:
>
>1. The initial state
>2. The set of possible actions
>3. The goal test
>4. The _path cost_

* The initial state is a description of the state from which a search starts
* The actions set is comprised of all possible actions available at any possible state. We define them with a successor function $SF$ which accepts a state $s$ and returns a set of pairs $(a',s')$, indicating a legal action in $s$ and the resulting state $s'$ once $a'$ is made.
* The goal test is a function that, given a state, tells us if we have reached a final state
* The path cost is a metric used to indicate the _overall cost for a specific path_. It is usually calculated as the sum of the costs of each individual action, called **step cost**.

> [!help] Spiegazione
>
We can thus say that the _state space_ (i.e.: the set of all possible states), can be defined only using $SF$ and the first state. We can represent this as a _graph_ where a _path_ is a sequence of states connected through a sequence of actions

An example is the route finding problem.

![](https://i.imgur.com/zxGzXt7.png)

We have:

1. As the possible states: all possible cities in the map
2. As the initial state: any given city
3. As the goal test: if the current city is equal to the destination city
4. As the path cost: the path length, if the goal is to find the shortest route
5. As the possible actions: moving from one city to an adjacent one

We can implement $SF(state)$ like a function that returns all adjacent city given one. For example: $SF(\text{"Arad"}) = (\text{"Timisoara"},\text{"Sibiu"},\text{"Zerind"})$

To solve this problem we need to store the _whole state space_ in memory, so that we can represent the map as a graph.

## Solving a Search Problem

We will focus on static, fully observable, discrete and deterministic problems (the easiest).

One of the approach we have is to start from the initial state and then proceed to select iteratively using a _search strategy_. Adding one state after the other allows us to build what is called a **search tree**, where:

* A node is a possible state
* A leaf node is the end of a sequence (the set of all leafs is called frontier)
* The depth of a node is the number of actions needed to reach that node
* A path from node $a$ to node $b$ represents all the actions needed to reach $a$ from $b$

![](https://i.imgur.com/uCrRWtC.png)

Typically we construct this tree by starting from the initial state and performing these action:

1. If the fringe is empty, return with no solution
2. Choose one leaf node $N$
	1. If $N$ is a final state, return with the found solution
	2. Otherwise, apply $SF(N)$ and add each state as a leaf node
	3. Remove $N$ from the fringe

Here is a pseudo-code version:

```
function Tree-Search (problem, strategy)
returns a solution, or failure
	generate the root node using the initial state of problem
	loop do
		if there are no leaf nodes
			then return failure
		choose a leaf node according to strategy
		if the chosen leaf node contains a goal state
			then return the corresponding solution
		expand the chosen leaf node
```

In order to represent a problem, we might define a C-like data structure with the following fields:


|             |                                                                                     |
| ----------- | ----------------------------------------------------------------------------------- |
| State       | A representation of the current state (could be, for example, a tuple)              |
| Parent-Node | A pointer to the parent node                                                        |
| Action      | A string containing the executed action                                             |
| Path-Cost   | An integer with the total cost of the actions on the path from the root to the node |
| Depth       | An integer with the number of actions from the root to the node                     |

> [!help]
>
> Some tips on the data structure:
>
> * Leaf nodes should be quickly accessible (use a linear data structure)
> * You can implement the fringe as a queue, where newly generated notes are added to the queue in the order chosen by the strategy

Here is a simil-C pseudo-code _problem-independent_ implementation of a three-search algorithm:

```
function Tree-Search (problem, Enqueue)
returns a solution, or failure
	fringe <- an empty queue
	fringe <- Enqueue(Make-Node(Initial-State[problem]),
fringe)
	loop do
		if Empty?(fringe) then return failure
		node <- Remove-First(fringe)
		if Goal-Test[problem](State[node]) succeeds
		then return Solution(node)
		fringe <- Enqueue(Expand(node, problem), fringe)
```

### Measurging a solution's performance

There are two main ways of measuring the performance of a tree-search algorithm:

* **Effectiveness**. Meaning: how "_good_" is the solution found? The two main characteristics of effectiveness are:
	* _Completeness_, which tells whether or not the algorithm is _guaranteed_ to find a solution, if there is one.
	* _Optimality_, which tells whether a solution found is the _best one_ or not.
* **Efficiency**. Meaning, how _computationally complex_ is the found solution? The two measures used are:
	* Time complexity
	* Space complexity

# Uninformed strategies

> [!info] Uninformed Strategy
>
> A search strategy is called _uninformed_ when the algorithm does not have available some information to deduce which solution is _better_ than another.

Uninformed strategies typically explore the whole space state, until they find a solution. Some of these strategies are:

* Breadth-first
* Depth-first
* Uniform-cost
* Depth-limited
* Iterative-deepening depth-first
* Bidirectional

### Breadth first search (BFS)

The strategy of BFS is to expand the _shallowest_ node first (in case of parity, the node is chosen randomly). This basically means expanding first all of the nodes at depth 0, then at depth 1, and so on.

If we follow the decision tree algorithm formalization, the steps to be followed are:

1. Examine the fringe, stop if it is empty
2. Select the first node in the fringe
3. Examine the selected state, stop if it is a goal state
4. Remove the selected node from the fringe and expand it, generating the child nodes to be added at the end of the fringe
5. Repeat from step 1

> [!help] Graphical Representation
> 
> See [here](https://upload.wikimedia.org/wikipedia/commons/4/46/Animated_BFS.gif) for a graphical visualization of the algorithm.

> [!info] Properties
>
> The BFS search algorithm is:
> 
> * **Complete**: meaning a solution is always found
> * **Non-optimal**: the solution found might not be the most efficient (given the fact that we are essentially brute-forcing the whole tree)

> [!help] Missing part
>
> My notes here are missing the part about computational complexity (mainly because I think it's pretty trivial).
> 
> If you need it, you can find it in pages 56-63 of the first set of slides.

To calculate the computational complexity of BFS, we consider the following elementary operations:

* For _time_ complexity, the generation of a node.
	* Our _worst-case_ time complexity is given by the highest number of nodes that have to be generated before a solution is found
* For _space_ complexity, the addition of a node to a search tree
	* Our _worst-case_ space complexity is given by the highest number of nodes that have to be saved in memory before a solution is found


Considering BFS, we can infer that the worst case is that in which all nodes of the search tree are expanded, before we find the solution (since it is guaranteed that there is always one). We can represent in the following table the correspondence between the _depth_ and the number of generated nodes:


| Depth | N° of nodes |
| ----- | ----------- |
| 0     | 1           |
| 1     | b           |
| 2     | $b^2$       |
| 3     | $b^3$       |
| ...   | ...         |
| $d$   | $b^d$       |
| $d+1$ | $b^{d+1}-b$ |

So the total number of generated node in the worst case averages to the following sum (we can ignore the final $-b$ as it is irrelevant to the limit calculation):

$$
1 + b + b^2 + ... + b^{d+1} - b = O(\sum_{i=0}^{d+1} b^i) = O(b^{d+1})
$$

This means that the complexity is _exponential_ with respect to the depth of the _shallowest solution_. This denotes a **very low efficiency**:

![](https://i.imgur.com/tmd7iKl.png)

## Depth-first search (DFS)

Basically the opposite to BFS, DFS expands first the _deepest_ node (still choosing at random in case of parity). This basically amounts to exploring a whole path first, changing it if the solution is not found.

If we follow the decision tree algorithm formalization, the steps to be followed are:

1. Examine the fringe, stop if it is empty
2. Select the first node in the fringe
3. Examine the selected state, stop if it is a goal state
4. Remove the selected node from the fringe and expand it, generating the child nodes to be added at the end of the fringe
5. Repeat from step 1

DFS is fairly more space-optimal in comparison to BFS, because if we do not have loops, we can safely explore one path and then _remove_ it from memory, before passing to the next one. This implies that only one path has to be stored in memory per time

To calculate the computational complexity of DFS, we make the following assumptions for the worst-case scenario:

* All nodes have a constant _branching factor_ named $b$. 
* All solutions have the same depth $d$. $m$ is also the maximum depth of the tree (no loops)
* The goal state is always in the _last_ explored path. This means that the algorithm is forced to traverse all paths before ending.

So, we have the following table:

| Depth | Generated nodes | Stored nodes                      |
| ----- | --------------- | --------------------------------- |
| 0     | 1               | 1                                 |
| 1     | $b$             | $b$                               |
| 2     | $b^2$           | $b$                               |
| ...   | ...             | ...                               |
| $m$   | $b^m$           | $b$ (only current path is stored) |

So the total is:

* For time: the complexity is **exponential** with respect to $m$
  
  $$
   1 + b + ... + b^m = O(b^m)
   $$
* For space: the complexity is **linear**
  
  $$
   1 + mb = O(m)
   $$

> [!info] Properties
>
> The DFS search algorithm is:
> 
> * **Complete**: meaning a solution is always found
> * **Non-optimal**: the solution found might not be the most efficient (given the fact that we are essentially brute-forcing the whole tree)
> * **Exponential** time complexity, but **linear** space complexity.

> [!help] Graphical Representation
> 
> See [here](https://en.wikipedia.org/wiki/Depth-first_search#/media/File:Depth-First-Search.gif) for a graphical visualization of the algorithm.

### Other strategies

Some other notable strategies are:

> [!info] Uniform-cost
>
> The uniform cost strategy expands the leaf node with the lowest path cost. It is:
> 
> * **Optimal**
> * **Complete**

> [!info] Depth-limited
>
> Like dfs, but has a depth limit $d$. allows finding solutions faster, but the depth of the shallowest one must be known.
> 
> * **Complete**, if $d$ is not smaller than the depth of the shallowest solution
> * **Not optimal**

> [!info] Iterative-deepening depth-first
>
> Repeat depth-limited search by increasing $D$ until a solution is found. Removes the limitation of depth-limited search.
>
> * **Complete**
> * **Not optimal**

> [!info] Bidirectional
> Simultaneously expands from the start tree and the goal state, forward and backward, until the searches meet.
>
> * Requires reversible actions

### Avoiding repeated states

One common problem in search algorithms is the presence of _loops_. To avoid repeated states we can adopt multiple solutions:

1. If we can do reversible actions, once we find a repeated node we can discard it and go back to the previous state.
2. If we find a node that has some children that we already explored, we can just discard it. We can do this if we find nodes either
	* In the path from the root to $n$
	* In the current search tree, if we stored all nodes
3. If we find any child node with an already generated state, we can discard it.

Strategies 2.2 and 3 are the best ones when we have to remove the nodes with the highest path cost.

# Informed strategies

Contrarily to uninformed searches, informed strategies do have some information on which node to pick in a search strategies when two are more promising. Exploiting this advantage allows us to perform what is called a **best-first search**

> [!info] Best-first search
>
> A **best-first search** is performed by always picking the node of a search tree with the lowest value of a _node evaluation function_ $f(n)$, which corresponds to a more efficient path.

We can easily adapt our best-first search to the _general tree-search algorithm_ by sorting the nodes in a fringe from lowest to highest in regards to the value of their function $f(n)$.

Since finding an always exact value for the function $f(n)$ for each node is not trivial, we often go with its approximation $h(n)$, named **heuristic function**. Strategies based on $h(n)$ are thus called **heuristic searches**. By definition, $h(n)=0$ if $n$ contains a goal state.

For example, if we take out usual example of the map of Hungarian cities, a good enough heuristic function for a node $n$ would be the _straight-line distance_ of that node from our goal state (Bucharest):

![](https://i.imgur.com/cVM1iTX.png)

## Greedy best-first search

This is the simplest best-first strategy: we "_greedily_" (as we will see, this is not necessarily an optimal choice) expand the node which seems to be the _closest_ to the solution.

![](https://i.imgur.com/Xl8AI8b.png)

> [!info] Properties
> 
> The greedy search has the following properties:
>
> * **Complete**
> * **Non-optimal**
> * **Exponential**


## A* Search

The most relevant search strategies, invented in the '60s.

It is based on an improvement of the greedy search. The main problem of the latter is its disregard for the cost of the already taken functions to go from the root to the current node $n$. To avoid this problem, $A^\ast$ uses a secondary function $g(n)$, which calculates the total path cost to go from the root node to $n$. This is also, of course, a rough estimation.

We can thus define a node evaluation function, used to estimate the minimum path cost to a solution

$$
f(n) = h(n) + g(n)
$$

where:

 * $g(n)$ is a function to calculate the _path cost_ to the node $n$.
 * $h(n)$, instead, is an heuristic function that estimates the cost it takes to go from $n$ to the searched node.

In order to find the best path, we compute the sum for the _minimum value_ of $h(n)$. If our estimate of $h$ was perfect, we'd have $100\%$ of the chances to find the exact solution.

Taking the example of the path searching problem of the Hungarian cities, we might estimate that the function $g(n)$, calculated to each node, also corresponds, like $h(n)$, to a rough estimate of the _straight line distance_ from that city to Bucharest.

![](https://i.imgur.com/6AhzThM.png)

> [!info] Properties
> 
> The $A*$ has the following properties:
>
> * **Complete**
> * **Optimal**. However, the heuristics must be _admissible_: meaning the $h$ function never overestimates the minimum cost to a solution.

The time/space complexity is $O(b^d)$, where $d$ is the depth of the _shallowest_ solution. It is also _optimally efficient_ for admissible heuristics.

> [!help] Missing part
> 
> The part on the demonstration of the $A*$ optimality is not included in these nodes because it is not required by the professor.

### Heuristic definition strategy

To find a good heuristic function $h$, a good approach is to usually elaborate a strategy to solve a _relaxed_ version of the problem (without some of the constraints).

If we have found, instead, several admissible strategies, we must choose one heuristic that _dominates_ all the others. Formally:

$$
\text{for each node } n, h(n) \geq h_i(n), i = 1, \dots, p
$$

If we do not have a dominant heuristic for each node, we can choose the one which is dominant for that node:

$$
h(n) = max\{h_1(n), \dots, h_p(n)\}
$$

The quality of an heuristic function is given by its **effective branching factor** ($b^\ast$). Formally:

> [!info] Effective branching factor
> 
> Given $N$ as the number of nodes generated by an $A^\ast$ search for a given problem and $d$ the depth of the optimal solution, $b*$ is defined as the _branching factor_ of an uniform tree of depth $d$ containing $N$ nodes. This is given by the solution of the following equation:
>
> $$
> N = 1 + b^\ast + (b^\ast)^2 + \dots + (b^\ast)^d
> $$

The lower the value of $b^\ast$, the better. Its value is usually evaluated _empirically_ as an average. Here is an example of an estimate of $b^\ast$ for the 8-puzzle for both $A^\ast$ and one of the best uninformed search strategies, IDS:

![](https://i.imgur.com/wbJKIRF.png)

# Knowledge Representation and KBS

The goal of AI agents is to solve a specific instance of a problem. However, human beings use several innate characteristics of our brains to elaborate a solution strategy, including some high-level functions, like **abstraction**.

Take, for example, the following game, named "the wumpus world":

![](https://i.imgur.com/chvkPwo.png)

The player's goal is to start from $(1,1)$, get the gold and go back to the starting points. The rules are:

* You get the content of a room entering it
* You can infer pits and wumpus, respectively, by the adjacent cells' breeze and stench. Going into either is game-over.

We use knowledge representation to understand symbols, and reasoning to formalize a solution. However, **knowledge-based systems** (KBS) have neither of these characteristics, but must follow the same human path to get to a solution. In particular, we might have two instances of KBS:

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
> 
> **Logic** is the study of conditions under which an _argumentation_ (reasoning) is _correct_.

Declarative statements are called **propositions**, which is a concept that is either _true_ or _false_. These can be either _simple_ or _complex_, whether they are made of multiple propositions or not. An example is the phrase "_Socrates is a man_", or "_A tennis match can be won or lost_".

Logic only cares about the structure of an argumentation (it gives no information on whether a proposition is actually true or false). So, for example, given the following:

> All men are mortal; Socrates is a man; them, Socrates is mortal

This structure can be represented as:

```
all P are Q; x is P; then x is Q.
```

So its correctness only depends on its structure, and is independent on the value of $P$, $Q$ and $x$.

Logical sentences are usually "encoded" in so-called "Formal languages" that are used to represent propositions in a more understandable format. In particular, each language has:

1. A _syntax_, which consists of the grammatical rules of the language
2. A _semantic_, rules on how to build well-formed sentences.

_Arithmetic_ and _programming languages_ are examples of formal languages. Their main difference with natural languages is that while the former have a very rigid structure, the latter's rules are often less rigorous and more ambiguous.

We can use formal languages to provide logical structures using _entailment_, which is the process of "chaining" multiple logical propositions to construct a new result. I.e.:

$$
x + 4 = 4 \implies x = 4 - y
$$

This process is also called **logical inference**: an algorithm which derives conclusion from premises through entailment is called an "_Inference Algorithm_". Algorithms only operate at a _syntactic_ level by manipulating the symbols of the language to derive conclusions.

> [!info] Knowledge Base
> 
> Formally, given a knowledge base $KB$, the process of deriving a sentence $\alpha$ from $KB$ through an algorithm $A$ is written as:
> 
> $$
> KB \vdash_A \alpha
> $$

> [!info] Properties
> 
> Inference algorithms can be classified as:
> 
> 1. **Sound**: if the sentences are derived only through the entailment of premises. This means that if premises are true, then all conclusions are true as well.
>    $$
>    \text{if } KB \vdash_A \alpha \text{ then } KB \models \alpha
>   $$
> 2. **Complete**: if an algorithm derives _all_ sentences entailed by premises:
>    $$
>    \text{if } KB \models \alpha \text{ then } KB \vdash_A \alpha
>   $$

> [!note] On grounding
> 
> Of course, KBs are not necessarily "true" when measured in the real world. For humans, this philosophical question can be summarized in "how do we know that our beliefs are true in the real world?".
> 
> For machines, we can answer this by creating a connection between the KB and the real world, in order to provide measurements on the groundness of statements. This is done through **sensors** and **learning**, which, of course, can also be fallible.

We can now refine our definition of a KB by saying that:

1. The knowledge base is a set of sentences in a given logical language.
2. The inference engine is an inference algorithm for the same language.

## Propositional Logic

Propositional logic is one of the simplest formal languages used to represent logical sentences. It is comprised of:

* Atomic sentences: either a symbol to denote a proposition (like $P,Q$) or one of $\{True, False\}$.
* Complex sentences: atomic sentences linked together through logical connectives
* Logical connectives: like "and ($\land$)", "or ($\lor$)", "not ($\lnot$)", and so on.

The grammar of propositional logic expressed in BNF is:

![](https://i.imgur.com/5izsDmg.png)

While its semantics can either be represented as:

* The **model** of a sentence: which is an assignment of truth of all symbols that appear in it
* The **meaning** of a sentence: its "**truth value**" with respect to a particular _model_.

For example: $P \lor Q \implies R$ has $2^3 = 8$ possible models, which are obtained by combining all different permutations of $True$ and $False$ for all symbols.

In atomic sentences, we either have:

* $True$, which is true for all models
* $False$, which is false for all models
* The value of a propositional symbol, which must be specified in the model

While for complex sentences, we determine their truth value by recursively evaluating the simpler atomic sentences forming them and the _truth tables_ of their logical connectors:

![](https://i.imgur.com/GHtR8JU.png)

We can thus summarize all possible models for a proposition in a table:

![](https://i.imgur.com/UXCaq17.png)

> [!note] A note on the implication operator
> 
> In a natural language, we understand that "if P then Q" is the "implication" operator. However, in logical sentences we rather say "if $P$ is true, then $Q$ is also true, otherwise **I don't know**". This represents the concept of implication being a "**sufficient**, but not **necessary** condition", meaning that $Q$ might be true even if $P$ is false.

### Inference

The simplest inference algorithm is named **Model checking**

> [!info] Model Checking
> 
> Given a KB and a sentence $\alpha$, we want to enumerate all possible model and check if $\alpha$ is ture in every model.

For example, given $KB = {x + y = 4}$ and $\alpha : y = 4 - x$, can we say that this inference is correct?

$$
\{x+y = 4\} \vdash y = 4 -x
$$
The model checking algorithm verifies this by testing all possible combinations of $x,y$ to check if the model is true for all of them. This is done through the usage of the above-mentioned truth tables.

> [!info] Properties of Model Checking
> 
> Model checking is:
> 
> * Sound: as it directly implements entailment
> * Complete, since it works for any finite KB and any conclusion
> * Has a computational complexity of $O(2^n)$. Since it is _exponential_, this inference algorithm is often considered unfeasable.

This algorithm basically amounts to "bruteforcing" all possible combinations to check if all of them are valid. We can limit the computational complexity problem of model checking by introducing "_Inference Rules_", which represent a standard pattern of inference.

We define a simple reasoning step whose soundness can be easily proven. This step can then be applied to a specific structure to derive a conclusion, represented as:

$$
\frac{\text{premises}}{\text{conclusion}}
$$

These are some example of common inference rules which are commonly used when deriving truth values:

![](https://i.imgur.com/GVgKt92.png)

All of these rules can be proven to be sound by using truth tables (which means, through model checking), which are relatively small.

As an example, consider a program interested in winning a wumpus game configuration that wants to prove that $KB \models \lnot P_{1,2}$ (i.e., that the square 1,2 has no pit) knowing that:

1. $\lnot B_{1,1}$
2. $\lnot B_{1,1} \implies \lnot P_{1,2} \land \lnot P_{2,1}$

Meaning that we know that square (1,1) (the starting one) has no pit. By applying _modus ponens_ to $(1)$ and $(2)$ and _and elimination_ we get $\lnot P_{1,2} \land \lnot P_{2,1}$, which also means that $\lnot P_{1,2}$, concluding that room $(1,2)$ is safe.

The application of inference rules on a KB can be reduced to the following algorithm:

```
repeat
	apply in all possible ways the rules in I to the sentences of KB,
	and add to KB each derived sentence, if not already present in it
until new sentences have been derived, and a is not present in KB
```

Once the procedure has ended, we either:

* Get $\alpha$ in the final KB, and provided that $A$ is sound we can conclude that $KB \models \alpha$
* Don't get $\alpha$ in the final KB, and provided that $A$ is complete we can conclude that $KB \not \models \alpha$

The most important properties that need to be verified for an inference algorithm are thus:

* Soundness
	* Rather _trivial_: if the inference rules are sound, then so is the algorithm
* Completeness
	* More _difficult to prove_: it depends on the considered inference rules and the structure of the sentences at hand.
* The calculation of the computational complexity
	* Can be difficult (there is an enormous amount of possible permutations on the application of inference rules), but might be simplified by ignoring sentences irrelevant to the conclusion $\alpha$ and using as little rules as possible.

### Resolution

Resolution is a family of inference algorithms for propositional logic that are based on a **single** inference rule, named **resolution**.

In order to apply resolution to a problem, both premises and conclusions must be written in _conjunctive normal form_ (CNF), which is when a sentence is made up of:

* Either a _single clause_: $\lnot Q$ and $P \lor Q \lor \lnot R$
* Or a conjunction of two or more clauses
	* _A clause is a sentence made up of either a single literal or a disjunction of two or more literals: $P \lor Q \lor \lnot R$_.

We can rewrite any sentence in its conjunctive normal form:

![](https://i.imgur.com/8l2Z9NE.png)

Now, given two clauses in the form:

$$
\alpha_1 \lor \alpha_2 \lor \dots \lor \alpha_m
$$

$$
\beta_1 \lor \beta_2 \lor \dots \lor \beta_n
$$

And assuming that they contain a pair of _complementary literals_

$$
\alpha_p = P, \alpha_q = \lnot P
$$

The resolution rule derives a new clause made up of the disjunction of all the literals of the premise, except for $\alpha_p$ and $\alpha_q$

$$
\frac{\alpha_1 \lor \alpha_2 \lor \dots \lor \alpha_m,\ \ \ \beta_1 \lor \beta_2 \lor \dots \lor \beta_n}{\alpha_1 \lor \dots \lor \alpha_{p-1} \lor \alpha_{p+1} \lor \dots \lor \alpha_m \lor \beta_1 \lor \dots \lor \beta_{q-1} \lor \beta_{q+1} \lor \dots \lor \beta_n}
$$

Now, since $\alpha_p = \lnot \alpha_q$, one of the two must be true, while the other is false. This means that the _disjunction_ of the literals of the corresponding clause must be true (since `true OR false OR x = true`).

For example, the rule for the Wumpus game:

$$
B_{1,1} \iff (P_{1,2} \lor P_{2,1})
$$

can be rewritten in CNF as:

$$
(\lnot B_{1,1} \lor P_{1,2} \lor P_{2,1}) \land (\lnot P_{1,2} \lor B_{1,1}) \land (\lnot P_{2,1} \lor B_{1,1})
$$

The resolution inference rule is often coupled with a proof method named "Proof by refutation". This strategy takes advantage of the assumption that a KB cannot have any contradictory statement in it, since all of its sentences are considered to be true. This means that if we want to demonstrate that $KB \models \alpha$, we can do so by proving that $KB \land \lnot \alpha$ is unsatisfiable.

This two techniques combined can determine in a finite number of steps if $KB \models \alpha$ or $KB \not \models \alpha$. We do so by verifying that the two complementary literals do not produce an "empty" clause" (which would denote a contradiction):

$$
\frac{P, \lnot P}{[\ ]}
$$
In pseudocode:

![](https://i.imgur.com/i4NbWhF.png)

Checking satisfiability (non-contradiction), however, is an `NP-Complete` problem, meaning that its computational complexity is _exponential_. In order to improve execution efficiency, we can disregard clauses containing complementary literals (true by definition).

> [!help] Exercise
> 
> Consider a robot, powered by a battery, capable of moving objects that are liftable. Its knowledge baseincludes the fact that, if its battery is charged, and it tries to move a liftable object, then that object will move. It also has sensors that tell it whether its battery is charged or not, and whether an object it is trying to lift does or does not move. Assume that, after the robot encounters an object and tries to lift it, its sensors indicate that that object does not move, and that its battery is charged. Intuitively, this implies that the object is not liftable.
> 
> 1. Represent the robot’s knowledge (both the knowledge base and the sensory information) in propositional logic.
> 2. Prove that the object is not liftable, using the resolution inference rule.
>    
> We can represent the KB with three symbols:
> 
> 1. `BATTERY`: which represents whether the battery is loaded or not
> 2. `LIFTABLE`: which represents whether the object is liftable or not
> 3. `MOVES`: which represents whether the object was moved or not
> 
> We know that an object moves if it is liftable and the battery is charged: we can rewrite this phrase with the following proposition:
> 
> $$
> BATTERY \land LIFTABLE \implies MOVES
> $$
> 
> We also know from the text that the robot has its battery charged, but the object did not move. We can thus write our final KB as:
>
> $$
> KB = \begin{cases}
> BATTERY \land LIFTABLE \implies MOVES \\
> BATTERY \\
> \lnot MOVES
> \end{cases}
> $$
> 
> To use resolution, we need to eliminate implications using the rule $(P \implies Q) = (\lnot P \lor Q)$. In our case, we also need to move the negation in via $\lnot(P \land Q) \implies \lnot P \lor \lnot Q$. We also want to prove that the object is **not** liftable: since resolution operates through proofs by absurd, we need to add the negation of this proposition to the KB ($\lnot LIFTABLE$). Applying these steps, we have:
> 
> $$
> KB = \begin{cases}
> \lnot BATTERY \lor \lnot LIFTABLE \lor MOVES \\
> BATTERY \\
> \lnot MOVES \\
> LIFTABLE
> \end{cases}
> $$
> 
> Now we need to apply resolution to obtain a contradiction and demonstrate that $\lnot LIFTABLE$ is true. To do this, we apply both $(1)$ and $(2)$ to obtain:
> 
> $$
> KB = \begin{cases}
> \lnot LIFTABLE \lor MOVES \\
> BATTERY \\
> \lnot MOVES \\
> LIFTABLE
> \end{cases}
> $$
> 
> Then, form here, we apply $(1)$ and $(3)$:
> 
> $$
> KB = \begin{cases}
> \lnot LIFTABLE \\
> BATTERY \\
> \lnot MOVES \\
> LIFTABLE
> \end{cases}
> $$
> 
> Notice how $(1)$ and $(4)$ contradict each other. Since we can't have two opposite propositions in our KB, it must follow that $\lnot LIFTABLE$ is true.

### Horn Clauses

Most of the times KBs have their knowledge encoded in the form of **Horn clauses**: these are simply propositions in the form "`if ... then ...`" written in such a way that

1. The _antecedent_ is an atomic sentence or a conjunction of atomic sentences
2. The _consequent_ is a single atomic sentence

If a KB is made of Horn clauses and we have a conclusion that is an atomic sentence, we can use **Forward** and **Backward** chaining. These methods are also based on modus ponens, and are complete with respect to atomic sentences. Another advantage is that their computation is _linear_.

Forward chaining is an inference algorithm that applies Modus Ponens to all atomic sentences in KB in all possible way, and adds the resulting sentences back in the KB until some new proposition not yet present is derived. Since FC derives conclusion from premises that are present in the KB it is known as a "data-driven" model. For example, given the following KB:

1. $P \implies Q$
2. $L \land M \implies P$
3. $B \land L \implies M$
4. $A \land P \implies L$
5. $A \land B \implies L$
6. $A$
7. $B$

FC first derives $L$ from $(4)$, as it is not yet in the KB. Now that we have $L$, we can derive $M$ from $(3)$, then $P$ from $(2)$ and $Q$ from $(1)$. We can now stop since no other original sentence can be added to the KB.

If, however, we want to verify that a sentence $\alpha$ is in a KB, FC is inefficient, since most of the proposition derived would not be relative to $\alpha$ (which is called "_query_"). To fulfill this goal, we apply **Backward Chaining**, which recursively applies MP _backwards_ until either:

* we find $\alpha \in KB$
* we find some implication $\beta_1, \dots, \beta_n \implies \alpha$ such that $KB \models \beta_1, \dots, KB \models \beta_n$

Contrarily to FC, BC is a _goal-oriented_ reasoning, as it is not based on data loaded from the environment but rather on the _current knowledge of the agent_. Because of this, the computational complexity of BC is lower than that of FC.

## Predicate Logic

Propositional Logic has two main problems:

* Its expressive power is limited
* It lacks conciseness: many "natural language" sentences must be written using many logical predicates.

Because of these, many real-world problems that involve the use of _nouns_, _predicates_ denoting properties or relations between them, _functions_ and facts involving _parts_ of individuals of a set cannot be represented using propositional logic. These limitations gave birth to "**Predicate Logic**"

Predicate Logic is based on _models_, which consist of:

1. A **domain of discourse**, which is the set of individuals that can be considered in a proposition (e.g.: a set of people)
2. Some **relations** between domain elements, defined _extensionally_ (for example, by enumerating all set of tuples for which a relation holds). Relations might be _unary_ ($1 \times 1$, also called _properties_), _binary_ ($2 \times 2$, e.g. the "greater than" relation), or of any other dimension.
3. Some **functions** that map tuples of a domain element into a single one (e.g., the arithmetic sum)

In predicate logic, the syntax of a sentence is composed of:

* _Constant symbols_: $1,2,3,\dots$
* _Predicate symbols_: $\text{GreaterThan},\dots$
* _Function symbols_: $\text{Plus},\dots$

The grammar's expression in its BNF form is:

![](https://i.imgur.com/rZOdEV0.png)

Sentences are made by _terms_, which might either be _simple_ (e.g., a constant) or _complex_ (e.g., $Plus(One, One)$). Complex sentences can be made by "chaining" atomic ones through logical connectives.

Not all elements of a domain (which might as well be infinite) require a symbol, but only those which are considered in a sentence.

Quantifiers are used to consider only a portion of a set. We have:

* _Universal_ ($\forall$) quantifiers: "**all** men are mortal"
* _Existential_ ($\exists$) quantifiers: "**some** numbers are prime"

For example, the phrase "all numbers are greater than or equal to one" can be written as $\forall x\ GreaterOrEqual(x, One)$, meaning "the sentence on the right of the symbol $x$ is true for all possible values of $x$ in this domain". If we want to construct a sentence that uses a universal quantifiers in its premises to derive a conclusion, we use the implication operator. For example, "for all $x$, if $x > 2$ and $x$ is even, then $x$ is not prime" is written as:

$$
\forall x (Even(x) \land GreaterThan(x, Two)) \implies (\lnot Prime(x))
$$

For existential quantifiers, we can make an example with the phrase "some numbers are prime":

$$
\exists x\ Prime(x)
$$

which literally reads "there exists at least one $x$ such that $x$ is prime".

Quantifiers can also be used for more than one variable:

$$
\forall x,y,z \dots \alpha[x,y,z,\dots]
$$

The order is also very important. For example, the sentence:

$$
\forall x\ \exists y\ Loves(x,y)
$$
can be translated as "everybody loves somebody". But

$$
\exists y\ \forall x\ Loves(x,y)
$$
becomes "there is someone who is loved by everyone".

Qualifiers can also be connected through negations: saying $\forall x\ \alpha(x)$ is the same as $\lnot (\exists x\ \lnot \alpha(x))$

> [!note] Terms and Predicates
> 
> The main difference between terms and predicates is that:
> 
> * Functions denote _terms_: as such, terms can only appear as **arguments** of predicates.
> * Predicates denote _propositions_ : as such, they **cannot appear as arguments** of predicates or functions.
>   
> For example, if we want to say: "two is the sum of one, and one is a prime number":
> 
> * $Prime(Sum(One,One,Two))$ has no meaning, since $Sum$ is not a term
> * $Sum(One, One, Two) \land Prime(Two)$ and $Prime(Plus(One, One))$ are both correct.

> [!info] Determining True and False
>
> The "truthness" of a sentence is determined by analyzing the relations of the predicate symbol and checking if it holds between the objects referred to by its arguments. This is the same process used for propositional logic. For example $GreaterThan(One, Two)$ is false.

### Knowledge Engineering

The act of building a KB is called "**Knowledge Engineering**", and is often accomplished through the collaboration of:

* A _domain expert_
* A _knowledge engineer_, often not an expert in the domain of interest

The steps often used for building a KB are:

1. Identify the task
2. Acquire the general knowledge from the domain expert
3. Choose the vocabulary (i.e., the squares of a board game)
4. Encode the general knowledge through the usage of the vocabulary
5. Encode a specific problem instance
6. Pose queries to the inference algorithm
7. Debug the KB

**Theorem provers** are programs used to debug KB and are used for:

* Assisting mathematicians
* Proof checking
* Verification and synthesis of hardware and software

# Agents and Uncertainty

The main limitation of logical agents is their inability to handle _uncertainty_. In logic, propositions can either be _true_ or _false_, but real world problems often require choosing with a certain degree of belief. This uncertainty can be simulated using _probability theory_ in a numerical value between $[0,1]$. We can thus say that a rational agent can make a choice under uncertainty by yielding the highest **expected** utility out of all outcomes.

## Random Variables and Probability Distribution Functions

**Random variables** are used to describe possible configurations of a state of the world. Particularly, they can be:

* Symbols with uppercase initial
* Domains: _boolean_, _discrete_ (a finite set of elements) or _continuous_ (an infinite set of elements)

We will represent variables as tuples: $\langle true, false \rangle$.

Now that we have a set of variables, we can create a **Probability Distribution Function** (PDF) that associates to each element of our domain a probability. For example, having $Weather \in \langle sunny, rain \rangle$:

$$
P(Weather = sunny) = 0.7 \land P(Weather = rain) = 0.3
$$

The values of a PDF are always between $0$ and $1$, and the sum of all possible elements is equal to $1$.

## Events

A combination of values of random variables is called an _event_:

$$
Cavity = true \land Toothache = false
$$

While an _atomic event_ is any combination of **all** random variables, which creates a complete description of the world:

$$
Cavity = true \land Tootache = false \land Catch = true
$$

All atomic events are thus _mutually exclusive_ and _exhaustive_.

## Probabilistic Inference

Say that we have a "dentist" agent that is interested in knowing if a patient has a cavity ($P(Cavity = true)$), and if said cavity also manifests in a toothache ($P(Cavity = true \land Toothache = true$)). We call "**marginal probability**" the joint probability of any subset of random variables.

![](https://i.imgur.com/DV8pND5.png)

![](https://i.imgur.com/goGlZdE.png)

Another thing that the dentist agent might be interested in is _posterior probability_: what is the probability that, given that a patient has a cavity, it also has toothache?

$$
P(Cavity = true\ |\ Toothache = true) = \frac{P(Cavity = true, Toothache = true)}{P(Toothache = true)} = 0.8
$$

Conditional probabilities can be calculated using the PDF. Here, we have that 

$$
P(Cavity = true, Toothache = true) = 0.120
$$

by applying the **sum rule**: we sum all possible values of $Cavity = t$ and $Toothache = t$. We also know that

$$
P(Toothache = t) = 0.200
$$

we also applied the sum rule for all values of $Toothache = t$.

But how do we compute the full joint PDF? For example, given a $Coin \in \langle heads, tails \rangle$, how do we compute $P(Coin) = \langle ?, ? \rangle$?

* In classical probability, we assume that all events are mutually exclusive, and thus each of the $n$ elements has a probability of $1/n$: $P(Coin) = \langle \frac{1}{2}, \frac{1}{2} \rangle$.
* For real world problems, we use **frequentist probability**: by measuring how many times an event has occurred we can estimate the probability of it happening again.
* For complex problems of which we have no measurement, we use **subjective probability** (e.g., domain experts' judgment)

Calculating the entirety of a PDF function has a computational complexity dependent on the number of probability values specified. In order to simplify this calculation, we can use the **product rule**

> [!info] Product Rule
> 
> $$
> P(X | Y) = \frac{P(X,Y)}{P(Y)} \implies P(X,Y) = P(X|Y)P(Y)
> $$

As an example of how this might be useful, say that our dentist agent wants to also consider the following $Weather \in \langle sunny, rain, cloudy, snow \rangle$. If we wanted to calculate all possible values of the PDF $P(Toothache, Catch, Cavity, Weather)$, we would have to compute $(2 \times 2 \times 2 \times 4) - 1 = 31$ cases. However, we can assume that $Weather$ has no cause-effect relation with the other dental problems. Using the product rule, we can say that:

$$
P(Toothache, Catch, Cavity, Weather) = P(Toothache, Catch, Cavity | Weather) P(Weather)
$$

And since weather is independent to dental problems:

$$
P(Toothache, Catch, Cavity | Weather) = P(Toothache, Catch, Cavity) 
$$

which means that

$$
P(Toothache, Catch, Cavity, Weather) = P(Toothache, Catch, Cavity)P(Weather)
$$

and now, the values that we need to calculate are $(2^3 - 1) + (4 - 1) = 10$.

In this case, the two variables are said to be "**Independent**":

> [!info] Independence
>
> Two variables $X,Y$ are independent if
> $$
> P(X|Y) = P(X), P(Y|X) = P(Y)
> $$
> 
> and thus,
> 
> $$
> P(X,Y) = P(X)P(Y)
> $$

While very useful, absolute independence is very rare. However, we can use a weaker form of independence by establishing casual bonds between different variables. For example, patients with a "hollow" in a tooth are more likely to have toothache than patients without:

$$
P(Toothache | Catch = true) \neq P(Toothache | Catch = false)
$$

However, given that the patient has a cavity, toothache and catch can be assumed to be independent, since hollows do not influence the pain if the patient already has a cavity:

$$
P(Toothache|Catch, Cavity) = P(Toothache|Cavity)
$$

These variables are called **conditionally independent**:

> [!info] Conditional Independence
> 
> Two variables $X,Y$ are conditionally independent given $Z$ if:
> 
> $$
> P(X|Y,Z) = P(X|Z), P(Y|X,Z) = P(Y|Z), P(X,Y|Z) = P(X|Z)P(Y|Z) 
> $$

Having conditional independence, we need to calculate:

$$
P(Toothache|Cavity) P(Catch|Cavity) P(Cavity)
$$

for a total of $2 \times (2 - 1) + 2 \times (2 - 1) + 2 - 1 = 5$.

More generally, if we have $n$ boolean variables, the conditional PDF:

$$
P(X_1, \dots, X_{n-1} | X_n)
$$

is specified by $2 \times (2^{n-1}-1) = 2^n-2$ values. However, if all values are conditionally independent given $X_n$:

$$
P(X_1, \dots, X_n | Y) = \prod_{i=1}^{n-1}P(X_i|X_n)
$$
meaning only $(n-1) \times 2 \times (2^1-1) = 2(n-1)$ values are needed.

Causal inference helps us determining the **effects** of an event, given the **cause**: "if the patient has a cavity, then he might have a toothache and the dentist experiences a catch". This _causal_ knowledge is easy to obtain (e.g., open a medicine book and read that "80% of people with cavities have toothaches"), but we are much more often interested in _diagnostic knowledge_ (something like "if a patient has a toothache, there is a 40\% chance that it is caused by a cavity"):

$$
P(Cavity|Toothache,Catch)
$$

Diagnostic knowledge, however, is generally harder to obtain than causal one. In order to overcome this limitation, we can take advantages of **Bayes' rule**:

> [!info] Bayes' Rule
> 
> Given two equivalent expressions:
> 
> $$
> P(X,Y) = P(X|Y)P(Y), \text{ and, }
> P(Y,X) = P(Y|X)P(X)
> $$
> 
> it follows that:
> 
> $$
> P(Y|X) = \frac{P(X|Y)P(Y)}{P(X)}
> $$
> 
> We can also rewrite P(X) as
> 
> $$
> P(X) = \sum_{y \in Y}P(X, Y=y) = \sum_{y \in Y}P(X|Y=y)P(Y=y)
> $$

We can apply Bayes' rule to the previous example:

$$
P(Cavity|Toothache, Catch) = \frac{P(Toothache, Catch|Cavity)P(Cavity)}{P(Toothache, Catch)}
$$

we then apply conditional independence:

$$
\frac{P(Toothache|Cavity)P(Catch|Cavity)P(Cavity)}{\sum_{c \in \{t,f\}}P(Toothache|Cavity = c)P(Catch|Cavity = c)P(Cavity=c)}
$$

This mechanism of exploiting causal relations between events allows us to build a "chain" from the root causes to the end effects:

![](https://i.imgur.com/bY99rAw.png)

For example:

$$
P(Catch, Toothache, Cavity) = P(Catch|Toothache, Cavity)P(Toothache|Cavity)P(Cavity)
$$

The last expression is the product of two conditional distributions of a single variable, conditioned on all the variables that follow in the chosen order, and of the prior distribution of the last variable. Since all condition are in the causal form, we can rewrite the expression as:

$$
P(Catch|Cavity)P(Toothache|Cavity)P(Cavity)
$$

This is an example of the **chain rule** that is used to rewrite the full joint PDF by repeating the application of the product rule.

> [!info] Chain Rules
> 
> Given $n$ variables $X_1,\dots,X_n$:
> 
> $$
> P(X_1,\dots,X_n) = P(X_n|X_{n-1},\dots,X_1)P(X_{n-1}|X_{n-2},\dots)\dots P(X_2|X_1)P(X_1) = \prod_{k=1}^n P(X_k | X_{k-1},\dots,X_1)
> $$

In a conditional PDF $P(X_k|X_{k-1},\dots,X_1)$, conditioning variables are called **parents** of $X_k$ and denoted as $pa(X_k)$.

For $n$ variables, we have $n!$ ways to represent the same PDF:

![](https://i.imgur.com/IrnjEJK.png)

The most convenient one is the one that corresponds to one of the possible orders from "cause" to "effect".

## Bayesian Networks

One way to graphically visualize PDFs is through the use of **probabilistic graphical models**. The most commonly used are:

* **Bayesian Networks** (BNa), which are _directed acyclic_ graphs (DAGs)
* **Markov Random Fields**, which are _undirected_ graphs

We will focus on the Bayesian Networks. 

> [!info] BN Structure
> 
> In a BN:
> 
> * Each node represents a _random variable_ of a PDF, associated with its distribution in the expression of the chain rule
> * Each conditional dependency is represented by _oriented edges_, linking each variable with the ones on which its distribution is conditioned

For example, these are two possible equivalent expressions of $P(X_1,X_2,X_3)$:

![](https://i.imgur.com/a4uTv6i.png)

BNs are always _fully connected_ DAGs.

We saw that we are able to represent a joint PDF through the use of the _chain rule_. However, this strategy does not actually reduce the effort needed to calculate it. For that, we consider "linking" variables together through _conditional independence_, to reduce the number of values to consider.

When we factor conditional independence in a BN, the resulting DAG is no longer fully connected (since there are some variables that are independent from others). For example, having $P(X_1,X_2,X_3)$ and assuming $P(X_1|X_2,X_3) = P(X_1|X_3)$, the resulting BN no longer has an edge $X_2 \to X_1$

![](https://i.imgur.com/ZBpS3Ft.png)

> [!warning] On the order of the chain rule
> 
> Conditional independence can be used to simplify chain rule-obtained PDFs only if said rule is applied in the correct order. Considering $P(X_1,X_2,X_3,X_4)$, and the following independence relations:
> 
> $$
> P(X_1|X_2,X_3,X_4) = P(X_1|X_3)
> $$
> 
> $$
> P(X_2|X_3,X_4) = P(X_2|X_4)
> $$
> 
> we might have:
> 
> $$
> P(X_1|X_2,X_3,X_4)P(X_2|X_3,X_4)P(X_3|X_4)P(X_4)
> $$
> 
> or
> 
> $$
> P(X_4|X_3,X_2,X_1)P(X_3|X_2,X_1)P(X_2|X_1)P(X_1)
> $$
> 
> however, we can simplify $(1)$ into
> 
> $$
> P(X_1|X_3)P(X_2|X_4)P(X_3|X_4)P(X_4)
> $$
> 
> but not $(2)$

When needing to define a Bayesian Network, we need to choose the "best" order between variables to apply the chain rule. This usually corresponds to the following:

> [!info] Best order for the chain rule
> 
> Select the “root cause” variables first, then the ones they directly influence, and so on, until reaching the variables which have no direct causal influence on the others, i.e., the “end effect” variables

As an example, consider having a burglar alarm at home. Occasionally, this alarm also erroneously fires for earthquakes. You have two neighbors, John and Mary, who have promised to call you when an alarm fires.

1. John always calls when the alarm fires, but sometimes confuses the ringing of hist telephone with the alarm and thus erroneously calls
2. Mary, instead, sometimes misses the alarm because she likes listening to music

You might be interested in inferring the different probabilistic values for each scenario: how can you do this? First, consider the random variables:

* `A`: the alarm sounded or not
* `B`: a burglar entered your house or not
* `E`: there was an earthquake or not
* `J`: John called or not
* `M`: Mary called or not

The PDF function $P(A,B,E,J,M)$ might be represented like this using the chain rule:

$$
P(A|B,E,J,M)P(B|E,J,M)P(E|J,M)P(J|M)P(M)
$$

and the resulting representation with a BN would be:

![](https://i.imgur.com/ZgOUBwl.png)

Now we need to identify conditional independencies. We can assume `B` and `E` to be **root causes**, and we can also safely say that these two variables are causally independent. However, we know that both burglaries and earthquakes cause an alarm, so we need to link the two nodes of our BN with the "alarm" one:

![](https://i.imgur.com/6unZtE8.png)

Next, we need to consider `J` and `M`. We can also assume them to be independent of each other, but they are both directly caused by an alarm firing:

![](https://i.imgur.com/KlW8fVp.png)

So, our "chain" from root cause to effect is:

```
Burglary,Earthquake,Alarm,JohnCalls,MaryCalls
```

with the resulting PDFs:

$$
P(B,E,A,J,M) = P(M|A)P(J|A)P(A|E,B)P(E)P(B)
$$

We can also formalize the assumptions about the independence between variables we made early:

1. $P(E|B) = P(E)$: earthquakes and burglar are independent of each other
2. $P(J|A,E,B) = P(J|A)$: John is independent of Burglary and Earthquake given Alarm
3. $P(M|J,A,E,B) = P(M|A)$: John is independent of Burglary, Earthquake and JohnCalls given Alarm

Notice how we cannot say $P(M|B) = P(M)$, despite the fact that we do not have a direct edge between `B` and `M`. In fact, the two events are actually linked to `A`.

BNs provide _estimates_ and _approximations_ (our independence axioms are only based on subjective assumptions) and might also be incomplete (in this case, we have no way to tell if Mary or John made an erroneous call).

### Inference

With inference, we want to compute the PDF of a subset of $Q$ query variables given an observed $e$ from a subset $E$ of evidence variables:

$$
P(Q|E=e)
$$

so, we want to know the PDF given an $e$. This can be done through the sum rule:

$$
P(Q|E = e)=\frac{P(Q,E=e)}{P(E=e)} = \frac{\sum_yP(Q,E=e,Y=y)}{\sum_{q,y}P(Q=q,E=e,Y=y)}
$$

we can then rewrite the nominator and denominator with the chain rule.

This procedure has an _exponential_ worst-case time and space complexity. We can trade exactness for a lower complexity by approximating the inference methods, using randomised samplings. These algorithms are called "**Monte Carlo**".

MC algorithms generally work through _direct sampling_. Say that we know that flipping a coin has a distribution of $P(Coin) = \langle 0.5, 0.5 \rangle$. By sampling we just flip the coin $n$ times and estimate the distribution through our measurements.

In BNs, direct sampling consists of sampling a value for each $X$ in **topological order**: i.e., after a sample $z$ has already been drawn for all its parents $Z = pa(X)$ from $P(X|pa(X) = z)$. For example, taken this BN describing the morning routine of a person:

![](https://i.imgur.com/2LGsfmV.png)

We sample in this order:

1. $P(Cloud)$: suppose we get $Cloudy = true$
2. $P(Sprinkler | Cloudy=t)$, suppose we get $Sprinkler = false$
3. $P(Rain|Cloudy = t)$, suppose we get $Cloudy = true$
4. $P(WetGrass|Sprinkler=f,Rain=t)$, suppose we get $WetGrass = false$

We thus have this sample:

$$
Cloudy = true, Splinker = false, Rain = true, WetGrass = true
$$

Say that $P_{DS}=(X_1=x_1,\dots,X_n=x_n)$ be the probability that the samples contain the generated events $(x_1,\dots,x_n)$. We can say that

$$
P_{DS}=(X_1=x_1,\dots,X_n=x_n) = \prod_{k=1}^n P(X_k = x_k | pa(X_k)) = P(X_1=x_1, \dots, X_n = x_n)
$$

We expect that if we could extract an infinite number of samples, the frequency occurrence of each event _approaches_ that of the exact probability:

$$
\lim_{N \to \infty} \frac{N_{DS}(x_1,\dots,x_n)}{N} = P(X_1=x_1,\dots,X_n=x_n)
$$

We can also use **rejection sampling** to compute a _hard-to-sample_ distribution given an easy one:

1. Generate $N$ samples via direct sampling
2. **Reject** (discard) all the samples not matching with an evidence $e$
3. Given the $N' \leq N$ remaining samples, we take $N'' \leq N'$ be the number of samples for which $Q=q$: we can estimate $P(Q=q|E=e)$ as $N''/N'$.

For example, if we want to estimate $P(Rain=t|Sprinkler=t)$ from $N=100$ samples, we sample and obtain, say, $73\ Sprinkler=f$, which are then **rejected**. In the $N' = 27$ remaining, say $N'' = 8$ have $Rain = true$. So:

$$
P(Rain = true | Sprinkler = true) \approx \frac{N''}{N'} = \frac{8}{27} \approx 0.296
$$

However, if $P(E=e)$ is very low, we will obtain many more rejected samples than the ones we need, and thus this method is inefficient. We can avoid this with **likelihood weighting**: among the $N$ samples, each one where $Q=q$ is not counted as one, but rather _weighted_ by the likelihood that it accords to the evidence. We then estimate $P$ as the sum of weights divided by $N$.

For example, 

1. Set $w = 1.0$ as the weight.
2. Take the previous example and say that we sample $Cloudy = true$.
3. Now, we set $w = w \times P(Sprinkler  = t | Cloudy = t) = 0.1$, since $Sprinkler$ is an evidence variable.
4. Now sample again and get $Rain = true$
5. Set $w = w \times P(WetGrass = t|Sprinkler=t, Rain=t) = 0.099$ sampling $WetGrass = true$.

This means that, among samples that accord to the evidence, we expect $9.9\%$ of samples to have $Rain=true, Cloudy=true$. 
