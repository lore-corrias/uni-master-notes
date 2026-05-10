---
date: 2026-04-16
draft: true
---
# Machine Learning

We use Machine Learning when we need to design a solution to a problem that cannot be solved deterministically (i.e., by writing an algorithm that works 100% of the time). The general idea is that we can create a machine that "learns" from a dataset without devising a formal solution.

To do this, we feed the ML algorithm data under the form of "feature vectors", which are vectors with `d` elements, in the form 

$$
x = (x_1, x_2, \dots, x_d)
$$

> [!NOTE] Example of a feature vector
> 
> Say that we have an image that is black and white. To extract a feature vector `d` we might create a grid of the image consisting of $n$ pixel per square for a total of $d$ squares, obtaining a matrix. Each element of the matrix then becomes the average color of the resulting square, in the range $[0,255]$, depending on the amount of white/black in it. If we then flatten the matrix we obtain a feature vector $x$ with $d$ elements.
> 
> ![Feature Vector | center](https://i.imgur.com/K6b6mv6.png)

We can then group feature vectors containing some "patterns" into "**classes**", which are then used as classification results for our ML algorithm. We denote a class with the following notation:

$$
\Omega = \{\omega_1, \omega_2, \dots, \omega_c\}
$$

## Features

The features used to create our classes might be of two general different kinds:

* _Quantitative_: i.e., numerical, which can again be divided into
	* _Continuous valued_, like "pressure"
	* _Discrete_, like "number of citizen in a town"
* _Qualitative_: i.e., categorical, which can again be divided into
	* _Ordinal_
	* _Nominal_

We mostly use numerical features in statistical pattern classification.

Since our feature vector is a `d`-dimensional vector, we can plot it in a `d`-dimensional space, which is called a "**Feature Space**", where each axis corresponds to a certain feature.

![Feature Space | center](https://i.imgur.com/3PaAULt.png)

### Handcrafted vs Non-handcrafted

In ML algorithms the features are usually "handcrafted" from the human designer, meaning that the process for the creation of the algorithm looks like this:

![Handcrafted Features | Center](https://i.imgur.com/QS9jvwu.png)

However, as of today we can also extract **non-handcrafted features**, which are called "learned features", using **Deep Neural Networks**:

![Learned Features | center](https://i.imgur.com/b1e6DO5.png)

## Classification Model

Once our features have been extracted, we need to find a way to design a model that can use them to correctly classify our input data. Say, for example, that we have a simple problem requiring us to classify images of a sea basses and of salmons. These will be our two _classes_, but what about the feature to choose? We might say that since, generally speaking, sea basses are _longer_ than salmons, a good estimate would be to make the classification based on the length of a random variable $L$, representing the length of the fish. Our classification rule is thus:

$$
\text{if } L > L^* \text{, then fish=sea bass, else fish=salmon}
$$

$L^*$, in this case, is a "**threshold value**" that we use as a cutoff to distinguish the two classes of fishes (if the fish is longer than $L^*$ then it is likely to be a sea bass). Assuming that we do not know this value, we might want to estimate it, and we can do this by extracting it from a set of data called the "**training set**". In this case, the set would consist of images of sea basses and salmons. In formulas:

> [!INFO] Training set
> 
> $$
> D = [x_1, x_2, \dots, x_n]
> $$
> 
> where
> 
>$$
> x_i = (x_{i1}, x_{i2}, \dots, x_{id}) \text{, with } i = 1, \dots, n
>$$
>
> Meaning $x_i$ belongs to one of the $c$ classes $(x_i \in \omega_j \text{, with } j = 1,\dots,c)$

Let's say that the data from our training set can be plotted like this (the measures are the length of the fish and the number of occurrences of a class):

![Classes | center](https://i.imgur.com/4OypkYy.png)


With this data we might make an estimate using probability of $P(length / salmon)$ and $P(length / sea bass)$ to use in our decisions. 

> [!NOTE] Classification model
> 
We can generalize this method to define a classification model as a linear function:
> 
> $$
> f(x) = w^T x + b = \sum_{j=1}^d w_jx_j + b
> $$
>
> Where $w^T$ is a vector containing the "weights" to be used during our estimations, while $x$ is our features vector.

![Spam filtering | center](https://i.imgur.com/28JGtmT.png)

## Loss Function

We defined how a classification model can learn from a given dataset, but in order to define "improvement" we need to design a way for the algorithm to better itself. To do this, we define a "**loss function**" to penalize the model in case it where to make wrong estimates:

> [!INFO] Loss function
>
>$$
>L(D, \Theta) = \frac{1}{n} \sum_{i=1}^n l(y_i, f(x_i; \Theta))
>$$
>
>Where:
>	
> * $D$ is the training set, where $y_i$ being the class label for the example $x_i$
> * $f(x_i;\Theta)$ is the classification model
> * $l(y_i, f(x_i;\Theta))$ could be the zero-one loss function, which is $0$ is the prediction is correct or $1$ otherwise (for binary classification problems)

In our previous case where we defined our classification as the linear function $f(x) = w^Tx+b = \sum_{j=1}^dw_jx_j+b$, a correct prediction boils down to the estimation of the correct parameters for $w$ and $b$, which can be framed as an **optimization problem**:

> [!INFO] Optimization problem
> 
> $$
> w^*, b^* = \text{argmin}_{w,b} \frac{1}{n} \sum_{i=1}^n l(y_i, f(x_i)) + \lambda \Omega(w)
> $$
> 
> Where:
> 
> * $L(D,\Theta)$ is the **loss term**
> * $\Omega(w)$ is the **regularization term**, which imposes a penalty of variable magnitude if a prediction is wrong to avoid overfitting on more complex function
> * $\lambda$ is the **regularization hyperparameter**, which regulates the trade-off between regularization and training loss: 
> 	* Higher values $\to$ more regularized functions, larger error
> 	* Lower values $\to$ less regularized (more complex) functions, smaller error
> 
> The formula means that the research of the best values of $w^*, b^*$ equals to the research of the arguments $w, b$ for which the sum of the loss and the regularization term is the smallest possible.

The most popular optimization algorithm in ML is called **gradient descent**:

![Gradient descent | center](https://i.imgur.com/0ZoNAeT.png)

### Overfitting

Since good results of a model on the training set do not imply that the designed algorithm is actually performant, we split the available data into two distinct categories:

* The training set, so that we can measure the _training error_
* The **test** set, which contains unseen data, to measure the **generalization error**

If a model performs well on the training set but badly on the test set, then we say it is "**overfitting**".

## Kinds of ML Problems

There are several ways that a ML problem can be stated. The two most important ones are:

1. **Supervised Learning**, where the training dataset contains the labels to allow the model to clearly distinguish correctly from incorrectly classified samples.
2. **Unsupervised learning**, where the samples are not labeled. The goal here is to find groupings (called "_clusters_") of data reflecting the natural properties of the domain in question.

Other models include:

* Regression: i.e., predicting the rating that a user will assign to a film
* Tagging/multi-label classification: where we want to assign multiple labels to a sample
* Recommendation: i.e., a social media recommended algorithm
* Search and ranking: i.e., google's search engine algorithm
* Sequence learning: when there is a sequence of inputs to be mapped to a sequence of outputs, like text-to-speech, language translation, etc.
* Reinforcement learning: where the algorithm learns interacting with the environment, like in chess.

# Bayesian Decision Theory

As we've seen in our sea bass/salmon problem, classification problems can be modeled through probability theory in order to make an educated guess on our solutions. In particular, statistical machine learning is grounded on [[artificial-intelligence#Bayesian Networks|Bayesian Decision Theory]], which assumes what we just said.

Taking once again our example from before, we assumed that we do not have a way to deterministically determine what type of fish we have. In particular, we know that we have a random variable $\omega$ which identifies the class $\omega_1, \omega_2$. We say that the two classes might have the same **prior probability** (i.e., we cannot distinguish class $1$ from class $2$ in absence of any other information. Making an estimate would thus equal to a the toss of a coin):

$$
P(\omega_1) = P(\omega_2), P(\omega_1) + P(\omega_2) = 1
$$

Since we need to have $P(\omega_1) > P(\omega_2)$ to assign the fish to $\omega_1$ (or viceversa), we introduce a "length feature $x$" which can be treated as a random variable with _conditional distribution $P(x|w_i)$_.

![Conditional distribution | centered](https://i.imgur.com/AfOMeij.png)

Now we can make a rational decision by measuring the length $x$ of the fish:

$$
P(\omega_j, x) = P(\omega_j | x)p(x) = p(x | \omega_j)P(\omega_j)
$$

Which becomes the **Bayes Decision Rule** (or **MAP**: maximum a posteriori):

> [!INFO] MAP
> 
> $$
> P(\omega_j | x) = \frac{P(x | \omega_j) P(\omega_j)}{P(X)}
> $$
> 
> Which is a way to say that:
> 
> ```
> Posterior = (Likelihood * Prior) / Evidence
> ```
> 
> Also note that:
> 
> $$
> p(x) = \sum_{j=1}^2 P(x|\omega_j) P(\omega_j)
> $$

Here is an example of a monodimensional $P(\omega_i|x)$ (where we only have one variable)

![Monodimensional | center](https://i.imgur.com/8KM39yi.png)

Our criterion for choice now becomes:

* If $P(\omega_1 | x) > P(\omega_2 | x)$, then the most rational choice is to assign $x$ to $\omega_1$
	* $P(error | x) = P(\omega_2 | x)$
* If $P(\omega_2 | x) > P(\omega_1 | x)$, then the most rational choice is to assign $x$ to $\omega_2$
	* $P(error | x) = P(\omega_1 | x)$

This also minimizes the average error:

$$
P(error) = \int_{-\infty}^{+\infty}P(error, x)\ dx = \int_{-\infty}^{+\infty} P(error | x) p(x)\ dx
$$

The above equations can be rewritten in the **likelihood ratio test**:

> [!INFO] Likelihood ratio test
>
>* $\omega_1 > \omega_2$:
>	
>	$$
>	l(x) = \frac{P(x|\omega_1)}{P(x|\omega_2)} > \frac{P(\omega_2)}{P(\omega_1)} = \theta
>	$$
>
>* $\omega_2 > \omega_1$:
>
>	$$
>	l(x) = \frac{P(x|\omega_1)}{P(x|\omega_2)} < \frac{P(\omega_2)}{P(\omega_1)} = \theta
>	$$

There are two special cases:

* If $P(x|\omega_1) = P(x|\omega_2)$, the decision depends only on priors
* If $P(\omega_1) = P(\omega_2)$, the decision depends only on likelihoods

If we have more than two classes, then we need to confront all possible values:

$$
P(\omega_i | x) > P(\omega_j | x), \forall i \neq j, i = 1, \dots, c
$$

In a binary situation, we have only one threshold $\theta = \frac{P(\omega_2)}{P(\omega_1)}$, which would be the equivalent of "the maximum length of a salmon/the minimum length of a sea bass". However, having more than two classes requires us to define $n$ different thresholds $\theta_{12}, \theta_{23}, \theta_{34}, \dots, \theta_{ij}$.

![Thresholds | center](https://i.imgur.com/UnErTy7.png)

## Error Probability

Considering a problem with only two classes, we can formalize our error probability as:

$$
P(error) = P\{x \in R_2, \omega_1\} + P\{x \in R_1, \omega_2\}
$$

meaning that our error probability equals to the sum of the probabilities of erroneous labeling ($\omega_1$ while $x$ should be in $R_2$ and vice-versa). Here, $R_1$ and $R_2$ are, respectively, the areas under $\omega_1$ from $0$ to the threshold $x^*$ and the area under $\omega_2$ from $x^*$ to $+\infty$:

![Reducible error | center](https://i.imgur.com/mTxu56k.png)

In this case we have two possible thresholds:

* $x_B$ is the **optimal error**, because it minimizes the error function
* $x^*$ is a suboptimal threshold, because the difference of the areas under the two curves is not minimized (see down)

Rewriting the two terms using the MAP we obtain:

$$
P(error) = P(\omega_1)P\{x \in R_2 | \omega_1\} + P(\omega_2)P\{x \in R_1 | \omega_2\}
$$

Since $R_1, R_2$ are areas under a curve, we can rewrite them using integrals:

> [!INFO] Error function
>
>$$
>P(error) = P(\omega_1) \int_{R_2}P(x | \omega_1)\ dx + P(\omega_2) \int_{R_1}P(x | \omega_2)\ dx 
>$$

Going back to the above picture: if we take $x^*$ as a threshold, the sum of the two integrals does not have the smallest value possible. This means that our threshold is not the best possible one, which would instead be $x_B$. In most cases, estimating the optimal threshold providing the Bayes error is also **impossible** to estimate.

If we plug into our equation a number of classes $>2$, the error calculation gets very complicated, very fast (we need to compute multidimensional integrals and complex analytical forms of density functions). To simplify this calculation, it is often faster to estimate the error probability using the probability of correct classification:

$$
P(correct) = \sum_{i=1}^c P\{x \in R_i, \omega_i\} = \sum_{i=1}^c P_iP\{x \in R_i | \omega_i\} = \sum_{i=1}^cP_i \int_{R_i}P(x|\omega_i)\ dx
$$

so we have just

$$
P(error) = 1 - P(correct)
$$

The only exception to this rule of thumb is when the [[artificial-intelligence#Random Variables and Probability Distribution Functions|probability density function]] is the Gaussian.

> [!HELP] Homework exercise
> 
> We have a city of 1 million inhabitants with 100 terrorists and 999.900 non-terrorists. We can say that the _prior probability_ of a citizen being a terrorist ($P(\omega_1)$) is $0.0001$, while that of a citizen not being a terrorist ($P(\omega_2)$) is $0.9999$. The city wants to catch the terrorists and installs cameras that have two failure rates of $1\%$, meaning:
> 
> * If the camera sees a terrorist, it will ring $99\%$ of the time, but mistakenly ring $1\%$ of them ($1\%$ of false negatives) 
> * If the camera sees a non-terrorist, it will _not_ ring $99\%$ of the time, but mistakenly ring $1\%$ of them ($1\%$ of false positive) 
>   
> What is the chance that, if an alarm rings, the camera saw a terrorist?

> [!HELP] Homework exercise solution
> 
> We can frame the exercise as a binary classification problem with two classes: $\omega_1$ being that of the terrorists and $\omega_2$ being that of the non-terrorists. The question amounts to finding the value of $P(\omega_1 | x)$, which we can rewrite as:
> 
> $$
> P(\omega_1 | x) = \frac{P(x | \omega_1)P(\omega_1)}{P(x)}
> $$
> 
> We already know that the _a priori_ probability of a citizen being a terrorist is $P(\omega_1) = 0.0001$, while the value of $P(x | \omega_1)$ is just the success rate of the two cameras, which is $0.99$.
> 
> In order to calculate $P(x)$ we can use the law of total probability:
> 
> $$
> P(x) = \sum_{i=1}^2 P(x|\omega_i) P(\omega_i) = P(x|\omega_1) P(\omega_1) + P(x|\omega_2) P(\omega_2)
> $$
> 
> We already have the value of $P(x | \omega_1)$. In order to calculate $P(x | \omega_2)$ we might either compute $P(x | \omega_2) = 1 - P(x | \omega_1)$ (since we only have two classes), or just get it from the text of the problem, since the value amounts to the rate of false-negatives of the camera, which is $0.01$. Our final value of $P(x)$ is thus:
> 
> $$
> P(x) = 0.99 \times 0.0001 + 0.01 \times 0.9999 \approx 0.010098
> $$
> 
> If we plug all our variables in the equation we finally get:
> 
> $$
> P(\omega_1 | x) = \frac{P(x|\omega_1)}{P(\omega_1)}{P(x)} = \frac{0.99 \times 0.0001}{0.010098} \approx 0.0098
> $$
> 
> This means that even though the cameras have a $99\%$ accuracy, the chance of catching an actual terrorist is less than $1\%$, since the terrorists are such a small subset of the population.

The two values $R_1, R_2$ that we described above are called "decision regions", while the whole space is called "decision space" $R$. In particular we have that

$$
R \to \begin{cases} R_1 = \{x \in R: & l(x) > \theta\} \\ R_2 = \{x \in R: & l(x) < \theta\} \end{cases}
$$

If we take the Gaussian distribution as an example, we have the following decision regions:

![Gaussian | centered](https://i.imgur.com/Bo9GvwV.png)

### Discriminant Functions

An alternative vision to decision regions are **discriminant functions**, which can be formalized as:

> [!info] Discriminant Function
> 
> $$
> \omega_i \text{ if } g_i(x) > g_j(x), j \neq i
> $$

There are different possible functions that we can use as discriminant:

$$
g_i(x) = P(\omega_i / x) = \frac{P(x/ \omega_i)P(\omega_i)}{\sum_{j=1}^c p(x/\omega_j)P(\omega_j)}
$$

$$
g_i(x) = P(x/\omega_i)P(\omega_i)
$$

$$
g_i(x) = \ln(P(x / \omega_i)) + \ln(P(\omega_i))
$$

Discriminant functions subdivide the space into $c$ decision regions, $R_1, \dots, R_c$. The link between decision regions and discriminant functions is that if $g_i(x) > g_j(x)$ for any $j \neq i$, then $x \in R_i$ and the sample is assigned to class $\omega_i$. The regions where $g_i(x) = g_j(x)$ are called "**decision boundaries**". Here's an example of a three-dimensional probability density functions with the outlined decision regions and boundaries.

![Decision boundaries | centered](https://i.imgur.com/RBYkm9c.png)

### Risk

In the error probability theory we just expressed, "all errors are equal". If we consider some applications in the real world, however, it is easy to understand why we might want to make some errors more "costly" than others. For example, if we built a classifier to recognize poisonous mushrooms, the **risk** we incur from eating a mushroom that was misclassified as "non-poisonous" would be extremely high, compared to that of not-eating a mushroom misclassified as "poisonous". To introduce the notion of "risk", we can multiply the probabilities of the two classes by a risk factor.

For example, say that the actions for a mushroom are $\alpha_1 = \text{eat}$ and $\alpha_2 = \text{discard}$:

$$
R(\alpha_1 = \text{eat}/x) = 0.2 \times \infty  + 0.8 \times 0 = \infty
$$

$$
R(\alpha_2 = \text{discard}/x) = 0.2 \times 0  + 0.8 \times 1 = 0.8
$$

Here, $R$ is the expected risk for a class. We can then use this notion to formulate a new classification theory, named "**Minimum Risk Theory**".

> [!INFO] Minimum Risk Theory
> 
> Given a set of dataclasses
> 
> $$
> \Omega = \{\omega_1, \omega_2, \dots, \omega_c\}
> $$
> 
> And a set of actions/decisions (which, in pattern classifications, equals to the decision about the class of the pattern)
> 
> $$
> A = \{\alpha_1, \alpha_2, \dots, \alpha_a\}
> $$
> 
> And a loss matrix, which associates to each possible action/classification the cost of misclassification
> 
> $$
> \Lambda =  \begin{pmatrix}
> \lambda(\alpha_1\ |\ \omega_1) & \lambda(\alpha_1\ |\ \omega_2) & \dots & \lambda(\alpha_1\ |\ \omega_c) \\ 
> \lambda(\alpha_2\ |\ \omega_1) & \lambda(\alpha_2\ |\ \omega_2) & \dots & \lambda(\alpha_2\ |\ \omega_c) \\
> \dots & \dots & \dots & \dots \\
> \lambda(\alpha_a\ |\ \omega_1) & \lambda(\alpha_a\ |\ \omega_2) & \dots & \lambda(\alpha_a\ |\ \omega_c) \end{pmatrix}
> $$
> 
> A classifier following the _minimum risk decision rule_ follows the strategy of picking the classification class that has the lowest **conditional risk**, associated with action $\alpha_i$:
> 
> $$
> R(\alpha_i\ |\ x) = \sum_{j=1}^c \lambda(\alpha_i\ |\ \omega_j)P(\omega_j\ |\ x) = E_{\omega \in \Omega}\{\lambda(\alpha_i\ | \omega)\ |\ x\}
> $$

If we have a binary classification problem where `action=classification`, we have two classes and $\lambda_{ij}=\lambda(\omega_i\ |\ \omega_j)$ as the loss of misclassification as $\omega_i$ instead of $\omega_j$. So we have the risks as:

$$
R(\omega_1/x) = \lambda_{11}P(\omega_1/x) + \lambda_{12}P(\omega_2/x)
$$

$$
R(\omega_2/x) = \lambda_{21}P(\omega_1/x) + \lambda_{22}P(\omega_2/x)
$$

Following the MRT, we have:

$$
x \in \omega_1 \text{ if } R(\omega_1\ |\ x) < R(\omega_2\ |\ x), \text{ else } x \in \omega_2
$$

or, in terms of _posterior_ probability

$$
x \in \omega_1 \text{ if } (\lambda_{21}-\lambda_{11})P(\omega_1\ |\ x) > (\lambda_{12}-\lambda_{22})P(\omega_2\ |\ x)
$$

We can rewrite this expression using Bayes rule:

$$
x \in \omega_1 \text{ if } (\lambda_{21}-\lambda_{11})P(x\ |\ \omega_1)P(\omega_1) > (\lambda_{12}-\lambda_{22})P(x\ |\ \omega_2)P(\omega_2)
$$

We can also rewrite this rule using the likelihood ratio:

$$
x \in \omega_1 \text{ if } l(x) = \frac{p(x\ |\ \omega_1)}{p(x\ |\ \omega_2)}>\frac{(\lambda_{12}-\lambda_{22})}{(\lambda_{21}-\lambda_{11})} \frac{P(\omega_2)}{P(\omega_1)} = \theta
$$

We can read this as "_The true class is $\omega_1$ if the likelihood ratio is higher that a threshold $\theta$ not depending on $x$"_.

For binary classification problems, we can assign the misclassification cost with a simple loss function:

$$
\lambda(\alpha_i, \omega_i) = \begin{cases}
0 & \text{if } i = j \\
1 & \text{if } i \neq j
\end{cases}
$$

In this case, the risk is exactly equal to the error probability, which makes the MRT equal to the MAP (maximum a posteriori probability).

$$
\theta_\lambda = \frac{\lambda_{12}-\lambda_{22}}{\lambda_{21}-\lambda_{11}} \to x \in \omega_1 \text{ if } \frac{p(x\ |\ \omega_1)}{p(x\ |\ \omega_2)} > \theta_\lambda
$$

As for decision regions, a region $R_i$ becomes smaller if errors for class $\omega_i$ are larger:

![Decision regions for MRT | center](https://i.imgur.com/kbiLZ3x.png)

In this case:

- If $P(\omega_1) = P(\omega_2)$ and $\lambda_{12} = \lambda_{21} = 1$, we have the threshold $\theta_a$
- If $\lambda_{12} > \lambda_{21}$, we have $\theta_b$.

> [!HELP] Example
> 
> Say that we want to discriminate between legitimate ($\omega_N$) and malicious ($\omega_{INT}$) traffic. We want to use a single feature $x$ and assume that we can model the network traffic as follows:
> 
> * $P(\omega_N) = P(\omega_{INTR}) = \frac{1}{2}$
> * $P(x\ |\ \omega_i) = \frac{1}{\sqrt{2 \pi} \sigma} exp[-\frac{1}{2}(\frac{x - \mu_i}{\sigma})^2]$
> * $\mu_N = 0$, $\mu_{INTR} = 4$, $\sigma_N = \sigma_{INTR} = 1$.
> * The cost of missing a detection of intrusion is ten times higher than the opposite error.
>   
> a) _Find the decision regions using the likelihood ratio test, without considering the cost of errors, and compute the total error probability._
> 
> We can start by determining $\theta$:
> 
> $$
> \theta = \frac{P(\omega_{INTR})}{P(\omega_N)} = \frac{1/2}{1/2} = 1
> $$
> 
> Now, if we want to calculate the likelihood ratio, we need to compute:
> 
> $$
> l(x) = \frac{P(x\ |\ \omega_N)}{P(x\ |\ \omega_{INTR})}
> $$
> 
> By using the ratio between exponential property, we can write this as:
> 
> $$
> l(x) = exp[\frac{1}{2}((\frac{x-4}{1})^2 - (\frac{x-0}{2})^2)] = exp[\frac{1}{2}(x^2 + 16 - 8x - x^2)] = exp[8 - 4x]
> $$
> 
> Now, since we know that $l(x) = \theta$, we have:
> 
> $$
> exp[8 - 4x] = 1 \to 8 - 4x = \ln(1) \to x_b = 2
> $$
> 
> Now we know that $l(x) > \theta \implies x < x_b$. Now we need to compute the total error function:
> 
> $$
> P\{x \in R_N, x \in \omega_{INTR}\} + P\{x \in R_{INTR}, x \in \omega_N\}
> $$
> 
> which equals to:
> $$
> P\{x \in R_N\ |\ \omega_{INTR}\}P(\omega_{INTR}) + P\{x \in R_{INTR}\ |\ \omega_N\}P(\omega_N)
> $$
> 
> Since the total error equals to the area under the curve of $P(x\ |\ \omega_i)$ in the segment of a decision region, we can rewrite this formula using integrals:
> 
> $$
> \int_{-\infty}^{x^*} P(x\ |\ \omega_{\text{INTR}}) P(\omega_{\text{INTR}}) dx + \int_{x^*}^\infty P(x\ |\ \omega_{\text{N}}) P(\omega_{\text{N}}) dx
> $$
> 
> which amounts to:
> 
> $$
> \frac{1}{2}[\frac{1}{\sqrt{2\pi}} \int_{-\infty}^2 exp[-\frac{1}{2}(x-4)^2] dx + \int_2^\infty \frac{1}{\sqrt{2\pi}} exp[-\frac{1}{2}(x)^2] dx]
> $$
> 
> Our probability function is the [Normal Distribution](https://en.wikipedia.org/wiki/Normal_distribution), where $\sigma$ is the standard deviation and $\sigma^2$ is the variance, while $\mu$ is the mean of the distribution. The cumulative distribution function of the Gaussian is represented by the following function:
> 
> $$
> \Phi(x) = \frac{1}{\sqrt{2\pi}}\int_{-\infty}^x e^{-t^2/2} dt
> $$
> 
> Which measures the probability of a random variable to fall in the range $[-\infty, x]$, or better $P(X \leq x)$. Since the values of the CDF of the Gaussian are tabulated, we can solve our integrals by rewriting them in the normal form, and then lookup their values in a [Z-Table](https://math.arizona.edu/~rsims/ma464/standardnormaltable.pdf). Our second integral is already in its normal form, so we can rewrite the first one by substituting $t = (x-4)$:
> 
> $$
> \frac{1}{2}[\frac{1}{\sqrt{2\pi}} \int_{-\infty}^2 exp[-\frac{1}{2}(t)^2] dt + \int_2^\infty \frac{1}{\sqrt{2\pi}} exp[-\frac{1}{2}(x)^2] dx]
> $$
> 
> We can then substitute the actual values ($-2$ and $2$, because from the first one we got $t = x - 4 \to x = -2$) and get:
> 
> $$
> \frac{1}{2}[0.0228 + 0.0228] = 0.0228
> $$
> 
> Which is our final total error probability.
> 
> On a side note: the cumulative distrubution function of the Gaussian is related to the [Error Function](https://en.wikipedia.org/wiki/Error_function), which measures, for a Guassian with $\mu = 0, \sigma^2 = \frac{1}{2}$, the probability of a random variable falling in the range $[-x,x]$. In particular, the relation between the Gaussian ($\Phi(x)$) and the error function is the following:
> 
> $$
> \Phi(x) = \frac{1}{2}[1 + erf(\frac{x}{\sqrt{2}})]
> $$
> 
> _b) Specify the loss (cost) matrix that satisfies the assumption: the cost of missing the detection of intrusion be ten times higher than the opposite error (a normal traffic is wrongly recognized as an intrusion)._
> 
> We need to write a loss matrix $\Lambda$ and indicate with $\lambda_{N, \text{Intr}}$ the cost of when the traffic is _intrusive_, but classified as normal, and vice versa, respectively. Any loss matrix in this form is a correct solution:
> 
> $$
> \Lambda = \begin{pmatrix}
> \lambda_{N,N} & \lambda_{N,\text{Intr}}\\ 
> \lambda_{\text{Intr}, N} & \lambda_{\text{Intr},\text{Intr}}
> \end{pmatrix} = \begin{pmatrix}
> 0 & \lambda_{N,\text{Intr}}\\ 
> \lambda_{\text{Intr}, N} & 0
> \end{pmatrix} = \begin{pmatrix}
> 0 & N \times 10 \\ 
> N & 0
> \end{pmatrix}
> $$

> [!HELP] Exercise
> 
> _1) find the decision regions that minimize the risk, and compute the related classification error._
> 
> This case is different from the example one, because here $\lambda_{\text{Intr}, N} = 10 \times \lambda_{N, \text{Intr}}$. This means that our $\theta$ has to be computed again, this time keeping in hand our costs:
> 
> $$
> \theta = \frac{\lambda_{\text{Intr}, N}-\lambda_{\text{Intr}, \text{Intr}}}{\lambda_{N, \text{Intr}}-\lambda_{N, N}} \frac{P(\omega_{\text{Intr}})}{P(\omega_{N})} = 10
> $$
> 
> Previously we calculated $l(x) = exp[8-4x]$. Now, since $l(x) = \theta$, we have:
> 
> $$
> exp[8-4x] = 10 \to x = \frac{8 - \ln{10}}{4}
> $$
> 
> This means that when $l(x) > \theta \to x < \frac{8 - \ln{10}}{4}$.  To find the total classification error, we just rewrite the same integrals as before, but this time substituting the value for $x_b = \frac{8 - \ln{10}}{4}$ as our integration extreme
> 
> $$
> \frac{1}{2}[\frac{1}{\sqrt{2\pi}} \int_{-\infty}^{1.424} exp[-\frac{1}{2}(x-4)^2] dx + \int_{1.424}^\infty \frac{1}{\sqrt{2\pi}} exp[-\frac{1}{2}(x)^2] dx]
> $$
> 
> We can follow the same procedure of the example and find the values for $1.424 - 4 = -2.576$ and $-1.424$:
> 
> $$
> \frac{1}{2}[0.0049 + 0.0778] = 0.0827
> $$
> 
> _2)Explain why the decision regions are changed with respect to the use of the the likelihood ratio test, without considering the costs of errors. Why this change?_
> 
> The decision regions shifted because of the change in the value of $\theta$ from $1$ to $10$. If we represent the two distributions as two Gaussians, we have a graph like this:
> 
> ![Gaussians | center](https://i.imgur.com/Z2L6slI.png)
> 
> The green line represents the boundary after the change of $\theta$: the decision region $R_{INTR}$ increased because the cost of missing an intrusion became higher, because a higher $\theta$ makes the classifier require stronger evidence before marking the traffic as legitimate.
> 
> _3) Explain why the two components of the total error are changed with respect to the use of the the likelihood ratio test, without considering the costs of errors. Why this change?_
> 
> As explained in the previous question, the shift of the boundary caused the region $R_{INTR}$ to become bigger. This, in turn, has the effect of changing the components of the total error:
> 
> $$
> P(x \in R_N\ |\ \omega_{INTR}) \cdot P(\omega_{INTR}); P(x \in R_{INTR}\ |\ \omega_N) \cdot P(\omega_N)
> $$
> 
> Since a change in the value of $\theta$ provokes a shift of the midpoint between the two distributions ($x^*$), this also provokes a change in the sum of the two integrals that represent the total error. In this particular case, the change of $\theta$ makes the boundary move left towards the region $R_{INTR}$, reducing the value of $P(x \in R_N\ |\ \omega_{INTR}) \cdot P(\omega_{INTR});$ (the rate of missed detections, as the classifier became more aggressive). On the other hand, since the boundary moved left, the value of $P(x \in R_{INTR}\ |\ \omega_N) \cdot P(\omega_N)$ (which represents the rate of false alarms) increased.

## Reject Option

As we saw, it is possible to design a machine learning algorithm that minimizes the Bayes error. But for some applications, we might want to achieve a result that is as close to zero as possible (i.e., we would like to have a "false negative" rate equal to zero for medical screening.).

The most straightforward strategy we can implement to achieve this goal is to introduce an additional decision region which would represent an arbitrary "rate of uncertainty" in our estimation, where samples are simply **rejected** (i.e., the model refuses to make a classification to avoid misclassifications). This means that we now have two sets:

- A set of classes: $\Omega = \{\omega_1, \omega_2, \dots, \omega_c\}$
- A set of actions/decisions: $A = \{\alpha_0, \alpha_1, \dots, \alpha_a\}$
	- However, if our action is a _classification_, we have: $A = \{\omega_0, \omega_1, \dots, \omega_c\}$ (we introduce an additional $\omega_0$ class representing rejections).

Also, our loss matrix $\Lambda$ now has an additional row (size $(c+1)x c$):

$$
\Lambda = \begin{pmatrix}
  \lambda(\omega_0\ |\ \omega_1) & \lambda(\omega_0\ |\ \omega_2) & \dots & \lambda(\omega_0\ |\ \omega_c) \\ 
  \lambda(\omega_1\ |\ \omega_1) & \lambda(\omega_1\ |\ \omega_2) & \dots & \lambda(\omega_1\ |\ \omega_c) \\
  \dots & \dots & \dots & \dots \\
  \lambda(\omega_c\ |\ \omega_1) & \lambda(\omega_c\ |\ \omega_2) & \dots & \lambda(\omega_c\ |\ \omega_c)
\end{pmatrix}
$$

> [!INFO] Minimum Risk Decision Criterion (with reject)
> 
> $$
> x \to \omega_i \iff R(\omega_i\ |\ x) < R(\omega_j\ |\ x) \forall i \neq j, i=0,1,\dots,c
> $$
> 
> This also incorporates the possibility of having a "rejection" if:
> 
> $$
> R(\omega_0\ |\ x) < R(\omega_j\ |\ x) \forall j \neq 0
> $$

### Decision Regions with Rejection

Say we have a binary classification where:

$$
\text{Reject cost } = \lambda_r; \text{Error cost } = \lambda_e; \text{Correct classification cost } = \lambda_c \text{ (usually = 0)};  
$$

and all costs are equal:

$$
\Lambda = \begin{pmatrix}
  \lambda_r & \lambda_r \\ 
  \lambda_c & \lambda_e \\
  \lambda_c & \lambda_e
\end{pmatrix} = \begin{pmatrix}
  \lambda(\omega_0\ |\ \omega_1) & \lambda(\omega_0\ |\ \omega_2) \\ 
  \lambda(\omega_1\ |\ \omega_1) & \lambda(\omega_1\ |\ \omega_2) \\
  \lambda(\omega_2\ |\ \omega_2) & \lambda(\omega_2\ |\ \omega_1)
\end{pmatrix}
$$

This means that we have three regions:

$$
R = \begin{cases}
R_0 \text{ (the reject region)}  & = \{x \in R : R(\omega_0\ |\ x\} < R(\omega_j\ |\ x) \forall j \neq 0\} \\
R_1 \text{ (the } \omega_1\text{ region)} & = \{x \in R : R(\omega_1\ |\ x\} < R(\omega_j\ |\ x) \forall j \neq 1\} \\
R_1 \text{ (the } \omega_2\text{ region)} & = \{x \in R : R(\omega_2\ |\ x\} < R(\omega_j\ |\ x) \forall j \neq 2\}
\end{cases}
$$

![Reject option | center](https://i.imgur.com/2vCKOHo.png)

We can picture the rejection region as that region where the posterior probabilities for both classes are too low (lower than a threshold $\theta$, to be precise) to make a "reasonable guess". All samples that end up in this decision region are thus classified as "rejected", meaning the model cannot make a classification, as it is too uncertain about class membership.

More specifically, the reject region is the one in which the largest of the posterior probabilities $P(\omega_k\ |\ x)$ is significantly less than unity (in the figure that would be the blue line on the left and the red line on the right of their intersection point); or equivalently where the joint distribution $P(x, \omega_k)$ for both classes have similar values.

![Reject region 2 | center](https://i.imgur.com/vR3QbSC.png)

We can now reduce the error probability by making the rejection threshold $T$ bigger (as the rejection region is the one in which errors accumulate). When $R_0$ contains all misclassified patterns, the error becomes $0$.

We can find the optimal value for $T$ using **Chow's rule**:

> [!info] Chow's rule
> 
> $$
> \text{ if } \max_i P(\omega_i\ |\ x) \geq T \to x \in \omega_i \text{, otherwise reject } x \text{ with } T = \frac{\lambda_e - \lambda_r}{\lambda_e - \lambda_c}
> $$

Here, $T$ is the **reject threshold**, with $T \in [0,1]$. When $T=0$ (meaning $\lambda_e=\lambda_r)$, we have the classical MAP rule.

![Examples of error-reject trade-off | center](https://i.imgur.com/dV4Pi6O.png)

> [!HELP] Example
> 
> Suppose we want to diagnose a disease by the amount of a certain substance in the blood (people with a disease have a higher amount of this substance). The prior probability of a person being healthy/sick is:
> 
> $P(\omega_{\text{healthy}}) = 0.85; P(\omega_{\text{sick}}) = 0.15$
> 
> We also have $\mu_h = 4; \mu_s=8$ as the average amount of this substance for healthy ans dick people respectively. We can represent the amount of substance in the two cases as a Gaussian normal distribution with $\sigma=1$:
> 
> $$
> P(x\ |\ \omega_i) = N(\mu_i, \sigma^2); i=1 \text{ healthy, } i=2 \text{ sick}
> $$
> 
> We need to introduce a reject region for samples that are too ambiguous to classify. To reduce the Bayes error, we need to minimize this region $T$ using Chow's law. We start by defining our loss matrix:
> 
> $$
> \Lambda = \begin{pmatrix}
> \lambda_R & \lambda_R \\ 
> \lambda_{SS} & \lambda_{SH} \\
> \lambda_{HS} & \lambda_{HH}
> \end{pmatrix} = \begin{pmatrix}
> 0.3 & 0.3 \\
> 0 & 1 \\
> 1 & 0
> \end{pmatrix}
> $$
> 
> In particular, we assign a cost to misclassification $=1$ for both false negative and false positives, while the cost of rejection is a bit smaller, $0.3$. We can calculate the threshold $T$ as the ratio between the differences of the error cost and the rejection cost and that between the error cost and the correct classification cost:
> 
> $$
> T = \frac{\lambda_E-\lambda_R}{\lambda_E-\lambda_C} = \frac{1-0.3}{1}=0.7
> $$
> 
> We know that the reject region is the one in which the posterior probability of a sample being assigned to a class is less than $T$:
> 
> $$
> \max[P(\omega_i\ |\ x)] < T
> $$
> 
> Since we have two classes, the decision region will have two boundaries, $[x_{S1}, x_{S2}]$. In order to compute these values, we need to solve the two inequalities:
> 
> $$
> x_{S1} \to P(\omega_1\ |\ x) < T
> $$
> 
> We start by rewriting the posterior probability using Bayes rule:
> 
> $$
> \frac{P(x\ |\ \omega_1)P(\omega_1)}{P(x)} < T
> $$
> 
> We can then use the sum rule to rewrite $P(x)$:
> 
> $$
> \frac{P(x\ |\ \omega_1)P(\omega_1)}{P(x\ |\ \omega_1)P(\omega_1) + P(x\ |\ \omega_2)P(\omega_2)} < T
> $$
> 
> We can then revert the two sides so that we can simplify the inequality
> 
> $$
> \frac{P(x\ |\ \omega_1)P(\omega_1) + P(x\ |\ \omega_2)P(\omega_2)}{P(x\ |\ \omega_1)P(\omega_1)} < \frac{1}{T} \implies 1 + \frac{P(x\ |\ \omega_2)}{P(x\ |\ \omega_1)} \cdot \frac{P(\omega_2)}{P(\omega_1)} \frac{1}{T}
> $$
> 
> Now that we have reduced every term to its fundamental, we can rewrite $P(x\ |\ \omega_i)$ knowing that 
> 
> $$
> P(x\ |\ \omega_i) = \frac{1}{\sqrt{2\pi}\sigma}exp[-\frac{1}{2}(\frac{x-\mu_i}{\sigma})^2]
> $$
> 
> Since our probabilities follow a normal distribution. If we substitute this value to the previous equation and apply all possible simplifications/expansions, we get:
> 
> $$
> \frac{P(x\ |\ \omega_2)}{P(x\ |\ \omega_1)} = exp[\frac{1}{2}(x^2-8x+16)-\frac{1}{2}(x^2-16x+64)] = exp[4x-24]
> $$
> 
> If we go back to our inequality, we get:
> 
> $$
> exp[4x-24] > \frac{1}{T} - 1 \implies exp[4x-24] > \frac{17}{7} \implies 4x - 24 > \ln(\frac{17}{7}) \implies x > 6 + \frac{1}{4}\ln(\frac{17}{7})
> $$
> 
> Finally, we can calculate the value of $x_{S1}$ as:
> 
> $$
> x_{S1} = 6 + \frac{1}{4} \ln(\frac{17}{7}) \approx 6.2218
> $$
> 
> We can follow the same exact process for the value of $x_{S2}$ and get:
> 
> $$
> x_{S2} = 6 - \frac{1}{4} \ln(\frac{9}{119}) \approx 6.6455
> $$
> 
> We can now make a final graph with all the regions mapped:
> 
> ![Example rejection | center](https://i.imgur.com/kkOVmF8.png)
> 
> Now that we have our two boundaries, we can compute the total error and reject probabilities. The false positive rate can be calculated as the integral from $x_{S2}$ to $\infty$ of our healthy probability distribution function:
> 
> $$
> \int_{x_{S2}}^\infty P(x\ |\ \omega_h) P(\omega_h) dx
> $$
> 
> If we inspect the graph, we can see that the integral amounts to the value of the cumulative distribution function of the gaussian distribution from $x_{S2} \approx 6.65$, which is basically the "right tail" of our gaussian distribution (which contains all the sample misclassified as "healthy". As we said in the previous example of a normal distribution, the values of the CDF of the Gaussian are tabluated in Z-Tables, meaning we can look up its value for $x = 6.65$, which amounts to:
> 
> $$
> \int_{x_{S2}}^\infty P(x\ |\ \omega_h) P(\omega_h) dx \approx 3.45 \times 10^3
> $$
> 
> We can make an analogous reason to compute the false negative rate, which in this case is the area under the "left tail" of our distribution function from $x_{S1}$ to $-\infty$:
> 
> $$
> \int_{-\infty}^{x_{S1}} P(x\ |\ \omega_s)P(\omega_s) dx \approx 5.65 \times 10^{-3}
> $$
> 
> The total error probability amounts to the sum of $FP + FN = 9.12 \times 10^{-3}$. We have successfully lowered the Bayesian error, but we now also have a reject ratio to consider (which is given by the sum of the areas under the two curves in the green region of the graph):
> 
> $$
> \int_{x_{S1}}^{x_{S2}} P(x\ |\ \omega_s)P(\omega_s) dx + \int_{x_{S1}}^{x_{S2}} P(x\ |\ \omega_h)P(\omega_h) dx \approx 15.22 \times 10^{-3}
> $$
> 
> This means that, out of 1000 patients, we refuse to classify (reject) an average of around 15 people.

> [!HELP] Exercise 1
> 
> _1) Using the MAP decision rule, compute separately the two error probabilities for the two classes $\omega_h$ and $\omega_s$, and then the total (minimum) error probability._
> 
> We can compute the total error probability as the sum of the integrals of the left and right tail of the two gaussian functions from the boundary point $x_b$.
> 
> We start by finding $\theta$:
> 
> $$
> \theta = \frac{P(\omega_2)}{P(\omega_1)} \approx 0.176
> $$
> 
> We can then find $x_b$ by equating $l(x) = \theta$:
> 
> $$
> l(x) = \theta \implies \frac{P(x\ |\ \omega_2)}{P(x\ |\ \omega_1)} = \theta 
> $$
> 
> We already know that $l(x) = epx[4x-24]$ from the example above, meaning that:
> 
> $$
> exp[4x-24] = 0.176 \implies x_b = \frac{\ln(0.176)+24}{4} \approx 5.565
> $$
> 
> This means that we have the following graph:
> 
> ![Example MAP | center](https://i.imgur.com/BK4PZom.png)
>
> We can now proceed to the computation of the total error (we look up the values of the integrals on the Z-Table as we did before):
> 
> $$
> \int_{x_b}^\infty P(x\ |\ \omega_1)P(\omega_1) + \int_{-\infty}^{x_b} P(x\ |\ \omega_2)P(\omega_2)
> $$
> 
> $$
> \int_{x_b}^\infty \frac{1}{\sqrt{2\pi}} exp[-\frac{1}{2}(x-4)^2] dx + \int_{-\infty}^{x_b} \frac{1}{\sqrt{2\pi}} exp[-\frac{1}{2}(x - 8)^2] dx 
> $$
> 
> $$
> \text{ with } t = x-4, u = x-8,\ \int_{x_b}^\infty \frac{1}{\sqrt{2\pi}} exp[-\frac{1}{2}t^2] dt + \int_{-\infty}^{x_b} \frac{1}{\sqrt{2\pi}} exp[-\frac{1}{2}u^2] du
> $$
> 
> $$
> P(X \geq t) + P(X \leq u) = P(X \geq x_b - 4) + P(X \leq x_b - 8) = P(X \geq 1.565) + P(X \leq -2.435)
> $$
> 
> $$
> P(X \geq 1.565) + P(X \leq -2.435) = (1 - 0.9418) + 0.0075 = 0.0657
> $$
> 
> _2) Explain how and why the above error probabilities are different from the ones that we have computed with the reject option._
> 
> The reason why the above error probabilities are different from the ones with the reject option is related to the fact that the removal of the reject region "redistributed" that area to the error regions. This happens because the boundary value is now only one, $x_b$, and thus the two "error tails" of the Gaussian distributions are longer, as can be seen from the graph above. In particular, the healthy distribution is longer, since $x_b \approx 5.565$, while the reject region's left boundary was $x_1 \approx 6.22$; this is also the case for the sick distribution's error tail, since $x_b < x_2 \approx 6.65$. This makes the total error increase.

> [!HELP] Exercise 5
> 
> TODO

# Gaussian Classifier

Machine learning models are called "**generative**" if they assume to know the _parametric form_ of the distribution of $P(x\ |\ \omega_i)$, and are able to model the joint probability distribution $P(x,\omega_i)$ to design the pattern classifier. The most famous classifier is the **Gaussian Classifier**.

The Gaussian Classifier is based on the _Gaussian Distribution_ (or normal distribution). In its mono-dimensional shape, we have:

$$
P(x\ |\ \omega_i) = N(\mu, \sigma)
$$

The Gaussian distribution is so widely used because a lot of natural phenomena follow it, but more importantly because of the _Central Limit Theorem_, which states that the sum of $N$ independent random variables will eventually lead to a Gaussian distribution for $N \to \infty$.

> [!INFO] Gaussian distribution Properties:
> 
> A Gaussian (or normal) distribution (in its one-dimensional case, that is if the independent variable measured is only one) can be represented by the following formula:
> 
> $$
> P(x) = N(\mu, \sigma) = \frac{1}{\sqrt{2\pi}}exp[-\frac{1}{2}(\frac{x-\mu}{\sigma})^2]
> $$
> 
> Where:
> 
> - $\mu = \int_{-\infty}^\infty x \cdot p(x) dx$, and is called the "_mean_" or "_expectation_" of the distribution.
> - $\sigma = \int_{-\infty}^\infty (x-\mu)^2 \cdot p(x) dx$ is the _variance_, and is a measure of "how far" the distribution spreads
> 
> In its multidimensional case:
> 
> $$
> p(x) = \frac{1}{(2\pi)^{d/2}|\Sigma|^{1/2}}exp[-\frac{1}{2}(x-\mu)^t \Sigma^{-1}(x - \mu)]
> $$
> 
> Where:
> 
> - $\mu = \int_{-\infty}^\infty x \cdot p(x) dx$
> 	- Both $x$ and $\mu$ are _column vectors_ with $d$ components
> - $\Sigma = \int_{-\infty}^\infty (x-\mu)(x-\mu)^t p(x) dx$ is called the **covariance matrix**, with dimensions $d \times d$
> 	- $|\Sigma|$ and $\Sigma^{-1}$ are its determinant and inverse
> 	- $\Sigma$ is a symmetric matrix: $\Sigma = \Sigma^t$
> 	- $\Sigma$ is a semi-positive definite matrix, but to have a well-defined Gaussian PDF, $\Sigma$ must be **positive definite**
> - $\sigma_{ij} = \int_{-\infty}^{\infty} (x_i-\mu_i)(x_j-\mu_j)$ are the terms of the _covariance matrix_.
> 	- If $\sigma_{ij}=0$, then the random variables $x_i,x_j$ are uncorrelated and independent
> 	- If $\sigma_{ij}=0$ for all $i \neq j$ (meaning that $\Sigma$ is a diagonal matrix), we have $P(x) = P(x_1)P(x_2)\dots P(x_d)$
> 		
> 	

> [!HELP] Positive definite
> 
> A matrix $M$ is positive definite if, for all non-zero $x \in R^n$, it holds:
> 
> $$
> x^t Mx > 0
> $$
> 
> It is semi-positive if $x^t Mx \geq 0$.

> [!HELP] Covariance matrix
> 
> The covariance matrix can be thought as a generalization of the $\sigma^2$ term for mono-dimensional normal distributions. As an example, take the following two-dimensional matrix in the form:
> 
> $$
> \Sigma = \begin{pmatrix}
> \sigma_{11} & \sigma_{12} \\ 
> \sigma_{21} & \sigma_{22}
> \end{pmatrix}
> $$
> 
> The elements on the diagonal represent the variance of each feature $x_1, x_2$. The other elements, instead, represent the variance between the different features. That is why we can tell that variables are independent if $\Sigma_{ij} = 0$ (because there is no variance between them).
> 
> In the following image:
> 
> ![Covariance example | center](https://i.imgur.com/Ai04XrN.png)
> 
> We can see that the covariance term $\sigma_{xy}$ is positive, because an increase of $x$ generally implies an increase of $y$. Furthermore, $P_{xy} = \frac{\sigma_{xy}}{\sigma_x\sigma_y}$, and since $\sigma_x,\sigma_y$ are positive, the correlation is also positive.

We can also _estimate_ the parameters of our Gaussian distribution in the following ways:

- For one-dimensional feature spaces
	- The mean $\hat{\mu}$ can be estimated as the average of the values of the variables: $\frac{1}{n} \sum_{k=1}^n x_k$.
	- The variance $\sigma^2$ can be estimated as the average of the square of the variance of each single value: $\frac{1}{n}\sum_{k=1}^n(x_k-\hat{\mu})^2$. Alternatively, we can also estimate it as $\frac{1}{n-1}\sum_{k=1}^n(x_k-\hat{\mu})^2$: this is called an "_unbiased estimator_". The idea behind this is that since we are measuring deviations against an averaged $\hat{\mu}$ we try to correct this approximation (which makes the approximation smaller) by dividing against $n-1$, since $\hat{\mu}$ is usually slightly closer to the samples than the true $\mu$.
- For multi-dimensional ones
	- The covariance matrix $\hat{\Sigma}$ can be estimated as the average of the outer products across all samples: $\frac{1}{n}\Sigma_{k=1}^n(x_k-\hat{\mu})(x_k-\hat{\mu})^T$

In our Gaussian classifier, we have that if $P(x\ |\ \omega_i) = N(\omega_i, \Sigma_i)$, the associate discriminant function is:

$$
g_i(x) = \ln(P(x\ |\ \omega_i) P(\omega_i)) =  \ln P(x\ |\ \omega_i) + \ln P(\omega_i)
$$

If we substitute the value of $P(x\ |\ \omega_i)$ with the multi-dimensional form of the Gaussian distribution, we get:

$$
g_i(x) = -\frac{1}{2}(x-\mu_i)^T\Sigma_i^{-1}(x-\mu_i)-\frac{d}{2}\ln(2\pi) - \frac{1}{2}\ln|\Sigma_i|+\ln P(\omega_i)
$$

If we also expand $P(\omega_i)$:

> [!INFO] Gaussian general discrimination function
> 
> $$
> g_i(x) = -\frac{1}{2}(x-\mu_i)^T\Sigma_i^{-1}(x-\mu_i)-\frac{d}{2}\ln(2\pi) - \frac{1}{2}\ln|\Sigma_i|+\ln (\frac{n_i}{\Sigma_j n_j})
> $$

The discriminant function can then be used to assign a "_score_" for each class to an input $x_i$, so that the classifier can then pick the class with the highest associated score. The idea is to compute it by taking the natural logarithm of the MAP ($P(x\ |\ \omega_i)P(\omega_i)$) to make the calculations more feasible, without changing the winning class.

### Case $\Sigma_i = \sigma^2 I$

If we have the case in which $\Sigma_i = \sigma^2 I$, then the features are all statistically independent and have the same variance. Visually, the data form a set of "clusters" (which are spheres, or hyper-spheres if we have more than three dimensions) of identical sizes, with centers in $\mu_i$. An example of said case:

$$
\Sigma_i = \begin{pmatrix}
  \sigma^2 & 0 & 0 \\ 
  0 & \sigma^2 & 0 \\
  0 & 0 & \sigma^2
\end{pmatrix}
$$

This is the simplest case where we have the following properties:

$$
|\Sigma_i| = \sigma^{2d}, \Sigma_i^{-1} = (\frac{1}{\sigma^2}) I
$$

And the discriminant function is the one that was written in the previous paragraph. However, since we want to assign $x$ to the class $\omega_i$ if $g_i(x) > g_j(x), j \neq i$, we can disregard all terms that do not depend on the class, meaning that we can rewrite the above formula as:

> [!INFO] Gaussian discrimination function with $\Sigma_i=\sigma^2 I$
> 
> $$
> g_i(x) = -\frac{||x-\mu_i||^2}{2\sigma^2} + \ln P(\omega_i)
> $$

The numerator of the fraction is just the _squared Euclidean norm_:

$$
g_i(x) = \frac{(x-\mu_i)^T(x-\mu_i)}{2\sigma^2}+\ln P(\omega_i)
$$

If we expand it we get:

$$
g_i(x) = \frac{1}{2\sigma^2}x^Tx + \frac{1}{\sigma^2}\mu_i^Tx - \frac{1}{2\sigma^2}\mu_i^T\mu_i + \ln P(\omega_i)
$$

Now, $x^Tx$ is a term that is _the same for all classes_: this means that we can avoid considering it when finding the max value (which is the point of the discrimination function). This means that our final function can be rewritten as a linear function:

> [!INFO] Gaussian discrimination function with $\Sigma_i=\sigma^2 I$, simplified
> 
> $$
> g_i(x) = w_i^Tx + w_{i0}
> $$
> 
> Where:
> 
> - $w_i = \frac{1}{\sigma^2}\mu_i$, which is called "weight vector" (as it weights the input $x$ against $w_i$)
> - $w_{i0} = -\frac{1}{2\sigma^2} \mu_i^T\mu_i + \ln P(\omega_i)$, which is called the "threshold", or "bias" for the i-th class (as it moves the score up or down independently of $x$).

The decision boundary is defined as a portion of hyperplane (of dimension $d-1$) where $g_i(x) = g_j(x)$. Said hyperplane has the following equation:

> [!INFO] Hyperplane equation for the decision boundary
> 
> $$
> w^T(x-x_0) = 0
> $$
> 
> Where:
> 
> $$
> w = \mu_i - \mu_j
> $$
> 
> Is the **normal vector** to the hyperplane. This points in the direction connecting the means of the two classes, so that the boundary is perpendicular to said line.
> 
> $$
> x_0 = \frac{1}{2}(\mu_i+\mu_j)-\frac{\sigma^2}{||\mu_i-\mu_j||^2}\ln \frac{P(\omega_i)}{P(\omega_j)}(\mu_i - \mu_j)
> $$
> 
> Is a **point on the hyperplane**, where the first element left of the "-" is the _midpoint between the two means_, while the other is meant to be a "shift" from the midpoint depending on the prior probabilities of the classes.

When the two _a priori_ probabilities are different, the boundary point between the two classes $x_0$ "moves away" from the mean of the most probable class. 

![Change of prior probabilities example | center](https://i.imgur.com/Kg8cbjc.png)

Mathematically, this happens because the sum of the means $\mu_i + \mu_j$ of the above formula increases, causing $x_0$ to move right. If we have two features:

![Change of prior probabilities example, d=2 | center](https://i.imgur.com/IFqspKv.png)

### Case $\Sigma_i = \Sigma$

In this case, the covariance matrices are equal for all classes. Visually, we have "clusters" of data with ellipsoidal (or hyper-ellipsoidal if we have more than two dimensions) of identical sizes and shapes, centered in $\mu_i$. Mathematically, the discriminant function formula can be simplified by deleting all the terms that do not depend on $i$:

> [!INFO] Gaussian discrimination function with $\Sigma_i=\Sigma$, simplified
> 
> $$
> g_i(x) = -\frac{1}{2}(x-\mu_i)^T\Sigma^{-1}(x-\mu_i)+\ln P(\omega_i)
> $$

Here, the equation of the hyperplanes that represent the separation surfaces between adjacent regions are slightly different:

> [!INFO] Hyperplane equation for the decision boundary where $\Sigma_i = \Sigma$
> 
> $$
> w^T(x-x_0) = 0
> $$
> 
> Where:
> 
> $$
> w = \Sigma^{-1}(\mu_i - \mu_j)
> $$
> 
> Is the **normal vector** to the hyperplane. Since $w$ is not (in general) in the same direction of $\mu_i-\mu_j$, the hyper-plane is not orthogonal to the line joining the two means (as it was in the previous general case).
> 
> $$
> x_0 = \frac{1}{2}(\mu_i+\mu_j)-\frac{\ln[P(\omega_i)/P(\omega_j)]}{(\mu_i-\mu_j)^T\Sigma^{-1}(\mu_i-\mu_j))}(\mu_i-\mu_j)
> $$
> 
> Is a **point on the hyperplane**, where the first element left of the "-" is the _midpoint between the two means_, while the other is meant to be a "shift" from the midpoint depending on the prior probabilities of the classes. Here, the hyper-plane intersects the line in $x_0$, whose position depends on the _a priori_ probability.

An example case:

![Example case for sigma_i=sigma | center](https://i.imgur.com/yvMqNeK.png)

If the covariance matrix is the same for all classes, we can estimate the maximum likelihood as:

$$
S_w = \sum_{i=1}^C \frac{n_i}{n} \hat{\Sigma_i}
$$

Where $\hat{\Sigma_i}$ is estimated with the samples of class $\omega_i$. The estimate of the matrix $S_w$ for $c$ classes is:

$$
\frac{n}{n-c}S_w
$$

#### Case $\Sigma_i = \Sigma$ and $P(\omega_i) = P(\omega_j)$

If we also have $P(\omega_i) = P(\omega_j)$ for all classes, the discriminant function becomes smaller:

> [!INFO] Gaussian discrimination function with $\Sigma_i=\Sigma$, $P(\omega_i) = P(\omega_j)$, simplified
> 
> $$
> g_i(x) = -\frac{1}{2}(x-\mu_i)^T\Sigma^{-1}(x-\mu_i)
> $$

The term $(x-\mu_i)^T\Sigma^{-1}(x-\mu_i)$ is called the **Mahalanobis distance** between $x$ and $\mu_i$. We want to assign $x$ to the class that has the smallest distance. We can also obtain a linear function like before:

$$
g_i(x) = w_i^Tx+w_{i0}, w_i=\Sigma^{-1}\mu_i, w_{i0}=-\frac{1}{2}\mu_i^T\Sigma^{-1}\mu_i + \ln P(\omega_i)
$$

### Nearest mean classifier

Another special case is the one in which all classes have the same a priori probability: $P(\omega_i) = P(\omega_j)$. Here, the discriminant function gets even smaller:

> [!INFO] Gaussian discrimination for the nearest mean classifier
> 
> $$
> g_i(x) = -||x-\mu_i||^2
> $$

This is called a _nearest mean classifier_, because the highest score is assigned to the class whose mean $\mu_i$ is closer to $x$, and is used in the classification procedure called _template matching_, where each class is represented by a prototype $\mu_i$. 

These are some examples of distributions with 2 and 3 dimensions:

![Example gaussian nearest mean | center](https://i.imgur.com/Yz2GtJH.png)

![Example gaussian nearest mean, d=3 | center](https://i.imgur.com/4T3rrZz.png)

### Arbitrary $\Sigma_i$

Here we can only drop the term $d/2 \ln({2\pi})$ from the discriminant function, getting:

> [!INFO] Gaussian discrimination function with arbitrary $\Sigma_i$
> 
> $$
> g_i(x) = -\frac{1}{2}(x-\mu_i)^T\Sigma_i^{-1}(x-\mu_i) - \frac{1}{2}\ln|\Sigma_i|+\ln (\frac{n_i}{\Sigma_j n_j})
> $$

Meaning we do not obtain a linear function by simplifying but a _quadratic one_:

> [!INFO] Gaussian discrimination function with arbitrary $\Sigma_i$, simplified
> 
> $$
> g_i(x) = x'W_ix + w'_i x + w_{i0}
> $$
> 
> Where:
> 
> - $W_i = -\frac{1}{2} \Sigma_i^{-1}, w_i = \Sigma_i^{-1}\mu_i$
> - $w_{i0} = - \frac{1}{2}\mu_i'\Sigma_i^{-1}\mu_i - \frac{1}{2}\ln |\Sigma_i| + \ln P(\omega_i)$

![Arbitrary sigma_i examples | center](https://i.imgur.com/5zBnaSP.png)

> [!HELP] Homework 7
> 
> TODO

# Non-parametric Classifiers

The classifiers described in the previous chapter all shared a singular characteristic: the **probability density functions** were always known. This assumption, however, might not always hold true, so we need a way to build a classifier that is "blind" to the underlying distribution function. This is where _non-parametric classifiers_ come into place.

Generally speaking, non-parametric classifier approach the problem of classification with a common strategy: the idea is to identify, inside the data set, some "**prototype** samples", which are sort of "representative" of a single class (these might be some samples that share any characteristic making them extremely representative of a set: i.e., a sea bass that has a certain length making him unmistakably classifyable as a sea bass). In order to classify more "uncertain" samples, non-parametric classifies compute a _geometric distance_ from such prototypes, to then choose the class of the prototype being the **closest** to the sample to be classified. Here, for example, is a graphical representation of prototypes (in red and black) and classification regions (in gray and white): if a samples falls into one region, it is classified for the relative class:

![Non-parametric image | center](https://i.imgur.com/qeOG8AK.png)

## $k$-Nearest Neighbor Method ($kNN$)

The simplest non-parametric classifier is the $kNN$, or "$k$-Nearest Neighbor". We specify a **training set** $D$ that contains $n$ points, which will act as our prototypes. Each of these prototypes belongs to one of the "$c$" classes:

$$
D = [x_1,x_2,\dots,x_n]; x_i = (x_{i1},x_{i2},\dots,x_{id});\ i=1,\dots,n
$$

If we need to classify a sample $x$, we simply take the $k$ nearest prototypes from $D$, along with their class lables. We then classify $x$ according to the most represented class label amongst its neighbors. For example:

![knn neighbors | center](https://i.imgur.com/3gYs7Lv.png)

In this figure, we take a total of $k=5$ prototypes from $D$. Since we have $3$ prototypes that are classified as "black", and $2$ that are classified as "red", $x$ will get "black" as its class label, as it is the most represented label in the region $R$.

> [!NOTE] Posterior probability of $kNN$
> 
> The posterior probability estimated by the $kNN$ method can be expressed as:
> 
> $$
> \hat{P}(\omega_i\ |\ x) = \frac{k_i}{k}
> $$
> 
> Where:
> 
> - $k_i$ is the number of the nearest neighbors inside $R$ of class $\omega_i$
> - $k$ is the number of the $k$ nearest prototypes of $x$ inside $R$

Since the Bayes error assigns $x$ to the class with the highest $\hat{P}$, this amounts to choosing the class most represented among the $k$ neighbors.

> [!NOTE] Choosing $k$
> 
> In our previous example, we chose an arbitrary $k=5$, but a good rule of thumb is to choose $k=\sqrt{n}$, making sure that $k$ is odd if $n$ is even (to avoid tie-breaks). We also use "**cross-validation**" to help us: the data set is divided into a "_Training set_" (which contains the prototypes), a "_Validation set_" (which is used to evaluate the error $E$ with different values of $k$) and a "_Test set_".

## Generalization of non-parametric methods

We saw how $kNN$ can be used to classify samples when the PDF is now known a-priori. We can generalize this methods to explain how non-parametric methods as a whole work, to then fall into specific examples.

The basic idea of these methods is that the probability $P$ of a vector $x$ (a data sample) falling into a region $R$ of the feature space (which corresponds to a class label) is:

$$
P = \int_R p(x') dx'
$$

This is trivial: we saw in the previous chapter that, when we have a Gaussian distribution, the probability of a sample falling into a region is equal to the area under the curve of the Gaussian distribution going from one extremity of $R$ up to infinity. In fact, if $R$ is a _smoothed region_, we can regard $P$ as a smoothed version of the density function $p(x)$, meaning we can estimate $p(x)$ using $P$.

In particular, suppose to independently draw $n$ identically-distributed (i.i.d) samples $x_1,x_2,\dots,x_n$ according to $p(x)$. Knowing that $k$ of these samples out of $n$ fall in $R$, the probability $P$ of a sample falling inside $R$ can be _estimated_ to be $P = \frac{k}{n}$.

> [!HELP] Proof
> 
> The probability of $k$ out of $n$ samples falling inside $R$ is determined by the _binomial law_:
> 
> $$
> P_k = \begin{pmatrix}n \\ k\end{pmatrix}P^k (1-P)^{n-k}
> $$
> 
> The _expected value_ (or, in simpler terms, the _mean_) of this distribution is $\epsilon(k) = nP$. We want to demonstrate that $P=\frac{k}{n}$, so we plug $\frac{k}{n}$ instead of $k$ and obtain $\epsilon(k/n) = P$.
> 
> However, the _variance_ of the binomial law is $var(k/n) = P(1-P)/n$. To verify that $k/n$ is a "good estimator" of $P$, we need to make sure that it is an **asymptotically unbiased** estimator (the bias, or the variance, goes to $0$ as $n$ goes to $\infty$). We can demonstrate this by calculating the limit:
> 
> $$
> \lim_{n \to +\infty} \epsilon(k/n) = P, \text{var}(k/n)=0
> $$
> 
> Practically, this means that $k/n$ is an estimator that gets better and better as $n$ grows (since the bias decreases). In the example, we see that the normal distribution spikes at $k/n = 0.7$ for large values of $n$:
> 
> ![bias binomial distribution | center](https://i.imgur.com/ZGZGYHQ.png)

We can make two additional assumptions to get rid of the integral and simplify our probability function. We can assume that:

- $p(x)$ is continuous (a relatively safe assumption)
- $R$ is a very small region, so much that $p(x)$ does not vary appreciably within it

With that, we can say that:

$$
P = \int_R p(x')\ dx' \approx p(x)V
$$

Where $V$ is the volume enclosed by $R$. Since we previously said that $P \approx k/n$, we can rewrite this as:

> [!NOTE] Density estimation
> 
> $$
> P \approx k/n \approx p(x)V \to p(x) \approx \frac{k/n}{V} = \frac{k}{nV}
> $$

However, to obtain this formula we have made two contradictory assumptions:

1. That $V$ must be sufficiently small to make $p(x)$ not vary too much (meaning the _density of the region_ remains constant)
2. $n$ must be large enough for the distribution to be sharply peaked at $k/n$ (meaning the _value of the density_ must be large)

To get rid of this contradiction, we have two strategies. We either:

1. Fix $k$ and determine $V$ from the data. This is the $kNN$ method.
	- To obtain a true version of $p(x)$, then $V$ must tend to $0$. Practically speaking, since the number of samples is limited, this is usually not possible (we need to accept a certain amount of variance and bias).
2. Fix $V$ and determine $k$ from the data. This is the method used by **kernel density estimators**.
	- Note that even if we had $n \to \infty$ fixing $V$, the ratio will converge, but we won't have obtained the true $p(x)$, but just an averaged value of the sets inside $V$.

Both these methods converge to the true probability density, provided that $V$ shrinks suitably with $n$ and that $k$ grows with $n$. In particular, if we form a sequence of regions $R_1, R_2, \dots, R_n$ containing a sample $x$ while varying the number of samples $n$, we can estimate the probability of $x$ falling in the $n$-th estimate:

$$
p_n(x) = \frac{k_n}{nV_n}
$$

With $V_n$ being the volume of region $R_n$ and $k_n$ the samples inside it. For $p_n(x)$ to converge to $p(x)$, we must have:

1. $\lim_{n \to \infty}V_n = 0$. This assures that the space averaged $P/V$ converges to $p(x)$, if the region shrinks uniformly and that $p(\cdot)$ is continuous.
2. $\lim_{n \to \infty}k_n = \infty$. This assures that the frequency ratio will converge to $P$
3. $\lim_{n \to \infty}\frac{k_n}{n} = 0$. This is necessary to make $p_n(x)$ converge at all

To obtain these conditions, we either:

1. Specify a volume $V_n$ as some function of $n$ so that we can shrink it, such as $V_n = 1/\sqrt{n}$. We then demonstrate that $p_n(x)$ converges to $p(x)$ with the constraints above.
	- This is the **Parzen-window / kernel density estimation** (KDE) method
2. Specify $k_n$ as a function of $n$, like $k_n = \sqrt{n}$. The volume $V_n$ then grows until it contains $k_n$ neighbors of $n$
	- This is the $kNN$ method we saw.
	- ![knn example | center](https://i.imgur.com/1R3itUg.png)


Both converge if we have infinite samples, but for finite ones this is not guaranteed.

![kNN estimators convergence | center](https://i.imgur.com/l1KqC4J.png)

As we said, the choice of fixing $V$ and determine $k$ gives rise to the **kernel density estimators**. In particular, if we consider $R$ to be an hypercube centered on the origin, we can define a _kernel function_ or _Parzen window_:

> [!NOTE] Kernel function
> 
> $$
> k(u) = \begin{cases} 1, & |u_i| \leq 1/2, i=1,\dots,D \\ 0, & \text{otherwise} \end{cases}
> $$

This function can be used to verify if a point $u$ is inside the hypercube delimiting the region $R$. In particular, $k(\frac{x-x_n}{h})$ will be $1$ if the data point $x_n$ is inside the $h$-size, $x$-centered cube, or $0$ otherwise. This means we can count the number of datapoints inside our region by computing:

$$
K = \sum_{n=1}^Nk(\frac{x-x_n}{h})
$$

And thus, express $p(x)$ as the average over all $N$ training points of the density of points in our hypercube (the number of points divided by the volume of the hypercube with $h$ dimensions):

> [!INFO] Kernel density estimations:
> 
> $$
> p(x) = \frac{1}{N} \sum_{n=1}^N \frac{1}{h^D}k(\frac{x-x_n}{h})
> $$
> 
> Or, if the kernel is a Gaussian instead of a hypercube:
> 
> $$
> p(x) = \frac{1}{N}\sum_{n=1}^N \frac{1}{(2\pi h^2)^{1/2}}exp\{\frac{||x-x_n||^2}{2h^2}\}
> $$

![kernel density 1d | center](https://i.imgur.com/Yfy0nDz.png)

### Classification

Now that we have our way of estimating the density of our data, we can move to the classification part. We want to obtain an estimate of $p(x|y)$ to then apply the Bayes' theorem and compute the posterior probabilities.

#### $kNN$

We discussed earlier that the estimation of the unconditional PDF can be approximated as:

$$
p_n(x) = \frac{k_n}{nV_n}
$$

If we denote $k_i$ as the number of elements in $R$ from class $\omega_i$ specifically, the class-conditional PDF for $\omega_i, i=1,\dots,c$ becomes:

$$
p(x\ |\ \omega_i) = \frac{k_i}{n_iV_n}
$$

Applying Bayes's theorem, we can compute the _posterior probability_:

$$
P_n(\omega_i\ |\ x) = \frac{p_n(x\ |\ \omega_i)p(\omega_i)}{p_n(x)} = \frac{\frac{k_i}{n_iV}\frac{n_i}{n}}{\frac{k/n}{V}} = \frac{k_i}{k}
$$

Which means that, following the minimum error classifier, $x$ will be assigned to the class most represented among the $k$ neighbors of $x$. Note how $R$ and $V$ are specific for each $x$, but since $kNN$ assigns the class label based only on $k_i$ the label is not dependent on either. 

We say that $kNN$ is Bayes-optimal if:

$$
\lim_{n \to \infty}k_n = \infty \land \lim_{n\to\infty}\frac{k_n}{n} = 0
$$

In this example we can see the error rate for a two-category problem: when $k=\infty$ the estimated probabilities match the true probabilities:

![](https://i.imgur.com/cDdZGfN.png)

#### $1NN$

A relaxation to $kNN$ is the **Nearest-neighbor Rule** ($1NN$): take $D^n=\{x_1,\dots,x_n\}$ as a training set of samples belonging to $c$ classes $\omega_1,\dots,\omega_c$ and be $x' \in D^n$ the nearest sample to the unknown $x$. The decision rule is to simply assign $x$ to $x'$'s class. This, of course, produces a grater error than the minimum possible, but it is proven that given infinite prototypes the error rate is never worse than _twice_ the Bayes rate.

This assumption can be made because it is reasonable to say that if $n$ is "very large", then $x'$ will be very close to $x$, so that $P(\omega'\ |\ x') = P(\omega_i\ |\ x)$. This classification methods can be visualized in a so-called "**Voronoi tesselation**" of the space, where a 2D grid is divided into $N$ (we have a $kNN$ with $k=1$) cells, each encompassing the space closest to the training point it contains:

![Voronoi tesselation | center](https://i.imgur.com/zhgVwY6.png)

In particular:

- If the minimum probability error is very small ($P(\omega_m\ |\ x) \approx 1$), $1NN$ is very close to the optimal rule, because it is unlikely for the posterior probability to change.
- On the contrary, if all classes are close to having the same probabilities ($P(\omega_m\ |\ x) \approx 1/c$), $1NN$ is likely suboptimal.

> [!HELP] Python exercise
> 
> TODO, page 39 set 3

