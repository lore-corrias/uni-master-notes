---
title: 02 - Supervised Classification
tags: []
draft: false
date: 2025-10-07
header-includes: \usepackage[most]{tcolorbox}
---
## Supervised Classification

Supervised classifications problem involve reinforcement learning, and are the most typical and simple ones. We can formulate them like this:

> [!info] Supervised Classification
> 
> In a supervised classification problem, an algorithm tries to understand the common characteristics of elements in an input set to then classify them into different sets of groups, through a system of rewards and punishments.

These algorithms are called _classifiers_. In particular, a classifier has to have defined:

* What are the _objects_?
* What are the _classes_?

Classes are usually represented through numbers, called _class labels_.

The choice of the dataset is also important, as it must be relevant to the algorithm we are trying to build. For example, if we wanted to build a ML algorithm to classify handwritten digits, we might want to represent an element in the dataset as a $28\times28$ matrix, where each input is a gray-scale representation of a pixel in the range $[0,255]$, but this might prove redundant. Common representations include:

* Fixed-size attribute vectors: used for text categorization
* Strings or graphs: used for face recognition (to build a graph of fiducial points)
* Sentences in a logical language

Formally, given a representation space $X$ and a set of class labels $Y$ an object is a pair of the form $(x,y) \in X \times Y$. An algorithm is thus a function that associates an input to a predicted class label:

$$
h: X \to Y, x \in X \land y \in Y
$$

Classification algorithms are usually expressed in different ways (not computer programs), some examples might be:

* `IF...THEN` rules, where the condition part refers to the attribute values and the consequent to one of the classes
* Mathematical functions, mainly for problems with numerical attributes and numerically-encoded classes
* Logical sentences

\newpage

### Spam Filtering example

Consider, for example, a spam e-mail filtering problem:

* e-mails are represented by feature vectors, denoting the occurrence of a predefined set $T$ of $d$ terms: 
  $$
   x = (x_1, \dots,x_d) \in X = \{0,+1\}^d
   $$
  where $0$ and $+1$ denote the presence/absence of a term
* class labels are $Y = \{\text{Spam},\text{Legitimate}\}$.

The classification algorithm might be the following linear function:

$$
f(x;w) = \sum_{i=1}^d w_ix_i-w_0
$$

where $w = (w_0,w_1,\dots,w_d) \in R^{d+1}$ have to be set by a learning algorithm. So we might say that:

$$
h(x;w) = \begin{cases} \text{Spam} & \text{if} f(x;w) \geq 0 \\ \text{Legitimate} & \text{otherwise} \end{cases}
$$

Here is a graphical representation:

![](https://i.imgur.com/wUB0B9c.png)

> [!help]
> 
> Basically, if the sum of the weighted terms in $T$ appearing in the e-mail is negative, then it is legitimate, otherwise it is marked as spam.

So, intuitively, the algorithm should assign _positive_ weights to terms likely to appear in spam emails, and _negative_ weights for others.

So the _classifier model_ is the set of all possible functions $h$:

$$
H = \{h(\cdot, w) : X \to Y\  \mid \ w \in R^{d+1}\}
$$

The learning algorithm should select one classifier $h \in H$ based on the desired input-output.

### Generalization Capability

Supervised learning should find a model that predicts _all possible instances_ of a problem, including _unseen ones_. This is called a **generalization capability**.

To achieve this, we train our model on a _training set_, and then test it on a different set, called the _test set_. The process of learning a general procedures from particular cases is known as _induction_. All existing solutions are based on two general principles of induction:

* _Consistency_ with the observations: meaning that the hypothesis must **agree** with the examples
* _Minimal complexity_: meaning that the hypothesis should be as simple as possible (simpler hypothesis are more likely to be correct according to Occam's razor)

Formalized: 

> [!info] Generalization capability
> 
> Given in hypothesis space $H = \{h : X \to Y\}$ and a training set $T$, the best classifier in $H$ is the simplest one which is consistent with $T$

> [!info] Consistency
> 
> An hypothesis $h$ is consistent with $T$ if it outputs the correct class labels for _all_ the examples in $T$:
> $$
>  h(x_i) = y_i, \forall (x_i, y_i) \in T
> $$

![](https://i.imgur.com/PRJ8jzT.png)

In this case, for example, the better classifier is the _left one_, as it is simpler (linear), while they are both consistent.


> [!info] Overfitting
> 
A typical issue with classifier is the _over-fitting_: this happens when we have a _complex_ hypothesis space, and we have to trade some complexity of the classifier with consistency. 
>
> An example of _over-fitting_ in the real word is a student that prepares for an exam by only learning the exact responses of a test, instead of developing a general framework for answering unknown cases.

The most used classifier models are **Decision Trees** and **Artificial Neural Networks**