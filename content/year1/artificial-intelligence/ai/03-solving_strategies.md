---
title: 03 - Strategies for solving search problems
draft:
---
## Uninformed strategies

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

![](https://media1.tenor.com/m/cAOJVb0QUKUAAAAd/bfs-algorithm.gif)

If we follow the decision tree algorithm formalization, the steps to be followed are:

1. Examine the fringe, stop if it is empty
2. Select the first node in the fringe
3. Examine the selected state, stop if it is a goal state
4. Remove the selected node from the fringe and expand it, generating the child nodes to be added at the end of the fringe
5. Repeat from step 1

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
>
> The DFS search algorithm is:
> 
> * **Complete**: meaning a solution is always found
> * **Non-optimal**: the solution found might not be the most efficient (given the fact that we are essentially brute-forcing the whole tree)
> * **Exponential** time complexity, but **linear** space complexity.


## Other strategies

Some other notable strategies are:

> [!info] Uniform-cost
> 
> The uniform cost strategy expands the leaf node with the lowest path cost. It is:
> * **Optimal**
> * **Complete**

> [!info] Depth-limited
>
> Like dfs, but has a depth limit $d$. allows finding solutions faster, but the depth of the shallowest one must be known.
> * **Complete**, if $d$ is not smaller than the depth of the shallowest solution
> * **Not optimal**

> [!info] Iterative-deepening depth-first
>
> Repeat depth-limited search by increasing $D$ until a solution is found. Removes the limitation of depth-limited search.
> * **Complete**
> * **Not optimal**

> [!info] Bidirectional
> 
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

## Informed strategies

Contrarily to uninformed searches, informed strategies do have some information on which node to pick in a search strategies when two are more promising. Exploiting this advantage allows us to perform what is called a **best-first search**

> [!info] Beast-first search
> 
> A **beast-first search** is performed by always picking the node of a search tree with the lowest value of a _node evaluation function_ $f(n)$, which corresponds to a more efficient path.

We can easily adapt our best-first search to the _general tree-search algorithm_ by sorting the nodes in a fringe from lowest to highest in regards to the value of their function $f(n)$.

Since finding an always exact value for the function $f(n)$ for each node is not trivial, we often go with its approximation $h(n)$, named **heuristic function**. Strategies based on $h(n)$ are thus called **heuristic searches**. By definition, $h(n)=0$ if $n$ contains a goal state.

For example, if we take out usual example of the map of Hungarian cities, a good enough heuristic function for a node $n$ would be the _straight-line distance_ of that node from our goal state (Bucharest):

![](https://i.imgur.com/cVM1iTX.png)

### Greedy best-first search

This is the simplest best-first strategy: we "_greedily_" (as we will see, this is not necessarily an optimal choice) expand the node which seems to be the _closest_ to the solution.

![](https://i.imgur.com/Xl8AI8b.png)

> [!info] Properties
> 
> The greedy search has the following properties:
> * **Complete**: if we have no cyclical paths
> * **Non-optimal**: if we take the above image as an example, there is one shortest route $\text{Arad} \to \text{Sibiu} \to \text{Rimnicu Vilcea}$
> * **Exponential** time and space complexity, given a constant branching factor $b$ and shallowest solution $m$: $O(b^m)$.


### A* Search

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
> 
> The $A^*$ has the following properties:
> * **Complete**
> * **Optimal**. However, the heuristics must be _admissible_: meaning the $h$ function never overestimates the minimum cost to a solution.

The time/space complexity is $O(b^d)$, where $d$ is the depth of the _shallowest_ solution. It is also _optimally efficient_ for admissible heuristics.

> [!help] Missing part
> 
> The part on the demonstration of the $A^*$ optimality is not included in these notes because it is not required by the professor.

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

The quality of an heuristic function is given by its **effective branching factor** ($b^*$). Formally:

> [!info] Effective branching factor
> 
> Given $N$ as the number of nodes generated by an $A^*$ search for a given problem and $d$ the depth of the optimal solution, $b^*$ is defined as the _branching factor_ of an uniform tree of depth $d$ containing $N$ nodes. This is given by the solution of the following equation:
> $$
> N = 1 + b^* + (b^*)^2 + \dots + (b^*)^d
> $$

The lower the value of $b^*$, the better. Its value is usually evaluated _empirically_ as an average. Here is an example of an estimate of $b^*$ for the 8-puzzle for both $A^*$ and one of the best uninformed search strategies, IDS:

![](https://i.imgur.com/wbJKIRF.png)
