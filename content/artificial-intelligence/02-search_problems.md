---
title: 02 - Introduction to Search Problems
tags: []
draft: true
date: 2025-10-06
---
> [!summary] Index
> Lezione precedente: [[uni/master/year1/artificial-intelligence/01-introduction|01-introduction]]
> Lezione successiva: [[01-machine_learning]]

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

### Solve a Search Problem

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

