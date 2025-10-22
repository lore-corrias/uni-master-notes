---
title: Artificial Intelligence
draft: true
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
	what does **it** refer to in these phrases? Language processing relies, generally, on our **background knowledge**: we assume that in the first phrase the pronoun refers to _window_ as a ball can crash a window, but in the second case we link **it** to _glass_, as a wall hardly breaks from a glass crashing to it.

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

> [!help]
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
> Some tips on the data structure:
> * Leaf nodes should be quickly accessible (use a linear data structure)
> * You can implement the fringe as a queue, where newly generated notes are added to the queue in the order chosen by the strategy

Here is a simil-C pseudo-code _problem-independent_ implementation of a three-search algorithm:

```
function Tree-Search (problem, Enqueue)
returns a solution, or failure
	fringe ← an empty queue
	fringe ← Enqueue(Make-Node(Initial-State[problem]),
fringe)
	loop do
		if Empty?(fringe) then return failure
		node ← Remove-First(fringe)
		if Goal-Test[problem](State[node]) succeeds
		then return Solution(node)
		fringe ← Enqueue(Expand(node, problem), fringe)
```

### Measuring a solution's performance

There are two main ways of measuring the performance of a tree-search algorithm:

* **Effectiveness**. Meaning: how "_good_" is the solution found? The two main characteristics of effectiveness are:
	* _Completeness_, which tells whether or not the algorithm is _guaranteed_ to find a solution, if there is one.
	* _Optimality_, which tells whether a solution found is the _best one_ or not.
* **Efficiency**. Meaning, how _computationally complex_ is the found solution? The two measures used are:
	* Time complexity
	* Space complexity

# Uninformed strategies

> [!info] Uninformed Strategy
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

![](https://media1.tenor.com/m/cAOJVb0QUKUAAAAd/bfs-algorithm.gif)

If we follow the decision tree algorithm formalization, the steps to be followed are:

1. Examine the fringe, stop if it is empty
2. Select the first node in the fringe
3. Examine the selected state, stop if it is a goal state
4. Remove the selected node from the fringe and expand it, generating the child nodes to be added at the end of the fringe
5. Repeat from step 1

> [!info] Properties
> The BFS search algorithm is:
> 
> * **Complete**: meaning a solution is always found
> * **Non-optimal**: the solution found might not be the most efficient (given the fact that we are essentially brute-forcing the whole tree)

> [!help] Missing part
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

![](https://media1.tenor.com/m/-wQsNYyfJX0AAAAd/dfs-algorithm.gif)

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
> The DFS search algorithm is:
> 
> * **Complete**: meaning a solution is always found
> * **Non-optimal**: the solution found might not be the most efficient (given the fact that we are essentially brute-forcing the whole tree)
> * **Exponential** time complexity, but **linear** space complexity.


### Other strategies

Some other notable strategies are:

> [!info] Uniform-cost
> The uniform cost strategy expands the leaf node with the lowest path cost. It is:
> * **Optimal**
> * **Complete**

> [!info] Depth-limited
> Like dfs, but has a depth limit $d$. allows finding solutions faster, but the depth of the shallowest one must be known.
> * **Complete**, if $d$ is not smaller than the depth of the shallowest solution
> * **Not optimal**

> [!info] Iterative-deepening depth-first
> Repeat depth-limited search by increasing $D$ until a solution is found. Removes the limitation of depth-limited search.
> * **Complete**
> * **Not optimal**

> [!info] Bidirectional
> Simultaneously expands from the start tree and the goal state, forward and backward, until the searches meet.
> * Requires reversible actions

### Avoiding repeated states

One common problem in search algorithms is the presence of _loops_. To avoid repeated states we can adopt multiple solutions:

1. If we can do reversible actions, once we find a repeated node we can discarded and go back to the previous state.
2. If we find a node that has some children that we already explored, we can just discard it we can do this: if we find nodes 
	1. In the path from the root to $n$
	2. In the current search tree, if we stored all nodes
3. If we find any child node with an already generated state, we can discard it.

Strategies 2.2 and 3 are the best one when we have to remove the nodes with the highest path cost.

# Informed strategies

Contrarily to uninformed searches, informed strategies do have some information on which node to pick in a search strategies when two are more promising. Exploiting this advantage allows us to perform what is called a **best-first search**

> [!info] Beast-first search
> A **beast-first search** is performed by always picking the node of a search tree with the lowest value of a _node evaluation function_ $f(n)$, which corresponds to a more efficient path.

We can easily adapt our best-first search to the _general tree-search algorithm_ by sorting the nodes in a fringe from lowest to highest in regards to the value of their function $f(n)$.

Since finding an always exact value for the function $f(n)$ for each node is not trivial, we often go with its approximation $h(n)$, named **heuristic function**. Strategies based on $h(n)$ are thus called **heuristic searches**. By definition, $h(n)=0$ if $n$ contains a goal state.

For example, if we take out usual example of the map of Hungarian cities, a good enough heuristic function for a node $n$ would be the _straight-line distance_ of that node from our goal state (Bucharest):

![](https://i.imgur.com/cVM1iTX.png)

## Greedy best-first search

This is the simplest best-first strategy: we "_greedily_" (as we will see, this is not necessarily an optimal choice) expand the node which seems to be the _closest_ to the solution.

![](https://i.imgur.com/Xl8AI8b.png)

> [!info] Properties
> The greedy search has the following properties:
> * **Complete**: if we have no cyclical paths
> * **Non-optimal**: if we take the above image as an example, there is one shortest route $\text{Arad} \to \text{Sibiu} \to \text{Rimnicu Vilcea}$
> * **Exponential** time and space complexity, given a constant branching factor $b$ and shallowest solution $m$: $O(b^m)$.


## A* Search

The most relevant search strategies, invented in the '60s.

It is based on an improvement of the greedy search. The main problem of the latter is its disregard for the cost of the already taken functions to go from the root to the current node $n$. To avoid this problem, $A^*$ uses a secondary function $g(n)$, which calculates the total path cost to go from the root node to $n$. This is also, of course, a rough estimation.

We can thus define a node evaluation function. used to estimate the minimum path cost to a solution

$$
f(n) = h(n) + g(n)
$$

where:
 * $g(n)$ is a function to calculate the _path cost_ to the node $n$.
 * $h(n)$, instead, is an heuristic function that estimates the cost it takes to go from $n$ to the searched node.

In order to find the best path, we compute the sum for the _minimum value_ of $h(n$). If our estimate of $h$ was perfect, we'd have $100\%$ of the chances to find the exact solution.

Taking the example of the path searching problem of the Hungarian cities, we might estimate that the function $g(n)$, calculated to each node, also corresponds, like $h(n)$, to a rough estimate of the _straight line distance_ from that city to Bucharest.

![](https://i.imgur.com/6AhzThM.png)

> [!info] Properties
> The $A*$ has the following properties:
> * **Complete**
> * **Optimal**. However, the heuristics must be _admissible_: meaning the $h$ function never overestimates the minimum cost to a solution.

The time/space complexity is $O(b^d)$, where $d$ is the depth of the _shallowest_ solution. It is also _optimally efficient_ for admissible heuristics.

> [!help] Missing part
> The part on the demonstration of the $A^*$ optimality is not included in these nodes because it is not required by the professor.
### Heuristic definition strategy

To find a good heuristic function $h$, a good approach is to usually elaborate a strategy to solve a _relaxed_ version of the problem (without some of the constraints).

If we have found, instead, several admissible strategies, we must choose one heuristic that _dominates_ all the others. Formally:

$$
\text{for each node } n, h(n) \geq h_i(n), i = 1, \dots, p
$$

If we do not have a dominant heuristic for each node, we can choose the one which is dominant for that node:

$$
h(n) = max\set{h_1(n), \dots, h_p(n)}
$$

The quality of an heuristic function is given by its **effective branching factor** ($b^*$). Formally:

> [!info] Effective branching factor
> Given $N$ as the number of nodes generated by an $A^*$ search for a given problem and $d$ the depth of the optimal solution, $b^*$ is defined as the _branching factor_ of an uniform tree of depth $d$ containing $N$ nodes. This is given by the solution of the following equation:
> $$
> N = 1 + b^* + (b^*)^2 + \dots + (b^*)^d
> $$

The lower the value of $b^*$, the better. Its value is usually evaluated _empirically_ as an average. Here is an example of an estimate of $b^*$ for the 8-puzzle for both $A^*$ and one of the best uninformed search strategies, IDS:

![](https://i.imgur.com/wbJKIRF.png)

# Knowledge Representation and KBS

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