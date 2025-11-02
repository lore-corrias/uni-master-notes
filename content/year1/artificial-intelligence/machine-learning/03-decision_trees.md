---
title: 03 - Decision Trees
draft: false
---
## Decision Trees

They are the oldest representation of _high-level_ human learning, introduced in the '50s.

They are tree graphs built with `IF...THEN...` classification rules, they are also called **Classification Trees**.

Formally:

> [!info] Decision Tree
> 
> Given a classification problem with $d$ attributes $x_1,\dots,x_d$ with discrete and finite domains, a _Decision Tree_ is a tree graph that represents a _mutually exclusive_ set of classification rules of the form:
>
> ```
> IF condition THEN class
> ```
> 
> where:
> * _condition_ is a boolean expression
> * _class_


Considering the email-spam filter of before, we have the class labels set $Y = \{\text{Spam},\text{Legitimate}\}$ and boolean attributes that denote the occurrence of the following $d = 5$ terms in a mail:

$$
A = \{\text{cheap},\text{buy},\text{bargain},\text{university},\text{cheap}\}
$$

So, if we have a mail with `cheap` and `bargain`, we have this feature vector:

$$
x = (x_1, \dots, x_5) = (True, False, True, False, False)
$$

\newpage

We might thus have a decision tree like this one:

![](https://i.imgur.com/G8Yt8b9.png){width=70%}

This basically reads, for example: "if the term $x_2$ is not present, but $x_5$ is, then the mail is legitimate. If $x_5$ is not present, instead, it is a spam mail". We might also write this as:

$$
\text{IF}\ x_2=\text{True}\ \text{AND}\ x_1=\text{True}\ \text{AND}\ x_3=\text{True}\ \text{THEN}\ \text{Spam}
$$

 More formally:

* Every _non-leaf_ node checks a single attribute $x_i$, having one successor for each value of the domain $X_i$ (in this case, we have only two, as the domain is only $\{True, False\}$).
* Every _edge_ is linked to one value of the parent node
* Every _leaf_ node represents one class label
* Every _path_ represents a single **classification rule**
* Every attribute can appear _at most once in a path_ from the root to a leaf

This means that rules are **complete** and **mutually exclusive**: only one applies to a given feature vector. However, some attributes may _not appear_ in a DT, but some attribute might as well appear in _different paths_.

In the context of classifier models, the **hypothesis space** $H$ can be represented as the set of _all possible distinct DTs_ that can be built using the class labels $y$, and the attribute space $X$.

So, a DT learning algorithm has to specifically select a DT $h \in H$, based on a training set $T$, which is the "simplest" one consistent with $T$.

\newpage

To define a choosing strategy, we must first formalize _how_ to calculate the complexity of a decision tree. We can go with the simplest definition for a complexity of a DT, that is:

> [!info] DT Complexity
> 
> The complexity of a decision tree is given by the number of its **non-leaf nodes**. The bigger the number, the more complex the DT is.

So, one straightforward approach to find a _consistent_ DT with a set $T$ would be to try all the possible ones, starting from size $1$, then going to size $2$, and so on. What would the complexity of such an algorithm?

Let's analyze a simplified case. We have a classification problem with $d$ binary attributes (let's say, boolean) and $m=2$ classes. This is the spam filtering problem of the example before. Let's ask: _how many DTs of size 1 can we build?_. This would amount to $4d$ possible combinations:

![](https://i.imgur.com/LTkb0Ez.png)

How about size 2? The amount would become:

$$
2 \times d(d-1) \times 2^3 = 2^4d(d-1)
$$

To generalize, we would have that the _worst-case_ represents a _perfect binary decision tree_ (2 edges per non-leaf node). In this case, the number of nodes is given by:

$$
S_n = \sum_{k=0}^n ar^k
$$
In our case, $r=1$ and $r=2$, so $S_{n-1} = 2^n-1$. We can quickly see that this kind of approach doesn't scale really well: this is because finding the smallest consistent DT is an **NP-hard** problem.

\newpage

### Naive algorithm

If we only care about _consistency with the training data_, we can build the easiest algorithm based on the following strategy:

1. Take any training example $(x,y)$, and for each one:
	1. Build a _distinct_ path of depth $d$ from the root to the leaf node, in any node
	2. Label the leaf node with $y$
2. For each incomplete branch, associate a random class in $y$.

This basically translates to the following example. Say that we have the following $T$:

![](https://i.imgur.com/zDwq7cJ.png){width=60%}

Starting from $m_1$, we can build the following _partial_ DT:

![](https://i.imgur.com/EloadLh.png){width=60%}

> [!help]
> 
> Notice how the classifier is _already complete_ in regards to $m_1$, as we only have one exact path for its classification

Then, we iterate this process for each $m_i$. For each incomplete node, we just _choose a random value_, since our only goal is to be consistent with the training data.

![](https://i.imgur.com/GMvZne2.png)

The **generalization capabilities** of such an algorithm are very limited, as it only memorizes the training data (classical example of _overfitting_).

### A better algorithm: ID3

Better algorithms than the naive one can be built bu constructing a "reasonably small" and consistent DT by using some low-complexity heuristics that basically favor _smaller DTs_.

The key intuition behind such an algorithm named ID3 is that we can build a consistent DT using a top-down approach (from root to leaves) by, when reaching an edge, associating the inner node to be added with the most "**discriminant**" attribute for those example.

For example, let's consider a simpler case of our spam-filtering problem. Let's say that we have a training set like this one:

![](https://i.imgur.com/UDggXRJ.png)
we can immediately notice that all categorization can be done by simply using the element $x_6$: in this case, if $x_6=True$, then the mail is a legitimate, otherwise it is a spam. This is because $x_6$ is the most discriminant node in the tree. Then, ID3 would be capable of selecting the following DT:

![](https://i.imgur.com/JKR5Svk.png)

Since it is rare to have such a straightforward problem (where just one label allows us to perform an entire classification), we need to have a qualitative evaluation of the discriminant of each node.

To understand how to proceed, let's remove from the above example $x_6$. If we tried to split the DT by using $x_6$ as a discriminant, we'd have two different nodes built like this:

![](https://i.imgur.com/9LMGA0s.png)

Since we would like to group as many elements with a same class as possible into subsets. The best choice is thus $x_1$, as:

* for $x_1 = True$, the class ratio is `1:4` (1 spam, 4 legitimates)
* for $x_1 = False$, the ratio is `2:3` (2 legitimate, 3 spam)

From here, we proceed recursively (we will take, as an example, the right path). Going forward, we need to find the element with the highest discrimination value, and it is easy to see that such an element is $x_2$ (as it perfectly splits the nodes into two subsets):

![](https://i.imgur.com/iwEqBh3.png)

We then proceed on the `True` label of $x_1$ by selecting $x_3$ (the best element), and so on, until we have a complete DT. This algorithm is much faster than the naive one, but it still doesn't guarantee to find the _smallest_ possible consistent DT.

In order to have a functioning ID3 algorithm, we need to provide a good function that evaluates a node $n$'s capability to discriminate as efficiently as possible. This is done via the **entropy** of a probability distribution function.

> [!info] Conditional probability density function
> 
> Given $Y$ and $X$ as random variables corresponding to the class label, and the value of the attribute $x$ of any unknown example, the **conditional probability density function** $P(Y \mid X)$ is the probability for $Y$ to have value $y$ given $X$ having value $x$.

As an example, in the following DT:

![](https://i.imgur.com/syk4aRz.png)

The estimate of $P(Y \mid X_5 = \text{True})$ is:

* $P(Y=\text{Legitimate} \mid X_5=\text{True}) = \frac{3}{5} = 0.6$
* $P(Y=\text{Spam} \mid X_5=\text{True}) = \frac{2}{5} = 0.4$

In the case of a perfect split, we have a situation like this:

* $P(Y \mid X_6=\text{True}) = \frac{6}{6}$:
	* $P(Y=\text{Legitimate} \mid X_6=\text{True}) = \frac{6}{6} = 1$
	* $P(Y=\text{Spam} \mid X_6=\text{True}) = \frac{0}{6} = 0$
* $P(Y \mid X_6=\text{False}) = \frac{6}{6}$:
	* $P(Y=\text{Legitimate} \mid X_6=\text{False}) = \frac{0}{4} = 0$
	* $P(Y=\text{Spam} \mid X_6=\text{False}) = \frac{4}{4} = 1$

We can thus give a final definition of the _highest_ and _lowest_ possible discriminant capability

> [!info] Highest discriminant capability
> 
> An attribute $x$ has the highest discriminant capability if, for each of its values $v$:
> * $P(Y = y_v\  \mid \ X = v) = 1$, for one of the classes $y_v$
> * $P(Y = y\  \mid \ X = v) = 0$, for every other class $y \neq y_v$

> [!info] Lowest discriminant capability
> 
> An attribute $x$ has the lowest discriminant capability if, for each of its values $v$:
> $$
> P(Y = y\  \mid \ X = v) = \frac{1}{C}\text{, for each } y
> $$
> where $C$ is the number of classes

The measure of _uncertainty_ inside a distribution can be measured by the **entropy** of a random variable $Y$. If the variable is discrete and the domain is finite, it is calculated as:

> [!info] Random variable entropy
> 
> $$
> H(Y) = - \sum_{i=1}^CP(Y=y_i) \log_2{P(Y=y_i) \text{ bits }}
> $$

\newpage

> [!info] Example
> 
> For example, the entropy of a fair coin to come up heads or tails when flipped is:
> $$
> H(\text{fair}) = -(0.5\log_2{0.5} + 0.5\log_2{0.5}) = 1 \text{bit}
> $$
> as the chance of each outcome occurring is 50/50.

A property of this function is that $H(Y) \in [0, \log_2{C}]$:

* If all values are equiprobable, then $H(Y) = \log_2{C}$. If we have binary variables, then, $H(Y) \in [0,\log_2{2}] = [0,1]$.
* If only one value can occur, $H(Y) = 0$.

The _conditional_ entropy measures the amount of uncertainty about $Y$ when $X$ is known, and is calculated as:

$$
H(Y \mid X) = \sum_v{P(X=v)H(Y \mid X=v)}
$$
so, we can $H(Y \mid X=v)$ to

$$
H(Y \mid x=v) = - \sum_{i=1}^CP(Y=y_i \mid X=v) \log_2{P(Y = y_1 \mid X=v)})
$$

we can thus use the conditional probability to quantify the "discrimination-ness" of an attribute $x$:

* $H(Y \mid X)=0$ means that $x$ perfectly splits the set
* $H(Y \mid X)=\log_2{C}$ means that $x$ uniformly splits the set

\newpage

> [!help] Example
> 
> Take, as an example, the attribute $x_5$:
> 
> ![](https://i.imgur.com/hBwojOt.png)
> 
> The conditional entropy of $P(Y \mid X_5)$ is:
> 
> $$
> H(Y \mid X_5) = \sum_{v \in \{\text{True}, \text{False}\}}{P(X_5 = v)H(Y \mid X_5=v)}
> $$
> 
> We can estimate $P(X_5 = \text{True}) = P(X_5 = \text{False}) = \frac{5}{10} = 0.5$ (from the training set, we have 5 samples that are true, and 5 that are false).
> 
> We have said before that:
> 
> * $P(Y=L \mid X_5=\text{True}) = \frac{3}{5} = 0.6$
> * $P(Y=S \mid X_5=\text{True}) = \frac{2}{5} = 0.4$
> 
>So we can infer that:
>
> $$
> H(Y \mid X_5 = \text{True}) = -0.6\log_2{0.6}-0.4\log_2{0.4} \approx 0.97 \approx H(Y \mid X_5 = \text{False})
> $$
> 
> And thus, we have:
> 
> $$
> H(Y \mid X_5) \approx 0.5 \times 0.97 + 0.5 \times 0.97 = 0.97
> $$
> 
> With similar calculations, we can obtain the value of:
> 
> $$
> H(Y \mid X_1) \approx 0.5 \times 0.72 + 0.5 \times 0.97 = 0.845
> $$
> 
> Since
> 
> $$
> H(Y \mid X_1) < H(Y \mid X_5)
> $$
>
> we can say that $x_1$ is more discriminant than $x_5$ for the root node.

We can calculate the discriminant probability for each node, to choose the best one.
