---
title: Machine Learning - 2025
draft: false
---
# Machine Learning

Best for solving easy problems that we complete intuitively, which don't know _how_ to solve logically. The taken approach is to emulate the learning capabilities of humans, which are based on experience.

The experience is taken from large amount of _data_ (typically scraped from the Internet), meaning that another concern is the quality of the data set, which might be an issue.

To solve some problems, we use _supervised learning_: here, the model has available all examples of input-desired output combinations.

![](https://i.imgur.com/Q4qeYAk.png){width=60%}

Some examples of these classes of problems are:

* **Classification**: predicting the _class_ of an input given out of a predefined set of classes. Common examples are spam filters (spam/legitimate) or digit recognition (0,1,...)
* **Regression**: predicting a _numerical value_. Common examples are counting people in a crowd.

\newpage

Another category of problems uses, instead, _semi-supervised learning_: here, some examples have the desired output, while some do not.

![](https://i.imgur.com/tsUXUQN.png){width=70%}

In _unsupervised learning_: a model learns from a data set **without** having the desired output.

![An example of unsupervised learning](https://i.imgur.com/PLI9ycB.png){width=70%}

There is also _reinforcement learning_: the agent learns from a series of reinforcements, which might be formalized as mechanisms of rewards and punishments given by performing actions on an environment. The goal is to find an _optimal action policy_, and usual applications include robot control and game control.

![](https://i.imgur.com/quqKeih.png){width=70%}

# Supervised Classification

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
>
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
> 
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

We can calculate the discriminant probability for each node, to choose the best one. If we wanted to calculate the discriminant capability for a node $x$ different from the root $x_i$ that is its successor, it would be equal to calculate:

$$
H(Y|X,X_i=v_i) = \sum_v P(X=v|X_i=v_i)H(Y|X=v,X_i=v_i)
$$

![](https://i.imgur.com/0zZ2MA8.png)

According to **Information theory**, the entropy of $H(Y)$ is measured in bits because it amounts to the measurement of the "missing" information on its value. This means that calculating $H(Y)$ equals to asking the question "_What is the missing information needed to find the class label of a random instance?_". A similar reasoning can be done with $H(Y|X)$, simply by taking into account the measurement of the entropy _after_ observing $X$.

This can be rewritten as saying that identifying the label with the smallest entropy amounts to maximizing the **information gain**: $H(Y) - H(Y|X)$.

However, information gain, as a metric, presents an inherent contradiction. Say that you have a node that is totally irrelevant to the class, like a DT that wants to determine the status of someone $Y=\{healthy,ill\}$, but also considers its birth date $d$, which is irrelevant. The resulting conditional entropy $H(Y|D) = 0$ would generate a consistent DT, but with no generalization capability. To surpass this problem, we use a variant of information gain named "**Gain ratio**":

> [!info] Gain ratio
> 
> $$
> \frac{InformationGain}{SplitInfo} = \frac{InformationGain}{-\sum_i^vp_i\log_2p_i}, with\ p_i=\frac{N_i}{N}
> $$
> 
> where:
>
> * $v$ is the number of values
> * $N$ is the number of samples arriving at the branch and split by $X$
> * $N_i$ is the number of samples arriving at the branch edge created by the $i$-th value of $X$.

In our example, classifying people by their birth date probably has a very high information gain, but it also has a huge split information, which is a measurement of how many branches the attribute creates. Dividing the first by the second allows us to cancel the bias.

![](https://i.imgur.com/asi0xvH.png)

### ID3 for Numerical Attributes

When we are working with numerical attributes (especially those with an infinite $X$ domain), adding an edge for each value is impractical, if not impossible. ID3 mitigates this problem by always performing a binary split of the trees: we divide $X$ in two subsets for a given threshold $t$ calculated by the learning algorithm:

* $X_{lower}=\{x \in X : x < t\}$
* $X_{upper}=\{x \in X : x \geq t\}$

Since $t$ is chosen by the learning algorithm, assume that among some examples $x$ we take $q$ different values $x_1 < x_2 \dots x_q$. Then, we consider $q-1$ possible values of $t$:

$$
t_k = \frac{x_{k+1}+x_k}{2}
$$

Among all these possible values, ID3 chooses the one that creates a split with the _minimum_ conditional entropy.

In this case, classifiers can be seen as functions $h : X \to Y$ mapping from the space of attributes to the label space. Each region corresponding to a different class label is called _decision region_. And, if $d \leq 3$, we can graph regions in a $d$-dimensional graph. Here, we have a graph with $d=2$ attributes both ranging $[0,1]$.

![](https://i.imgur.com/I0Lw5ye.png)

### Mitigate over-fitting

To mitigate over-fitting, we need a trade-off between a DT's size and consistency. We can achieve this either:

* "**offline**", by pruning a built DT and adding a leaf. Can be done by:
	* Setting a maximum tree depth
	* Setting a predefined value as a minimum for the number of training examples reaching a node
	* Setting a threshold for the value of the splitting criterion of the most discriminant attribute
* "**online**", by stopping the construction of a DT and adding a leaf

Note that offline criteria can be also applied for the online mitigations.

As an example, here we decide that we want to prune subtrees reached by less than 3 training examples. The removed tree is substituted with a leaf with a label `Spam` (we choose it randomly since we have a legitimate and a spam)

![](https://i.imgur.com/XWTgtD5.png)

## Performance Evaluation

Having trained a model through supervised learning, we know need a way to measure its **generalization capability**:

* The simplest one would be its _error rate_, calculated as the ratio of misclassified instances out of a set
* Its inverse, the _classification accuracy_
* More complex measures, like a _confusion matrix_: given an $m$-class problem, we define a $m \times m$ matrix $C$ whose elements $c_{ij}$ are the number of instances of class $j$ labelled as belonging to $i$:
  
  ![](https://i.imgur.com/6uHcH3Q.png)

Other metrics can be determined for _two-class problems_, in which the output is usually $\in \{True, False\}$. We can identify four classes:

* **True positives (TP)**: $True \to$ classified $True$
* **False positives (FP)**: $False \to$ classified $True$
* **True negatives (TN)**: $False \to$ classified $False$
* **False negatives (FN)**: $True \to$ classified $False$

For these problems, the error rate is:

$$
\frac{FP + FN}{FP+FN+TP+TN}
$$

However, there are some situations in which FPs are more significant for the end user than FNs, and viceversa. In this case, we use a _score_ metric that needs to surpass a certain threshold $t$ before a classification occurs:

$$
\text{if } s \geq t \text{ then } y = positive \text{ else } y=negative
$$

We can then adjust the value of $t$ to increase the numbers of $FP$ (increasing $t$ decreases them) and $FN$ (viceversa).

We can also graph the measurements of FP and FN through a **Receiving Operating Characteristics (ROC) curve**, which depicts the behaviour of the TPR (true positive rate) and the FPR (false positive rate):

$$
TPR = \frac{TP}{TP+FN}, FPR=\frac{FP}{TN+FP}
$$

![](https://i.imgur.com/Y6yLlm9.png)

We might also want to measure misclassifications in some unit: we define $\lambda_{ii}$ as the cost of correct measurement (usually 0) and $\lambda_{i,j}$ as the cost for a misclassifications, which might be different for different classes. We then measure the cost by calculating:

$$
\frac{\sum_{i=1}^m\sum_{j=1}^m\lambda_{ij}c_{ij}}{n}
$$

If $\lambda_{ii} = 0$ and all misclassifications have the same cost, then the cost is $\lambda \times (\text{error rate})$.

The most common method used to measure the generalization capability of a learning algorithm is to split the training set into two parts:

* One is the effective training set
* The other is the _testing_ set

The testing set is used after the training to measure the performances of the algorithm. This technique is called **hold-out**, and is more reliable then the test made using only the same training set, as these instances are _unseen_.

However, reducing the training set necessarily lowers the generalization capabilities: a common workaround to this problem is the usage of the **$k$-fold cross-validation**:

1. We split the samples into $k$ (typically 5 or 10) disjoint and equally-sized sets $T_1,\dots,T_k$, named "**folds**"
2. For each fold:
	1. Train the classifier using samples in $T - T_i$
	2. Estimates its performance measure $e_i$ on $T_i$
3. Estimate the generalization capability as the average across $k$ folds: $(\sum_{i=1}^k e_i)/k$

We then deploy the classifier on the whole $T$: a larger $k$ leads to more accurate estimates, but also higher processing costs. When $k=n$, the technique is named "**leave-one-out**".

When a supervisor is being design, we can represent the unknown training instances that will be used as joint random variables $(X,Y)$, with $X$ as the attribute vector and $Y$ the class label, from a probability function $P(X,Y)$. The label predicted by the classifier on a random instance is thus $\hat{Y}=h(X)$, with $h(\cdot)$ being the classifier. We then define a **loss function** which we can use to calculate the difference between the predicted and the true instance. The simplest one is the $0-1$ loss:

$$
l(\hat{Y},Y) = \begin{cases}0, & \text{if } \hat{Y}=Y \\
1, & \text{if } \hat{Y} \neq Y
\end{cases}
$$

Which is the misclassification probability $P(h(X) \neq Y)$. Since we do not know $P(X,Y)$, we can make an estimate of it using the frequentist definition of probabilities. For example:

$$
P(h(X) \neq Y) \approx \frac{\sum_{i=1}^n l(h(x_i),y_i)}{n}
$$

## Artificial Neural Network

Artificial Neural Network are born from the rapid development of neuroanatomy and neurophisiology. The idea is to recreate a learning algorithm that simulates that of the human brain through _digital neurons_, which are now considered to be its fundamental building block.

Human neurons are nerve cells that "_fire_" (emit an electrical signal) in response to a certain pattern. Their concatenation (humans have $\approx 10^{15}$ neurological connections in their body). The first proposal that imitates human neurons is that of the "_logical unit_" by McCulloch and Pits in $1943$. 

> [!info] First prototype of neurons
> 
> They are composed of:
> 
> * $d$ input signals: $x_1, \dots, x_d \in \{0,1\}$, with a fictitious input $x_0=-1$
> * $d$ connection weights: $w_0, \dots, w_d \in \mathbb{R}$, whose values are used to increase the "importance" of some inputs instead of others
> * The final input is calculated as the weighted sums of all inputs:
> 
>   $$
>  a(x,w) = \sum_{i=0}^d w_ix_i
>  $$
> 
> * Finally, the output is a binary signal $y = \{0,1\} = g(a)$, where $g$ is named an "activation function":
> 
>  $$
>  g(a) = \begin{cases} 1, & if\ a \geq 0 \\
>  0, & if\ a < 0 \end{cases}
>  $$
> 
> This function has an output of $1$ if the neuron "fires": i.e., if the input of the neuron exceeds a certain threshold, or $0$ if it doesn't.
> 
> ![](https://i.imgur.com/NqMM9zM.png)

As with human ones, these prototype neurons can be chained together to form **the logical connectors** `AND` and `OR`:

![](https://i.imgur.com/ZydILSO.png)

This prototype neuron then became the "**perceptron**", which laid the basics for the foundations of _artificial neural networks_. The only difference with that formulated by McCulloch and Pitts' is that its inputs can consists of _real_ numbers, meaning that it can be used to distinguish between two **classes of input**, since the output is still binary.

This, for example, would be a perceptron used to discriminate images of zeros and ones: given a 64px image, each pixel is a weighted input:

![](https://i.imgur.com/WKWJXm0.png)

Inputs can also be simplified before reaching the percetron using **feature extraction**: instead of using all pixels, we might just want to use two parameters, assuming that "zeros" are often more wide than "ones":

1. The number of pixels whose value exceeds a threshold, divided by 64
2. The number of image columns containing at least one foreground pixel, divided by 8

![](https://i.imgur.com/rEcsdnd.png)

### Learning Algorithms for Perceptron

Since we are interested in creating a learning algorithm, our goal would be to train one to be able to give the best weights for all inputs. More specifically, we want to create a learning function that minimises the number of misclassifications on a training set $T$. We can start by applying _random weights_, and then slowly adjust them to obtain better results at each iteration.

In order to better visualize this process, we can take advantage of the definition of our _activation function_ being:

$$
y(a) = \begin{cases}
1, & if\ \sum_{i=0}^d w_ix_i \geq 0 \\
0, & if\ \sum_{i=0}^d w_ix_i < 0 \end{cases}\ \ with\ x_0=-1
$$

Graphically, this can be written as an hyperplane with equation $\sum_{i=0}^d w_ix_i=0$. As an example, if we have two attributes ($d=2$) with values $x \in [0,1]$, we might have a graph like this (the threshold line depends, of course, on the activation function):

![](https://i.imgur.com/TYA8hwG.png)


Where the arrow points to the activation region. The black and withe circles correspond to the inputs of the neuron: if we had a perfect classification functions, they would be perfectly divided into the two regions (whites with $1$ and blacks with $0$), but here we have some misclassifications. We can actually **measure** the "misclassification-ness" of an input $x$ by measuring its distance from $h$ (the line). In formulas, having:

$$
h = w_1x_1 + w_2x_2 + \dots + w_dx_d - w_0 = 0
$$

and

$$
x = (x_1,\dots,x_d)
$$

the absolute value of the input $a(x,w)$:

$$
|a(x,w)| = |w_1x_1 + w_2x_2 + \dots + w_dx_d - w_0|
$$

is proportional to the distance of $x$ to $h$. This measurement is useful, because it gives us an initial metric for the definition of an _error function_.

> [!info] Error function for a perceptron learning algorithm
> 
> Given a misclassified $x$ with weights $w = w_0, \dots, w_d$, the error function $E$ is defined as:
> 
> $$
> E(x,w) = -t \times a(x,w) = -t \times (w_1x_1 + w_2x_2 + \dots + w_dx_d - w_0)
> $$
> 
> where $t = 1$ if we want $x$ to be $1$, and $-1$ if we want $x$ to be $0$.

This way, $E(x,w) > 0$ if $x$ is misclassified. Since $E$ is a two-variables function, we can represent it with a 3-dimensional graph:

![](https://i.imgur.com/NhyR3ZF.png)

We can visualize the act of "reducing the error" as "finding the lowest point of this graph". This approach is called "**gradient descent**", and is shown in the photo as the arrow pointing to the **absolute minimum** of $E$. In formulas:

$$
w_i = w_i - \eta\frac{\partial E(x,w)}{\partial w_i},\ i = 0, \dots, d
$$

where:

* $\frac{\partial E(x,w)}{\partial w_i}$ is the _partial derivative_ of the error function with respect to the weight, $w_i$. Graphically, this correspond to the "**steepness**" and the "**direction**" in which the error increases. Since we want to find the opposite (the region where $E$ is minimum), we subtract it from our current position, which is $w_i$. The partial derivative of the error function is equal to:
  
  $$
   \frac{\partial E(x,w)}{\partial w_i} = \begin{cases} -t \times x_i, & i = 1, \dots, d \\
   t, & i = 0
	\end{cases}
   $$

  meaning that the update rule is:
  
  $$
   \begin{cases} w_i = w_i + \eta x_it, & i=1,\dots,d \\ w_0 = w_0 - \eta t \end{cases} 
   $$
  
* $\eta$ is an arbitrary and positive constant called **learning rate**. It works as a weight to the partial derivative: the higher its value, the more significant are the adjustments of the weights at each iteration.

![](https://i.imgur.com/D7l5mvj.png)

Since one iteration might not be enough to fix all weights simultaneously, the learning algorithm is called repeatedly. Each execution of the algorithm is called "**epoch**".

In pseudocode:

![](https://i.imgur.com/QIZ3JVk.png)

### Convergence

We have a way to tell if the learning algorithm of a perceptron converges. Consider this case as an example:

![](https://i.imgur.com/a5jB2w6.png)

here, the two classes of inputs can be clearly divided in two by a line. This classes are called "**linearly separable**", and it is guaranteed that, for any $\eta > 0$, if the classes of our algorithm are separable, then it always converges to a consistent solution after a number of epochs. We usually choose $\eta = 1$ in these cases. However, in this case, the classes are **not** linearly separable:

![](https://i.imgur.com/757wm0b.png)

Since a consistent solution cannot be found, the algorithm is usually "manually" stopped after a number of iterations or, generally, after reaching a **stopping condition**, to prevent it from oscillating around a certain value.

### Perceptron limitations and Networks

The principle of linear separability highlights a bigger problem with perceptron, that is the impossibility of representing certain binary functions, like a `XOR`. Here, for example, tracing a line that separates linearly the input classes will always leave out $1/4$ of inputs:

![](https://i.imgur.com/DIFXitv.png)

These problems can be solved by "chaining" perceptrons in "**Artificial Neural Networks (ANN)**". These are networks made up of some input neurons, any number of "_hidden_" internal units and some _recurrent connections_:

![](https://i.imgur.com/PLiP8sY.png)

For example, we can use this network to represent a `XOR` function:

![](https://i.imgur.com/ghak4jh.png)

One issue with perceptron networks is the calculation of their **error function**: we can observe the output of the final output units with:

$$
E(x,w) = -t \times a(x,w)
$$

but there is no way to measure the value of $E$ for hidden inputs:

![](https://i.imgur.com/U70GKm8.png)

This means that we cannot use the minimization of the error function algorithm. Also, how are we supposed to build a perceptron networks? Would it be suitable to have a second learning algorithm specific for this task?

These limitations resulted in a drop of interest in ANNs, which was reignited in the 1980s thanks to the following solution:

1. We do not create learning algorithms to design networks: instead, we use some **predefined architectures** that work well for many problems
2. We devise effective learning algorithms for:
	1. Specific architectures $\to$ **feed-forward** networks
	2. Continuous activation functions, that allows us to use the gradient descent for hidden inputs

For the point $2.2$, we are particularly interested in two different functions:

1. The **logistic function**: $g(a) = \frac{1}{1+e^{-a}} \in (0,1)$
   
   ![](https://i.imgur.com/aL1zA6o.png)

2. The **hyperbolic tangent**: $g(a) = tanh(a) = \frac{e^a-e^{-a}}{e^a+e^{-a}} \in (-1,1)$
   
   ![](https://i.imgur.com/d601zEJ.png)

For point $1$, instead, we will focus on the most used architecture, called "**feed-forward multi-layer**" (FF-ML): we arrange unit into layers, with an input and an output one, and one or more hidden ones, having no recurrent connections: each unit receives an input from a unit of a previous layer.

![](https://i.imgur.com/M9fwkQs.png)

We can actually divide FF-ML network types depending on our problem:

* For **two-class** problems, we have a single output unit whose desired output $t \in \{0,+1\}$ or $t \in \{-1,+1\}$. For new instances of $x$ after training, we define the label as $+1$ if $y(x) \geq 0.5$ if using the logistic function, or if $y(x) \geq 0$ with the tanh function. Otherwise, we set $0$ or $-1$.
* For **multi-class** problems, we have $m$ output units for $m$ classes with $t_k = +1$ and $t_i \in \{0,-1\}$ for $i \neq k$. For new instances of $x$ after training, we define the label $k^\ast$ as the one corresponding to the **highest** output value: $k^* = \text{arg max}_{k=1,\dots,m} y_k(x)$.

FF-ML networks can represent:

* **Boolean functions**, with one hidden layer
* **Bounded and continuous functions**, with one hidden layer and some approximation error
* **Bounded and discontinuous functions**, with two hidden layer and some approximation error

However, this often requires an exponential number of hidden units with respect to the number of inputs. Also, since the target function is normally unknown, a "trial-and-error" approach is used when designing FF-ML networks, starting from a "simple" one and adding complexity if the generalization capability is not enough.

### Back-propagation

For FF-ML ANNs, a popular learning algorithm is "**back-propagation**". We still have to define both an _error function_ and a "_gradient descent-like_" procedure to minimize the error functions iteratively.

* The most used error function for _regression problems_ is the **squared error**: given $y=(y_1, \dots, y_m)$ the output values and $t=(t_1, \dots, t_m)$ the vector of desired outputs, it is calculated as:

	$$
	E(y,t) = \frac{1}{2} \sum_{k=1}^m (t_k-y_k)^2
	$$

* For _classification problems_, instead, we use the **cross-entropy**:

	$$
	E(y,t) = \begin{cases} -(t \log y + (1-t) \log(1-y)), & \text{for } m = 2 \text{ classes} \\
	-\sum_{k=1}^m t_k \log y_k & \text{for } m>2 \text{ classes} \end{cases}
	$$

> [!info] Back propagation
> 
> Given $w$ as the vector with the connection weights, the goal of this algorithm is to find the vector $w$ that minimises the error function over the whole $T$:
>
> $$
> w^\ast = \text{arg min}_w \sum_{(x,t)\in T}E(y,t)
> $$
> 
> where $y$ is a function of $x$ and $w$.


To do this, we still use _gradient-descent_: to simplify the explanation, we consider a network with only one $w$, but the general formula holds:

$$
w  = w - \eta \frac{\partial E(y,t)}{\partial w} \text{ for each } w \in w
$$

In order to do this, we first have to compute the output of a network $y$ given the current weights. This operation is called "**forward propagation**":

![](https://i.imgur.com/cDNGJoM.png)

This can be done by computing, for every node, its input $a$ and its output $y=g(a)$, which will be used as the input of a second node, and so on. 

Once we have computed $y$, we can compute the partial derivatives of the error function starting from the weights of the output and proceeding backwards, hence the name "**back-propagation**". We can do this because the final output $y$ can be rewritten as a _composition_ of the output of the previous nodes:

$$
E(y,t) = E(g(a), t) = E(g(\sum_k w_kx_k), t)
$$

And we can thus compute the partial derivative using the chain rule:

$$
\frac{\partial E}{\partial w_k} = \frac{\partial E}{\partial y} \frac{\partial y}{\partial a} \frac{\partial a}{\partial w_k}
$$

![](https://i.imgur.com/WXX6IGc.png)

For example, if $E(y,t) = \frac{1}{2}(t-y)^2$ and we use $g(a) = (1+e^{-a})^{-1}$ as the activation function, then the singular derivatives can be computed like this:

![](https://i.imgur.com/GCHHEAS.png)

While this reasoning is valid for output units, we need to adapt it for hidden ones. We can start by reasoning that the error function for any hidden unit at the $l$-th layer $u^l_j$ depends on it through its output, say $y_j$. However, this output becomes, in turn, the input of unit $u^{l+1}_i$ in the next layer:

![](https://i.imgur.com/uITtFGu.png)

This means that we can adapt the partial derivative for it using the same chain rule, like this:

$$
\frac{\partial E}{\partial w_k} = \frac{\partial E}{\partial y_j}\frac{\partial y_j}{\partial a_j}\frac{\partial a_j}{\partial w_k}
$$

We already calculated a value for the last two terms (respectively, $y_j(1-y_j)$ and $x_k$), but what about $\frac{\partial E}{\partial y_j}$? We know that $E(y,t)$ depends on $y_j$ through the output of each unit of the next layer: $u_i^{l+1}$, meaning we can apply the chain rule again:

$$
\frac{\partial E}{\partial y_j} = \sum_{u_i^{l+1}} \frac{\partial E}{\partial y_i}\frac{\partial y_i}{\partial y_j}
$$

we can also rewrite the second term with the chain rule (again):

$$
\frac{\partial y_i}{\partial y_j} = \frac{\partial y_i}{\partial a_i} \frac{\partial a_i}{\partial y_j} = y_i(1-y_i)w_{ij}
$$

To finally get the following:

$$
\frac{\partial E}{\partial w_k} = [\sum_{u_i^{l+1}} \frac{\partial E}{\partial y_i} y_i(1-y_i) w_{ij}] y_j(1-y_j)x_k
$$

![](https://i.imgur.com/FIjaf03.png)

Or, in pseudocode:

![](https://i.imgur.com/UrUJ7xN.png)

One problem with back-propagation is that of **local minima**: minimum of the functions which prevent it from reaching the global minimum. We usually either detect this kind of situations by detecting plateaus: either stopping after a certain number of iterations or detecting when the function remains constant even after some iterations. However, we can also prevent the error of local minima by running the same function with different randomized starting weights, to then choose the ones with the minimum training error associated to them:

![](https://i.imgur.com/lFNuAgt.png)

It is also usually a good idea to _normalize_ values, for example by scaling them inside the range $[0,1]$:

$$
x_i' = \frac{x_i-x_{i,min}}{x_{i,max}-x_{i,min}}\ \ i=1,\dots,d
$$

### Over-fitting

ANNs can also incur in over-fitting. To mitigate the issue, we can either:

* Choose the correct network through the trial-and-error method described above
* Set constraints on network weights by adding _penalty terms_ to the error function, which favour "simpler" decision boundaries (e.g., avoid **too large** weights in absolute value). This is called "**regularisation**".
* Monitor the error function through the epochs on a distinct set than the training ones. After some epochs, while the training error decreases the validation one could increase: this is a symptom of over-fitting.

### ANN vs DT

The main distinctions between ANNs and DTs are:

* Their _generalization capabilities_: ANNs are more robust to noise than DT and achieve generally larger generalization capabilities.
* Their _interpretability_ (the possibility for a user to understand the output) is usually better for DTs, since ANNs are "black boxes" (the output depends on all input values).

### Deep Neural Networks

A recent extension of ANNs that consist in ANNs with **many** hidden layers, with some ad hoc activation functions and modifications of BP algorithm.

![](https://i.imgur.com/1hSTTj3.png)

They are often used for computer vision tasks (convolutional neural network, CNN).

Continue the topic on http://neuralnetworksanddeeplearning.com/