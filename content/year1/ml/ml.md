---
date: 2026-04-16
draft: false
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

meaning that our error probability equals to the sum of the probabilities of erroneous labeling ($\omega_1$ while $x$ should be in $R_2$ and vice-versa). Here, $R_1$ and $R_2$ are, respectively, the areas under $\omega_2$ from $0$ to the threshold $x^*$ and the area under $\omega_1$ from $x^*$ to $+\infty$:

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
R_0 \text{ (the reject region)}  & = \{x \in R : R(\omega_0\ |\ x) < R(\omega_j\ |\ x) \forall j \neq 0\} \\
R_1 \text{ (the } \omega_1\text{ region)} & = \{x \in R : R(\omega_1\ |\ x) < R(\omega_j\ |\ x) \forall j \neq 1\} \\
R_1 \text{ (the } \omega_2\text{ region)} & = \{x \in R : R(\omega_2\ |\ x) < R(\omega_j\ |\ x) \forall j \neq 2\}
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

# Linear Discriminant Functions

When dealing with linear discriminant functions, we consider a case where the function

$$
f_k(x;\theta), k=1,\dots,K
$$

Used to determine a class label for a sample is **given**. The core idea is that we use the _training data_ to estimate the parameters $\theta$ to "tune" the function to perform better classifications. The other assumption is that, of course, the function must be linear, i.e.:

$$
f(x;\theta)=w^Tx+b, \text{ with } \theta=(w,b)
$$

Which can also be rewritten in the form:

$$
f(x;\theta)=w^Tx+b=\sum_{j=1}^dw_jx_j+ b
$$

Essentially, a linear discriminant functions is composed of a weight vector $w$ containing $d$ weights. These weights are then multiplied against each feature $x_j$ of the feature vector $x$, and the summed to a bias $b$. If we have a two-class classification problem, for example, the result of this linear function is generally:

$$
y = \begin{cases}+1 & \text{if } f(x) \geq 0 \\ -1 & \text{otherwise} \end{cases}
$$

Graphically, the discrimination function can be represented as a line that divides two "cluster" of data samples, depending on their class:

![Linear discriminant function | center](https://i.imgur.com/QSsHw5E.png)

Since the function is linear, multiplying it by a constant factor amounts to multiplying the parameters $w,b$ to the same factor, and changing the slope of the function:

![Slope change | center](https://i.imgur.com/VcpkFBw.png)

Given these assumptions, we can already build the simplest linear classifier possible, which is called "**Nearest Mean Classifier**". The concept is very simple: we estimate the mean values of the two classes from the training set, which are called $\mu_1,\mu_2$, and unknown samples $x^*$ are assigned to the class with the smallest euclidean distance from the mean:

$$
d(x^*,\mu_2)</=/>d(x^*,\mu_1)
$$

In this case, the hyperplane traced by the function is perpendicular to the vector $\mu_1-\mu_2$, and passes through the mean point $(\mu_1+\mu_2)/2$:

![NMC | center](https://i.imgur.com/tqDxcSg.png)

## Learning as an Optimization Problem

We defined a linear discriminant function using the general formula:

$$
f(x;\theta) = w^Tx+b
$$

However, in a classification problem the only element that is given is $x$, the feature vector. This means that we need to find a way to calculate $(w,b)$. The most modern approaches formulate the learning problem as an [optimization problem](https://en.wikipedia.org/wiki/Optimization_problem). Optimization problems require finding the _best possible solution_, usually through an iterative method.

More specifically, we can frame the problem of determining the best values of $(w^*,b^*)$ using the _loss function_: we want to find the values for this parameters that make the error function **the smallest possible**. In formulas:

> [!NOTE] Optimization Problem
> 
> $$
> w^*,b^* = \text{argmin}_{w,b} \frac{1}{n}\sum_{i=1}^nl(y_i, f(x_i))+\lambda \Omega(w)
> $$
> 
> Where:
> 
> - $\frac{1}{n}\sum_{i=1}^nl(y_i,f(x_i))$ is the **loss term**, also written as $L(D,\theta)$. $l(y_i,f(x_i))$ is the _loss function_, which measures how much a prediction is wrong (for example, 0 if the label is assigned correctly or 1 otherwise for the zero-one loss function), so this is just the mean of the value of the loss function for each label.
> - $\Omega(w)$ imposes a penalty for classifiers that are too complex, in order to reward smoother functions.
> - $\lambda$ is an hyperparameter that tunes the trade-off between regularization and training loss. $\lambda \Omega(w)$ is called the **regularization term**
> - As a reminder, $\theta = (w,b)$.
>   
> We can also write this as:
> 
> $$
> \theta^* = \text{argmin}_\theta L(D,\theta) = \frac{1}{n}\sum_{i=1}^nl(y_i, f(x_i;\theta))+\lambda \Omega(w)
> $$
> 
> Having $D=(x_i,y_i)^n_{i=1}$ as the _training dataset_ ($x$ are the samples, while $y$ are the correct labels used to calculate the error)

To understand how solving this minimization problem works in theory, we can consider a simpler example without the regularization term:

$$
L(D,\theta) = \frac{1}{n}\sum_{i=1}^nl(y_i, f(x_i;\theta))
$$

If we take $l$ to be the zero-one loss function (0 for correct predictions, 1 otherwise):

$$
l(y_i,f(x_i;\theta)) = \begin{cases}+1 & \text{if } y \cdot f(x) < 0 \\ -1 & \text{if } y \cdot f(x) \geq 0 \end{cases}
$$

This problem immediately becomes **NP-Hard** and too computationally inefficient to solve. This has to do with a function property which is called **convexity**:

> [!NOTE] Convexity
> 
> A function is called convex if the _line segment_ between any two distinct points on the graph of the function lies above or on the graph of the function between the two points. In formula:
> 
> $$
> f(\lambda x_1 + (1-\lambda)x_2) < \lambda f(x_1) + (1-\lambda)f(x_2),\ \ \forall x_1,x_2,\ \ \lambda \in [0,1]
> $$
> 
> An example:
> 
> ![Convex vs non-convex | center](https://i.imgur.com/WBTYKQ4.png)
> 
> An important property of convexity is that, if a function is convex, then any local minima is **also a global minima**.

In particular, the zero-one loss function is **not** convex. This is a problem, because the whole point of our optimization problem is to find the **global minima** of the function (which is the point where the function has the smallest value). In a non-convex function, however, we can find infinitely many _local minima_ that are not global, making our algorithm prone to error and hard to define (we'd need to find a way to distinguish a local minima from a global one, which is not possible):

![Local minima zero-one loss function | center](https://i.imgur.com/sNWDEA8.png)

However, if our function _is_ convex, then it is much easier to find the optimal values for $\theta$, since we just need to find the only global minima (there are some known methods to do this that we will see later).

If we want to keep the same behavior of the zero-one loss function without the convexity problem, we can switch to using the _hinge loss_ function (which is the tighter convex upper bound on the zero-one loss function). Minimizing it is the same as minimizing the 0-1 loss:

$$
l(y,g(x;\theta)) = \text{max}(0,1-yf)
$$

![Hinge loss function | center](https://i.imgur.com/gbmfmRI.png)

As a sidenote, let's assume that we fix $b=0$ and aim to minimize the training loss only for $w_1,w_2$. In this case, each pair represents a different classifier that passes through the origin, and for each of these we can report the corresponding training loss in a colored prompt, showing the _optimization landscape_ (the surface of the function we aim to minimize):

![Optimization landscape | center](https://i.imgur.com/ScvyGtl.png)

Fixing $w_2=0$ as well we can look at the profile of the loss along the $w_2=0$ line:

![w_2=0 | center](https://i.imgur.com/b5sty0r.png)

### Gradient Optimization

If our function is _smooth_, optimization becomes much easier, thanks to **gradients**.

> [!NOTE] Gradient
> 
> The Gradient of a differentiable function $f$ of several variables is the vector field $\nabla f$ whose value, at a point $p$, gives the direction and the rate of the fastest decrease.
> 
> $$
> \nabla f(p) = \begin{bmatrix} \frac{\delta f}{\delta x_1}(p) \\ \dots \\ \frac{\delta f}{\delta x_n}(p) \end{bmatrix}
> $$
> 
> The $i$-th element of the gradient is thus calculated as the partial derivative of the $i$-th variable computed at point $p$.
> 
> It is a fundamental notion of optimization theory, since, if the value of the gradient at point $p$ of a function:
> 
> - Is not zero, then the gradient indicates the direction in which the function increases the most quickly from $p$
> - Is zero, then $p$ is a stationary point (a local or global minima)

The point of gradients is that we can start by taking a random point of our function (this step is called _random initialization_) and then "follow" the gradient descent, updating the parameters accordingly. In particular, for our loss function, we have:

$$
L(D,\theta) = \frac{1}{n}\sum_{i=1}^n l(y_i,f(x_i;\theta)), \nabla_\theta L = \frac{1}{n}\sum_{i=1}^n \nabla_\theta l(y_i,f(x_i;\theta))
$$

Here, $\nabla_\theta L$ is the _direction_ in our space along which the objective maximally decreases. 

> [!NOTE] Gradient descent algorithm
> 
> In pseudocode, these would be the passages to be iterated to reach an optimal value for parameters $\theta$
> 
> ```
> initialize theta, new_theta, N, K, epsilon
> for k in range(0,K-1):
> 	new_theta = theta - n * gradient_L(theta)
> 	if |L(theta) - L(new_theta)| < epsilon:
> 		break
> 	theta = new_theta
> ```
> 
> 1. We start by initializing $\theta, n, K, \epsilon$.
> 	- $\theta$ is our parameters vector
> 	- $n$ is our _learning rate_, which affects convergence: smaller values slow down convergence, while higher ones might prevent the function from converging at all. Usually updated between iterations
> 	- $K$ is the total number of iterations
> 	- $\epsilon$ acts as a _stop condition_: if, at a certain iteration step, the training loss is almost constant, the algorithm interrupts, assuming that the function has been optimized enough
> 2. We iterate $K$ times:
> 	1. We compute the new optimal parameters $\theta_{new}$ by taking $\theta$ and subtracting the value of our gradient function $\nabla L(\theta)$ multiplied by the learning rate $n$. The subtraction effectively allows us to "follow" the gradient descent down towards the optimal point, while $n$ acts as a "booster" to speed up the optimization.
> 	2. We verify if we have reached the stop condition: either we have exhausted the number of iterations $K$ or the optimization is smaller than an arbitrary $\epsilon$. If we did, then stop. Otherwise, we take $\theta_{new}$ as our new $\theta$ and repeat from step $2$.

As an example of how the step size affects convergence, we can see this graphical representation of the optimization of the same function via the gradient descent with different step sizes (taken from [here](http://fa.bianp.net/teaching/2018/eecs227at/gradient_descent.html)):

![small step size | center](https://i.imgur.com/hOMrv0x.png)

![large step size | center](https://i.imgur.com/oBhEMSm.png)

If, instead, the function is non-convex or is badly conditioned, the convergence can be very slow:

![small step size, bad convergence | center](https://i.imgur.com/bTlOMLP.png)

![big step size, bad convergence | center](https://i.imgur.com/vL1uKCP.png)

#### Quadratic Objectives

We've seen how the steepest descent algorithm can help us reach an optimal configuration of our parameters $\theta$. Graphically we saw that this approximates to the act of "going down" the slope of the function towards the global minima. If we think about this, as we get closer to the point we are looking for, the function starts to become more and more similar to a linear function: this act of "approximating" a convex or quadratic function is called "**linear approximation**", and can also be achieved using _Taylor's theorem_:

> [!NOTE] Taylor's Theorem
> 
> In calculus, Taylor's theorem states that if a function $f$ can be approximated $k$ times, then the function can be approximated around a certain point with a _polynomial_ function of degree $k$, which is called the "$k$-th-order" Taylor polynomial. In its general form, the $k$-th-order Taylor polynomial has the form:
> 
> $$
> P_k(x) = f(a) + f'(a)(x-a) + \frac{f''(a)}{2!}(x-a)^2 + \dots + \frac{f^{(k)}(a)}{k!}(x-a)^k
> $$
> 
> Where $f^{(k)}$ is the $k$-th derivative of the function $f$.
> 
> If we take a quadratic function (differentiable $k=2$ times), its second-order Taylor polynomial becomes:
> 
> $$
> P_2(x) = f(a)+f'(a)(x-a) + \frac{f''(a)}{2}(x-a)^2
> $$
> 
> Here is a plotted example of the function $f(x)=e^x$ (in blue) with its linear approximation $P_1(x)=1+x$ (in red). At $a=0$, the two functions have approximately the same value:
> 
> ![e^x | center](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/E%5Ex_with_linear_approximation.png/250px-E%5Ex_with_linear_approximation.png)
> 
> The approximation gets even better if we consider $P_2(x) = 1 + x + \frac{x^2}{2}$ at $a=0$ (the quadratic approximation):
> 
> ![quadratic approximation | center](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/E%5Ex_with_quadratic_approximation_corrected.png/250px-E%5Ex_with_quadratic_approximation_corrected.png)

> [!HELP] Taylor's Theorem for multi-variable cases
> 
> If we take a one-dimensional function, its linear approximation can be expressed using the following polynomial:
> 
> $$
> f(x) \approx f(a) + f'(a)(x-a)
> $$
> 
> The idea is that if we want to approximate the value of $f$ at a point $x$, then we can take a secondary point $a$ which is near $x$ and then reason like this: "if function $f$ has a certain value at $a$, then we can take the value at point $x$ by multiplying how much the function changes per unit of movement per the movement". The rate of change of the function is given by its first order derivative, $f'(a)$, while the change itself is just $x-a$. In formulas:
> 
> $$
> f(x+h) \approx f(x) + f'(x)h
> $$
> 
> With $h = x-a$
> 
> However, if we have a multi-dimensional function, the movement occurs along multiple dimensions. For example, if we have a two-dimensional function $f(x,y)$, the rate of change can be measured for both $x$ and $y$. This means that we have to take into account not one, but _two_ partial derivatives, one for $x$ and one for $y$. This means that if we express $\Delta x, \Delta y$ as the change in the values of $x$ and $y$ respectively, our linear approximation becomes something like this:
> 
> $$
> f(x+\Delta x, y + \Delta y) \approx f(x,y) + \frac{\delta f}{\delta x}\Delta x + \frac{\delta f}{\delta y}\Delta y
> $$
> 
> In order to obtain a more general version of this linear approximation for higher dimensions, we can define a vector containing all our first dimension partial derivatives:
> 
> $$
> \nabla f = \begin{bmatrix}\frac{\delta f}{\delta x} \\ \frac{\delta f}{\delta y}\end{bmatrix}
> $$
> 
> Then, we can do the same for our rates of change for our variables:
> 
> $$
> \theta = \begin{bmatrix}x \\ y \end{bmatrix}
> $$
> 
> $$
> \Delta \theta = \begin{bmatrix}\Delta x \\ \Delta y \end{bmatrix}
> $$
> 
> Now we can just rewrite the linear terms using matrix multiplication:
> 
> $$
> f(\theta + \Delta \theta) \approx f(\theta) + \nabla f(\theta)^T \Delta \theta
> $$
> 
> Since:
> 
> $$
> \begin{bmatrix}f_x & f_y\end{bmatrix} \begin{bmatrix}\Delta x \\ \Delta y \end{bmatrix} = f_x \Delta x + f_y \Delta y
> $$
> 
> Now we have a general formula to express linear approximation in case of multi-dimensional variables. The only remaining goal is to move from a linear approximation to a quadratic approximation. If we take, for example, a quadratic approximation, we now have to add to our example formula with one variable the term:
> 
> $$
> \frac{1}{2}f''(x)h^2
> $$
> 
> In linear functions, we have just one possible second-order derivative. For bi-dimensional functions, however, the derivatives become $4$, since we have:
> 
> - Pure second derivatives, which, like for their linear case, measure the _curvature_ of the function along one single axis: $\frac{\delta^2 f}{\delta x^2}, \frac{\delta^2 f}{\delta y^2}$
> - Mixed derivatives, which measure how multiple dimension interact: $\frac{\delta^2 f}{\delta x \delta y}, \frac{\delta^2 f}{\delta y \delta x}$
>   
> The general form of a quadratic approximation would thus become:
> 
> $$
> f(x+\Delta x, y + \Delta y) \approx f(x,y) + f_x \Delta x + f_y \Delta y + \frac{1}{2}[\Delta x(f_{xx} \Delta x + f_{xy} \Delta y) + \Delta y(f_{xy} \Delta x + f_{yy} \Delta y)]
> $$
> 
> Because we need to consider all second derivatives and all rate of changes. For example, the term $f_{xx}\Delta x$ considers a change in the function of $\Delta x$ multiplying it by the rate of change of the rate of change of $x$ (the second derivative). However, we have 4 possible total combinations:
> 
> - The change of $x$ with itself ($f_{xx} \Delta x \Delta x$)
> - The change of $x$ with respect to $y$ ($f_{xy}\Delta x \Delta y$)
> - The change of $y$ with itself ($f_{yy}\Delta y \Delta y$)
> - The change of $y$ with respect to $x$ ($f_{yx} \Delta y \Delta x$)
> 
> Meaning that if we multiply everything out, we obtain:
> 
> $$
> f(x+\Delta x, y + \Delta y) \approx f(x,y) + f_x \Delta x + f_y \Delta y + \frac{1}{2}(f_{xx} \Delta x^2 + f_{xy}\Delta x \Delta y + f_{yx}\Delta y \Delta x + f_{yy} \Delta y^2)
> $$
> 
> However, since $f_{xy} = f_{yx}$, we can compact this into:
> 
> $$
> f(x+\Delta x, y + \Delta y) \approx f(x,y) + f_x \Delta x + f_y \Delta y + \frac{1}{2}(f_{xx} \Delta x^2 + 2 \times f_{xy}\Delta x \Delta y + f_{yy} \Delta y^2)
> $$
> 
> In order to compact all our partial derivatives into a single term, we can use the definition of the **Hessian matrix**, which is a matrix containing all second-order partial derivatives of a function $f$. In our two-dimensional case, we have:
> 
> $$
> H = \begin{bmatrix}f_{xx} & f_{xy} \\ f_{yx} & f_{yy}\end{bmatrix}
> $$
> 
> The final step for simplification is made by showing that we can obtain the same quadratic term as above using the following expression:
> 
> $$
> (\Delta \theta)^T H \Delta \theta = \begin{bmatrix}\Delta x & \Delta y\end{bmatrix} \begin{bmatrix}f_{xx} & f_{xy} \\ f_{yx} & f_{yy}\end{bmatrix}\begin{bmatrix}\Delta x \\ \Delta y\end{bmatrix} = f_{xx}(\Delta x)^2 + 2f_{xy}(\Delta x \Delta y) + f_{yy}(\Delta y)^2
> $$
> 
> Meaning we can wrap this all up by writing the general form for a quadratic approximation of a multi-variable function as:
> 
> $$
> f(\theta + \Delta \theta) \approx f(\theta) + \nabla f(\theta)^T \Delta \theta + \frac{1}{2}((\Delta \theta)^T H \Delta \theta)
> $$

In general, if we have a quadratic or non-convex function, the convergence using the gradient descent method may be too slow. In order to simplify this, we can use Taylor's theorem to obtain a quadratic approximation for our function $L(D,\theta)$ around $\theta$ itself:

$$
L(\theta_{k+1}) \approx L(\theta_k) + \nabla L(\theta_k)(\theta_{k+1}-\theta_k) + \frac{1}{2}(\theta_{k+1}-\theta_k)^T H(\theta_{k+1}-\theta_k)
$$

This is just the application of Taylor's theorem to obtain a quadratic approximation for our multi-variable function, considering $a=\theta$ and $h=\theta_{k+1}-\theta_k$.

Outside of being useful for convergence reasons, Taylor's quadratic approximation can also help us to compute an optimal $\eta_k$, the learning rate at our iteration $k$, since we've seen before that a correct estimation is important to make the gradient descent converge faster. In particular, we previously saw that one iteration of our gradient descent algorithm returns the following parameters:

$$
\theta_{k+1} = \theta_k - \eta_k \nabla L(\theta_k)
$$

If we substitute this in the previous expression, we obtain the following formula:

$$
L(\theta_{k+1}) \approx L(\theta_k) - \eta_k ||\nabla L(\theta_k)||^2 + \frac{1}{2} \eta^2_k \nabla L(\theta_k)^T H_k \nabla L(\theta_k)
$$

So, rewriting for $\eta_k$:

$$
\eta_k = \frac{||\nabla L(\theta_k)||^2}{\nabla L(\theta_k)^TH_k\nabla L(\theta_k)}
$$

We can also simplify our above expression a bit. Since we are aiming to find a point of global minima, we can set the derivative of $L$ w.r.t. $\theta_k$ as being equal to $0$ (which is the definition of a stationary point). This allows us to simplify the term $\nabla L(\theta_k) + H_k(\theta_{k+1}-\theta_k) = 0$, getting the rule for the **Netwon-Raphson Method**:

> [!NOTE] Newton-Raphson Method:
> 
> $$
> \theta_{k+1} = \theta_k-H_k^{-1} \nabla L(\theta_k)
> $$
> 
> In pseudocode:
> 
> ```
> initialize new_theta, theta, K, epsilon
> for k in range(0, K-1):
> 	new_theta = theta - hessian_k_inverse * gradient_L(theta)
> 	if |gradient_L(theta) - gradient_L(new_theta)| < epsilon:
> 		 break
> 	theta = new_theta
> ```

The Newton-Raphson method allows for faster convergence, but it has a catch: the computation of the Hessian inverse is computationally expensive, and if it is badly conditioned then convergence may be problematic. Here, as an example, is the difference between steepest descent (red) and the netwon-raphson (black):

![newton vs steepest | center](https://i.imgur.com/XzsPidR.png)

We can also see a difference for quadratic obectives and non-convex objectives: in the second case, the Hassian inversion has a lot of numerical instabilities:

![quadratic objective | center](https://i.imgur.com/G3RuxZk.png)

![non-convex objective | center](https://i.imgur.com/Ok4SGmi.png)

Since these methods can be hard to compute, some more lightweight line-search methods are usually preferred to find an approximate good step size at each iteration, like [backtracking](http://fa.bianp.net/teaching/2018/eecs227at/gradient_descent.html). Other strategies just decrease $\eta_k$ at each iteration, like cosine annealing.

## Support Vector Machine

Support Vector Machines (SVMs) are a state-of-the-art technique used to solve problems that are non-linearly separable.

The idea of SVMs arises from a series of open problems in the linear function field. 

1. The first one can be stated like this: say that we have a classification problem with two classes that are linearly separable, meaning that we can use a linear discriminant function to label samples. However, there might be several candidates for a "good" function in a single hyperplane:

	![multiple valid functions | center](https://i.imgur.com/cElEhwy.png)

	So, the first problem is: how can we choose the best linear function among the infinite number of them?
2. The second one is about outliers: if we have a problem that is linearly separable, but finding an optimal solution forces us to have a "bad" linear function, how can we define a "relaxation" to allow some samples to be misclassified, in exchange of having a simpler linear function? For example, here we might want to leave the "outlier" `x` outside of the correct cluster:
   
   ![](https://i.imgur.com/8fFS3ra.png)
3. The third and last one is about non-linearly separable problems. For example, in this case there is no possible singular linear function that allows us to correctly label all of our data:
   
   ![non-linearly separable | center](https://i.imgur.com/5ohNTqD.png)

So, how do SVMs go on to solve these problems?

### Maximum Margin

The notion of "**Maximum Margin**" helps us solving the first problem, which states: "_how can we choose the best linear function among the infinite number of them?_". Following the example above, the black non-dotted line in the picture is the margin that would be chosen by an SVM as the correct one:

![SVM Maximum Margin | center](https://i.imgur.com/EEzoMDZ.png)

We can see that the black line is the function that creates the widest possible "gap" between the two clusters. Finding a maximum margin is only possible, in this case, if the data is linearly-separable (otherwise we would fall into problem $3$, which will be described later).

In this case, the SVM is able to find the best margin by first define so-called "_support vectors_", which are the training samples circled. These are essentially the points that are "the closest" to the other class and "at the margin" of the cluster of samples with the same class label. Note that because of this definition SVMs are able to define boundaries just thanks to these points, while the others are able to move freely (if they do not cross the boundary).

If we want to write this in formulas, we might want to say that the two class labels for red and blue are, respectively, $+1$ and $-1$:

$$
y_0 = +1, y_1 = -1
$$

This will be useful later on.

In our example, the dotted lines are linear functions that can be expressed in terms of $w,b$ in the following way:

$$
w \cdot x_1 + b = 1, w \cdot x_2 + b = -1
$$

Where $x_1,x_2$ are the points that are sitting on the dotted line on the red and on the blue class, respectively (our support vectors). Since we said that we aim to find the maximum margin, that is, the line with the widest gap between the two classes, this operation would amount to finding the line that passes _exactly_ in the middle of our two functions that pass through the SVs. To do this, we need to compute the Euclidean distance between the two lines using the following formula:

$$
\text{Margin} = (x_1-x_2) \cdot \frac{w}{||w||} = \frac{w \cdot x_1 - w \cdot x_2}{||w||} = \frac{(1-b)-(-1-b)}{||w||} = \frac{2}{||w||}
$$

Note that $||w||$ is the norm of the weight vector $w$, which is equal to:

$$
||w|| = \sqrt{\sum_{j=1}^d w_j^2}
$$

Now, since we want to find the line that is the furthest away for both classes, we would like to _maximize_ this margin. We can reframe this problem to make it computationally easier if we said that, instead, we would like to _minimize_ the value of $||w||$ (as it is the same logic, since $||w||$ is a denominator term, minimizing it implies maximizing the fraction). To make computation even easier for computers we can state our problem by saying that we want to minimize the following term (which is still the same as saying that we want to maximize $\frac{2}{||w||}$):

> [!NOTE] Minimization problem for SVMs
> 
> $$
> \text{min}_{w,b} L = \frac{1}{2}||w||^2 \text{, s.t. } y_i f(x_i) \geq +1, \forall i
> $$
> 
> Where $s.t. y_i f(x_i) \geq +1, \forall i$ (`s.t` = "subject to") is a constraint to ensure that samples are not misclassified, since they must not cross the boundaries determined by the support vectors.

To solve this minimization problem, we can use the _Lagrangian_ to use **Lagrange's Optimization Technique**. We start by writing the Lagrangian ($L$), which combines the function to be minimized with our constraints:

> [!NOTE] Lagrangian Function for SVMs
>
>$$
> L = \frac{1}{2}||w||^2 - \sum_{i=1}^t \alpha_i[y_i(w \cdot x_i + b)-1]
> $$
> 
> The right side with the summation operator acts as a "penalty" system, where:
> 
> - $y_i(w \cdot x_i + b)-1$ is the value of the classification function for a certain sample $x_i$, multiplied by the correct class label. This is used to represent "how much" the classifier has classified correctly the label. We subtract by $1$ so that if the classification is correct, we get $1-1=0$ (no penalty), or a negative value otherwise
> - $\alpha_i$ is a "_Lagrange Multiplier_", which is used to assign a heavier penalty in case of misclassification

Now, we aim to find the _maximum values_ for our Lagrangian multipliers $\alpha_i$, so that the Lagrangian function gets the minimum value:

$$
\text{max}_{\alpha_1, \dots, \alpha_l} \text{ min}_{w,b} L(\alpha_1,\dots,\alpha_l,w,b) \text{, s.t. } \alpha_i \geq 0, i=1,\dots,N
$$

Once the optimization finds the optimal point, the derivative of $L$ w.r.t. $w,b$ is nullified (as we've reached a stationary point), returning:

$$
w = \sum_{i}\alpha_iy_ix_i, \sum_i \alpha_iy_i=0
$$

If we substitute this into our original Lagrangian function, we obtain what's called the "dual problem for the hard-margin SVM":

> [!NOTE] Dual Problem for the Hard-Margin SVM
> 
> $$
> \text{max}_\alpha \sum_i \alpha_i-\frac{1}{2} \sum_{i,j}y_i\alpha_i x_i^T x_j \alpha_j y_j \text{, s.t. } \alpha_i \geq 0, \forall i, \sum_i \alpha_i y_i = 0, \forall i
> $$

To solve this maximization problem, we can calculate again the Lagrangian:

$$
L_D(\alpha) = \sum_i \alpha_i - \frac{1}{2}\sum_{i,j}y_i\alpha_ix_i^Tx_j\alpha_jy_j
$$

Whose optimal solution is given by the following hyperplane:

$$
\sum_{i=1}^l y_i\alpha_i (x_i \cdot x) + b = 0
$$

However, note that all samples have an $\alpha_i=0$, except for _support vectors_. This is the mathematical representation of what was written at the beginning: SVMs rely only on support vectors for their calculation, while the other points can move freely as long as they do not cross the lines.

### Soft Margin

**Soft Margins** are the solution for the second problem we proposed: "_if we have a problem that is linearly separable, but finding an optimal solution forces us to have a "bad" linear function, how can we define a "relaxation" to allow some samples to be misclassified, in exchange of having a simpler linear function?_"

In order to do this, we need to find a way to add a sort of "trade-off" to our formula between margin and loss on training data. To do this, we use a hyperparameter $C$:

> [!NOTE] Hyperparameter $C$ for Soft-Margin SVM
> 
> $$
> \text{min}_{w,b,\xi_i} \frac{1}{2}||w||^2 + C \sum_i \xi_i \text{, s.t. } y_i f(x_i) \geq 1 - \xi_i, \forall i\ \ \xi_i \geq 0, \forall i
> $$
> 
> Where $\xi_i$ is called a "slack variable", which defines "how far" a sample lies with respect to the support vector of the correct class:
> 
> ![slack variable | center](https://i.imgur.com/U7rjjK3.png)

Tuning the hyperparameter $C$ now allows us to define a "relaxation" for SVMs: smaller values of $C$ allow for simpler classification functions:

![C hyperparameter | center](https://i.imgur.com/wfqw1cL.png)

We specified two constraints for our hyperparameter:

1. $\xi_i \geq 1 - y_i f(x_i)$
2. $\xi_i \geq 0$

We can however rewrite them into

$$
\xi_i = \text{max}(0,1-y_i f(x_i))
$$

This expression, however, is the same as that of the _hinge loss_: this means we can use it to have an unconstrained version of the first problem (without having to abuse the Lagrangian):

> [!NOTE] Simplified hyperparameter problem
> 
>$$
>\text{min}_{w,b}\frac{1}{2}||w||^2 + C \sum_i \text{max}(0,1-y_if(x_i))
>$$

We said that, in order to make this minimization problem work, we need to follow a couple of constraints:

1. The derivative of the Lagrangian with respect of $w$ must be zero: $w_v - \sum_i \alpha_i y_i x_{iv}=0$
2. The derivative of the Lagrangian with respect of $b$ must be zero: $-\sum_i \alpha_i y_i=0$
3. Finally, we must also make sure that the derivative of the Lagrangian with respect to our new hyperparameter $\xi_i$ is zero: $C-\alpha_i-\mu_i=0$.

We can put all these into the initial Lagrangian:

$$
L_P = \frac{1}{2}||w||^2 + C\sum_i \xi_i - \sum_i\alpha_i \{y_i(x_i \cdot w + b) - 1 + \xi_i\} - \sum_i \mu_i\xi_i
$$

Plugging our constraints in, we obtain a very similar equation to that for hard margins SVMs:

> [!NOTE] Dual form of the Soft-margin SVM
> 
> $$
> \text{max}_\alpha \sum_i \alpha_i - \frac12 \sum_{i,j} y_i \alpha_i x_i^T x_j \alpha_j y_j \text{, s.t. } 0 \leq \alpha_i \leq C, \forall i\ \ \ \sum_i \alpha_i y_i =0, \forall i
> $$

The reason why SVMs only detect a couple of support vectors is that the maximization problem has a _sparse_ solution, meaning that a lot of $\alpha$ values will be equal to $0$. Specifically, in a dataset like this:

![dataset sample svm | center](https://i.imgur.com/IvwNNuv.png)

We can have three possible points:

1. Those that are not circled, being samples that are correctly classified
2. Those that are circled, which act as support vectors, and are used to calculate the soft margin
3. Those that cross the support vector (not present in the picture), that fall into the accepted margin of error defined by the hyperparameter $C$.

All these can be represented mathematically using **Karush-Kuhn-Tucker equilibrium conditions**:

> [!NOTE] Karush Kuhn Tucker equilibrium conditions
> 
> $$
> g_i = \frac{\delta W}{\delta \alpha_i} = \sum_j Q_{ij} \alpha_j + y_ib -1 = y_i f(x_i) - 1
> $$
> 
> $$
> \frac{\delta W}{\delta b} = \sum_j y_j \alpha_j = 0
> $$
> 
> In particular, the value of $g_i$ can be:
> 
> 1. $g_i \geq 0 \implies \alpha_i =0$, for _reserve vectors_ (case $1$ of possible points)
> 2. $g_i=0 \implies 0 < \alpha_i < C$, for margin _support vectors_ (case $2$)
> 3. $g_i \leq 0 \implies \alpha_i = C$, for _error support vectors_ (case $3$)

To solve both primal and dual SVM learning, we can use **Quadratic Programming solvers**, which are standard and efficient. However, there are now more modern solvers specifically for SVMs, like **Sequential Minimal Optimization (SMO)**, which, however, does not scale well for very large training sets, which is the reason why modern techniques prefer optimizing the primal form using **Stochastic Gradient Descent (SGD)**, which works like this:

1. Set the learning rate $\eta$
2. Repeat until an approximate minimum is obtained, by:
	1. Randomly selecting $K$ samples from the training set
	2. Updating the parameters $w'=w-\eta \nabla L$

This type of algorithm (and its variants) is very efficient and incremental, allowing to load data in batches instead of having to load all the dataset, and allows to satisfy the convergence constraint in practice, but parameters can be difficult to tune.

### Kernel Trick

Now that we've seen how to surpass the two most common problems of linear classifiers, we are left to deal with the last one: "_how can we use linear classifiers for non-linearly-separable problems?_"

We must start by saying that classical SVMs as we've seen can actually deal with these class of problems, although they show poor performances. To increase efficiency, we can exploit the so-called "**Kernel Trick**", but how?

![Non-linearly-separable problem | center](https://i.imgur.com/xnsqqtm.png)

One common solution that is used in cases where data isn't linearly separable is to _transport it into higher dimensions_. This is stated as **Cover's Theorem**:

> [!NOTE] Cover's Theorem
> 
> _A complex pattern-classification problem cast in a high-dimensional space non-linearly is more likely to be linearly separable than in a low-dimensional space_

 As an example, imagine having a set of data in two spacial dimensions (so one feature) that isn't linearly separable, like this:

![poor performance svm | center](https://i.imgur.com/hugGxDL.png)

Here, an SVM performs poorly, since it can't find no singular line to clearly separate the two classes. However, we can imagine to "transport" this problem into a 3-dimensional space where it can solved more easily, while at the same time _keeping_ the structure of the data intact. This can be done through a _feature map_, which acts as a "translation function" for a data sample into an higher dimension. For example, imagine that we had the following feature map:

$$
\phi((a,b)) = (a,b, a^b+b^2)
$$

Meaning that any point with coordinates on the 2D plane of $(x,y)$ will have coordinates $(x,y,x^2+y^2)$ on our 2D plane. Note that, since we are not changing the relation between $x$ and $y$, the new plane still acts as a loyal representation of our training set. So why is this useful? Because in higher dimensions we are always able to find a _hyperplane_ which is able to linearly separate the data, given a good enough feature map, like this one:

![feature map | center](https://i.imgur.com/iVWWuwM.png)

This allows us to treat non-linearly-separable problems as if they were separable, skipping the need for polynomial and non-linear functions.

This technique, however, has one constraint: when treating billions or trillions of training sample in spaces which are in the order of the thousands of dimensions makes applying the feature map computationally unfeasable. The kernel method is designed to bypass this caveat.

To understand its implications, we start by recalling the dual SVM formulation:

$$
\text{max}_\alpha \sum_i \alpha_i -\frac12 \sum_{i,j} y_i \alpha_i x_i^T x_j \alpha_j y_j \text{ s.t. } 0\leq \alpha_i \leq C, \forall i\ \ \ \ \sum_i \alpha_i y_i = 0, \forall i
$$

Once $\alpha$ is found, we have our classification function:

$$
f(x) = w^T x + b = \sum_i y_i\alpha_i x_i^Tx + b
$$

If we take a closer look at both of these equations, we see that the data samples $x_i$ are never considered by themselves: instead, they are always shown as a _dot product_ with another sample ($x_i^Tx$ and $x_i^Tx_j$). This is important because it allows us to use so-called **Kernel Functions**:

> [!NOTE] Kernel Functions
> 
> A Kernel functions is a function in the form:
> 
> $$
> k(x_i, x_j) = \phi(x_i)^T \phi(x_j)
> $$
> 
> Where $\phi(x)$ is a feature map that translates a spatial point into higher dimensions.

In order to be acceptable, kernel functions must also validate some constraints:

> [!NOTE] Kernel Functions Constraints
> 
> 1. **Mercer's Condition**: the function $k(x_i,x_j)$ must correspond to a scalar product in some other space
> 	- _This condition is set in order to satisfy the assumption of a kernel function being a "shortcut" to the calculation of a scalar product in higher dimensions_
> 2. Kernel functions are symmetric and positive semi-definite (PSD) if:
>    
>    $$
>   \sum_{i,j=1}^n c_ic_jK(x_i,x_j) \geq 0 \text{, for any } n \in N, x_1,\dots,x_n \in X, c_1,\dots,c_n \in R
>   $$
> 	  - _This condition ensures that the higher-dimensional space defined by $K$ is actually coherent and exists_. However, this condition _can_ be relaxed, since SVMs also converge when a kernel is non-PSD, although the problem is not convex anymore.

Once we have defined our kernel function, we just replace every instance of our dot product with it, in order to translate our classification problem into higher dimensions where the data is linearly separable:

$$
\text{max}_\alpha \sum_i \alpha_i -\frac12 \sum_{i,j} y_i \alpha_i k(x_i^T,x_j) \alpha_j y_j \text{ s.t. } 0\leq \alpha_i \leq C, \forall i\ \ \ \ \sum_i \alpha_i y_i = 0, \forall i
$$

$$
f(x) = w^T x + b = \sum_i y_i\alpha_i k(x_i^T,x) + b
$$

So, our new SVM performs in the following way:

1. Maps the data of the input vector $x$ into an high-dimensional space, hidden from the inputs or the outputs
2. Constructs an optimal hyperplane that separates the data optimally in the new, high-dimensional space

> [!NOTE] Common Kernel Functions
>
> Some common kernel functions are:
> 
> 1. The **polynomial kernel**:
>   
>    $$
>   K(x_i, x') = (1+x_i^Tx')^d \text{ with } d= \text{the number of dimensions}
>   $$
>    
>    Before application:
>    
>    ![pre-kernel | center](https://i.imgur.com/GLglZlq.png)
>
>    After application ($d=2$):
>	
>    ![post-kernel | center](https://i.imgur.com/PtmEM4p.png)
>
>
> 2. The **Gaussian Kernel** (Radial Basis Function, RBF)
>    
>    $$
>   K(x_i,x')=e^{-\lambda(x_i-x')^2} 
>   $$
>  
>    ![rbf | center](https://i.imgur.com/m0ldL4q.png)
 
### Regularizers and Sparcity

The primal SVM problem:

$$
\text{min}_{w,b} C \sum_i \text{max}(0,1-y_i f(x_i)) + \frac12 ||w||^2
$$

can also be seen as an instance of a more general problem of linear classifiers:

$$
\text{min}_{w,b} \frac1n \sum_{i=1}^n l(y_i,f(x_i)) + \lambda \Omega(w)
$$

Which is the formula for minimizing the generalization error on test data. To go into more details, $\Omega(w)$ is called a "**regularizer**", which acts as a mathematical penalty to avoid overfitting on complex functions. This is done by making sure that the number of weights $w$ doesn't get too high. To allow algorithms to minimize regularizers more easily, they are usually expressed in the form of _convex functions_. There are several types of regularizers, but all of them are generally expressed in the form of norms, called $l_p$ norms:

> [!NOTE] $l_p$ norms
> 
> $$
> l_p(w)=(\sum_j |w_j|^p)^{\frac1p} \text{, with } p \geq 1
> $$

$|w_j|$ is the mathematical operation of the _absolute value_, and $w_j$ is one of the weights of the classification algorithm. The idea of $l_p$ norms is to penalize functions that have higher values for the weights and a very high amount of them (because the sum increases). The different values of $p$ are used to incur higher or smaller values of $\Omega(w)$: if $p$ is smaller, then regularizers incur greater penalties for classifiers that have some single weights that are much bigger then the others, while higher values of $p$ tend to prefer classification functions where the value of weights is "spread out". For example, if we had two models, $A$ and $B$ with weights $w_{A1}=10, w_{A2}=0$ and $w_{B1}=5,w_{B2}=5$, then the values of the $l_1$ and $l_2$ norms are:

$$
l_{1A} = |10| + |0| = 10,\ l_{1B} = |5| + |5| = 10
$$

$$
l_{2A} = \sqrt{10^2 + 0^2} = 10,\ l_{2B} = \sqrt{5^2 + 5^2} \approx 7.07
$$

We can see that taking the $l_1$ norm makes $\Omega(w)$ penalize both models equally. However, the $l_2$ norm treats model $A$ as more complex then $B$, since the weights are not as "spread out" as $B$'s. This concept of enforcing many values of the weights to be zero is called "**sparcity**", and is enforced by $l_0$ and $l_1$ norms:

![sparcity | center](https://i.imgur.com/c1SbU9l.png)


The most popular example of norms are:

- $l_0$, which is not convex, and amounts to counting all non-zero elements in $w$
- $l_1$ = $|w_1|+|w_2|+\dots+|w_d|$
- $l_1$ = $w_1^2+w_2^2+\dots+w_d^2$
- $l_\infty = \text{max}_j |w_j|$

Graphically:

![lp norms | center](https://i.imgur.com/Pa6JNUx.png)

### Multiclass Linear Classifier

If we take the most general version of a linear classifier:

$$
f(x) = w^T x + b
$$

we can see that it can be adapted to be used for multiclass problems as well. Graphically:

![multiclass linear classifier | center](https://i.imgur.com/vLMZpq7.png)

The idea is that we can make the classifier output one score per class: 

$$
f(x) = (s_1, \dots, s_k)
$$

Then, outputs are _softmax scaled_. The softmax function is:

$$
s' = \frac{1}{1+e^{-s}} \to s_l' = \frac{e^{s_l}}{\sum_j e^{S_j}}
$$

Then we calculate the cross-entropy loss:

$$
L(y_i, f(x_i)) = -\log(s'_{y_i})
$$

To end up with a result like this:

![softmax classifier | center](https://i.imgur.com/y0wR8HK.png)

### Multiclass Classification with Binary Classifiers

Binary classifiers can also be adapted to work for multiclass problems: since a sample can be part of only one of $c$ classes, we can use two different strategies.

The first one is called **One-vs-all** (OVA, or one-versus-rest, OVR): we train one binary classifier for each of the $k$ class. Samples that have $y=k$ are labeled as $+1$, while all the others are labeled as $-1$. Graphically:

![OVA | center](https://i.imgur.com/uAx9Dxh.png)

We then combine them all using 

$$
y = \text{argmax}_k\ f_k(x)
$$

![OVA classifier | center](https://i.imgur.com/3qPH0Y2.png)

This strategy has the advantage of being trained with one classifier per class, and thus uses all the data.

The second strategy is the **One-vs-one**: we train a binary classifier for class $i$ vs $j$. We then consider all possible pairs, which are $c(c-1)/2$ in total. They are then combined as:

$$
f(x) = \text{argmax}_i (\sum_j f_{ij}(x))
$$

This strategy has a combinatorial number of classifiers, and is thus trained on smaller data subsets. The accuracies of the two classification strategies are almost equivalent, but there is a trade-off between the number of classifiers and the complexity of the algorithm.

### Regression

So far, we have used the loss function to assign a penalty if the label of a class is given incorrectly: for example, the hinge loss gives $0$ penalty to points for which $yf(x) \geq 1$. For regression problems, however, the loss is zero only if $f(x) = y$. One famous regression algorithm is called "**Ridge Regression**":

> [!NOTE] Ridge Regression
> 
> The ridge regression uses the mean squared error (MSE) as the error function, and $l_2$ as the regularization for the feature weights:
> 
> $$
> L(w) = \frac{1}{2n}||Xw-y||^2 + \lambda||w||^2
> $$

By minimizing $L(w)$ we get the following closed-form solution:

$$
w = (X^T X + \lambda I)^{-1} X^T y
$$

Where $I$ is the identity matrix, and $\lambda > 0$ a trade-off parameter. Its use is to add a diagonal to the matrix $X^TX$, which is positive semi-definite, to make it more stable when pseudo-inverted. However, this operation is almost always too computationally demanding for large datasets, so gradient-descent procedures, like SGD, are preferred.

If we change the regularization term to $l_1$ we get the **Least Absolute Shrinkage and Selection Operator (LASSO)** algorithm:

$$
L(w) = \frac{1}{2n} ||Xw - y||^2 + \lambda||w||_1
$$

Combining both regularization techniques is used by the **Elastic Net**, to overcome some problems when we have badly-conditioned problems:

$$
L(w) = \frac{1}{2n} ||Xw - y||^2 + \lambda||w||_1+ \lambda_2 ||w||_2^2
$$

> [!HELP] Exercises
> 
> TODO

# Neural Networks

> [!NOTE] Note
> 
> This first part about neural networks is almost identical to the one made for the course of machine learning, so some arguments are represented more quickly

Neural Networks are born from the idea of **perceptrons**, which are an abstraction of the idea of a neuron: units that fire off after a certain activation condition is met:

![perceptrons | center](https://i.imgur.com/jY548EC.png)

Perceptrons are effectively linear classifiers, where $f(x) = w^T x + b$ is the linear discriminant function. The learning algorithm thus amounts to minimizing the value of $w,b$ to "fire" the perceptron. The loss function, in this case, is the perceptron loss:

$$
L(w,b) = \sum_i \text{max}(0,y_i f(x_i)) = -\sum_{i:y_if(x_i)<0}y_i f(x_i)
$$

Where $i$ indexes are the misclassified samples. We minimize it using the gradient descent method:

$$
\nabla_w L(w,b) = -\sum_{i:y_i f(x_i)<0}y_i x_i
$$

$$
\nabla_b L(w,b) = -\sum_{i:y_i f(x_i)<0}y_i
$$

And thus the learning algorithm is very similar to that of linear classifiers:

```
function learning({x_i,y_i})
	randomly initialize w,b
	repeat
		for i=1,...,n
			if y_if(x_i) < 0
				w <- w - n partial_derivative_w(L(w,b))
				b <- b - n partial_derivative_b(L(w,b))
	until a stopping condition is satisfied
	return w,b
```

Where $n$ (actually, $\eta$) is the learning rate. Since a perceptron is a linear classifier, the perceptron learning algoruthm always converges to a consistent hypothesis after a _finite_ number of epochs, if $\eta > 0$ and if the training set is linearly separable (usually we have $\eta = 1$). If the training set, however, is not linearly separable, weighs start oscillating after $n$ epochs.

Perceptrons fell out of favor after the realization that they were unable to represent non-linear functions, and that they gave a too-oversimplified explanation of the human neuron. In reality, neurons are often wired between them in so called **Neural Networks**. ANN (Artificial Neural Networks) are made up of interconnected perceptrons, and are able to represent non-linear discriminant functions.

Interest in ANNs was lost in the 1970s due to some technical limitations, but it was recovered in the 1980s with the following discoveries:

- Instead of generating a layer architecture every time, we use some common ones that are known to work
- To improve the learning algorithm, feed-forward networks and continuous activation functions can be used

The most common activation functions for ANNs are the sigmoid:

$$
\sigma(x) = \frac{1}{1+e^{-f(x)}} \in (0,1)
$$

and the hyperbolic tangent:

$$
\sigma(x) = \frac{e^{f(x)}-e^{-f(x)}}{e^{f(x)}+e^{-f(x)}} \in (-1,1)
$$

Then, the individual perceptron units with these activation functions are arranged into _layers_, in the following way:

1. One single _input_ layer, which are fictitious units corresponding to inputs
2. One output layer, which can consist of one unit for two-class problems, or $c$ units for $c$-class problems ($c > 2$)
3. One or more _hidden layers_

Each unit receives inputs from the previous layer (hence the name "feed-forward"), and the output of a layer is the input of the next one. These network are thus usually **fully-connected**, like this:

![MLP | center](https://i.imgur.com/pjkPPqb.png)

We can see that the final classification function is the result of the _composition_ of the activation function of the individual layers:

$$
f(x;\theta) = g_3(\cdot;w_3,b_2) \circ g_2(\cdot;w_2,b_2) \circ g_1(x;w_1,b_1)
$$

Where $g$ is a generic continuous activation function:

$$
g(\cdot; W, b) = \sigma(Wx+b)
$$

But since $\sigma$ is a continuous function, we convert it to a class label by defining a certain threshold, like this:

$$
\text{label} = \begin{cases}-1 & \text{if } \sigma(x) < 0.5 \\ +1 & \text{otherwise}\end{cases}
$$

We can also generalize the two-class problem to a multi-class problem using the _softmax_ approach:

$$
p(y=j\ | \ x) = \frac{e^{f_j(x)}}{\sum_{k=1}^ce^{f_k(x)}}
$$

However, since the target function is usually not known in real cases, the best MLP arcihtecture is not known a priori, and is instead built using a trial-and-error approach, starting with a small network (one hidden layer and a couple of units) and adding complexity as the problem becomes more complex.

## Back-Propagation Learning

One of the most efficient learning algorithm for ANN is the **Back-Propagation Learning**. The idea is to exploit the fact that, since the activation functions for individual perceptrons are both continuous and differentiable, the network output function will also have the same property. This means that we can use a _loss function_ that is continuous and differentiable, and then minimize it using **gradient descent**.

> [!NOTE] Back-Propagation Learning
>
> The back-propagation learning algorithm consists of two steps:
> 
> 1. First is the **forward step**: we compute the output function of the ANN for a given input (that is, we just pass a sample to our network and see the result). We then compute our _loss function_ for this given input
>
>	![Forward step | center](https://i.imgur.com/LceQanl.png)
>
> 2. Then is the **backward pass**. In order to apply the gradient descent, we need to compute the derivative of our loss function $L$ with regards to the parameter $w$. To do this, we can exploit the fact that the final loss function $L$ can be rewritten via composition:
> 
>	![backward pass | center](https://i.imgur.com/cyO9kNZ.png)
>
>	Meaning that the final derivative is:
>
>	$$
>	\frac{dL}{dw} = ((\frac{dL}{d\sigma} \cdot \frac{d\sigma}{df})\cdot \frac{df}{dw})
>	$$
>	
>	This is because the derivative of a composite function is equal to the product of the composed functions, per the chain rule.

In pseudocode:

```
back-propagation(T):
	randomly chose the weights w
	repeat
		for each (x^k,t_k) in T do
			compute the output y(x^k) // forward propagation
			update the weights w // back propagation
		end for
	until a stop condition is satisfied
	return w
```

However, we need to prevent two problems:

1. Error functions have many local minima, so it is not guaranteed that if the back-propagation algorithm converges to a value, then the value found is also a global minima
	- To prevent this, we execute the same algorithm starting from different random weights, and then take the solution with the smallest error
2. NNs are prone to over-fitting
	- To prevent this, we set a stop condition to halt the algorithm early. For example, we can use two set, one for validation and one for training. Then we compute the error on the validation step and stop if the two are too distant, like in this case, where the vertical line represents the optimal stopping condition:
	  
	  ![stop condition for overfitting | center](https://i.imgur.com/59rrBtA.png)

	- We can also avoid overfitting by using a regolarized objective function, like for linear classifiers:
	  
	  $$
	   E(w) = \frac{1}{2n} \sum_{i=1}^n(\alpha(x_i) -y_i)^2 + \lambda \Omega(w)
	   $$

## Deep Neural Networks

Deep Neural Networks (DNNs) are an evolution of ANNs. They are, in fact, neural networks, but they work with many hidden layers:

![DNN | center](https://i.imgur.com/0rjwTAX.png)

The advantage of DNNs is that they are able to learn not only to _classify_ data, but also the core **feature representation** of data itself.

The first problem that came out in the design of DDNs is the **vanishing gradient problem**: the gradient descent method used for ANNs requires taking the derivative of the sigmoid function (or, in general, any activation function). However, the back-propagation step ends up propagating a lot more times in DNNs (since there are many hidden layers), and since the gradient of $\sigma$, which is $z(1-z)$, is closer to $0$ than $z$, the effect is that the gradient tends to become zero going back, and this slows down the training of initial layers.

This problem is solved by using a **Rectified Linear Unit (ReLU)** activation instead of the sigmoid:

![](https://i.imgur.com/9jyKked.png)

## Convolutional Neural Networks

An important application of DNNs is found in the field of computer vision tasks, where some specialized applications, named **convolutional neural networks (CCNs)**, have been proposed.

These networks work by taking as input, for example, a _raw image_, arranging its pixels into an array. CNNs, however, are not fully-connected (in contrast to common ANNs), since the idea is to use the **spatial adjacency** between pixels to recognize figures and other features.

Basically, each hidden unit of a CNN works by operating different image processing operations. these operations allow us to make a distinction into two different kinds of layers:

- **Filtering** layers, whose connection weights are learnt, and have the job of "transforming" the data for the next layers
  
  ![filters | center](https://i.imgur.com/8LMxnu0.png)

- **Pooling** layers, which have some predefined connection weights, and are supposed to carry out a _downsampling_ operation on the outputs of the previous layers. Their goal is to "simplify" the architecture by considering a "smaller" or "more generalized" subset of data

  ![pooling | center](https://i.imgur.com/jQJ73Ws.png)

Through optimization, the CNN learns many more complex and abstract notions:

![CNN | center](https://i.imgur.com/ZM5ITLe.png)

## Optimization

The output function of a neural network is in the same form as that of common ANNs, but with more nested hidden layers:

$$
f(x;\theta)=g_k \circ g_{k-1} \circ \dots g_1(x;w_1,b_1)
$$

However, as we've seen before, the activation function of DNNs is typically _not convex_ w.r.t. $\theta = (w_1,b_1,\dots,w_k,b_k)$, meaning that the problem of optimization cannot be solved with the same techniques used for convex problems. Graphically, we can see the difference of a convex classification function for ANNs on the left and a non-convex one for DNNs on the right:

![ANNs vs DNNs | center](https://i.imgur.com/2CTmmhg.png)

To overcome this limitation, we use some variants of the gradient descent methods, which are still gradient-based but allow us to:

- Load data in batches
- Update the gradient for the current batch only, once per iteration

The most popular methods to perform optimization include "Adam", "Adagrad", "RMSProp" and "Momentum".

One of the most popular amongst these is "Momentum". The idea is to update the gradient $g_k$ as an average across multiple iterations, with weights $\beta$:

$$
v_k = \beta v_{k-1}+ g_k\ \ \ \ \ \theta_k = \theta_{k-1}-\eta_k v_k
$$

If we take $\beta=0$, this becomes essentially the same as the steepest descent method:

$$
v_k = g_k\ \ \ \ \theta_k = \theta_{k-1}-\eta_k g_k
$$

This is because $\beta$ acts as a parameter to "smooth" the objective function to facilitate convergence. Graphically we can see the difference between the application of the Stochastic Gradient Descent with and without momentum:

![SGD with momentum | center](https://i.imgur.com/879fgzs.png)

Other techniques to facilitate learning involve:

- **Dropout**: which consists of randomly deactivating some neurons during training to prevent overfitting
- **Batch normalization**: which consists of normalizing inputs so that they have zero mean and unit variance, which are estimated separately for each batch

The hard work for DNN learning can nowadays be automatized with many open-source frameworks, such as **Tensorflow**, **PyTorch**, etc.

> [!HELP] Libraries
> 
> This part is missing but is very short, it can be entirely recovered from the slides.

## Adversarial Attacks

DNNs, although inspired by the human brain, can actually be tricked much more easily via the use of **adversarial examples**, which are a set of attacks used to push a DNN towards misclassifying a sample:

![adversarial example | center](https://i.imgur.com/aBlFvrm.png)

These attacks exploit the inner mechanisms of DNNs, which aim to minimize the values of the error function by changing the parameters: 
$$
\text{min}_w L(D;w)
$$

Adversarial attacks are modeled in the exact same way, but they aim to **maximize** the error on the input data:

$$
\text{max}_w L(D;w)
$$

Say, for example, that we have the image of a parrot that is correctly classified by a DNN:

![Correct classification | center](https://i.imgur.com/EVMUqkG.png)

However, the maximization problem described above which is used by adversarial attacks can also be solved using _gradient-based optimizers_. The solution to this maximization creates an "**adversarial perturbation**", which, added to the original image, causes the DNN to misclassify the sample:

![adversarial attack | center](https://i.imgur.com/H46Jj7v.png)

We can formalize this attack as an optimization problem:

$$
\text{min}_{x'} g(x') \text{, s.t. } ||x-x'|| \leq \epsilon
$$

![projected gradient descente | center](https://i.imgur.com/DlenKYJ.png)

## Beyond DNNs

An evolution to the world of DNNs was introduced with the invention of **Generative Adversarial Networks (GANs)**:

![GANs | center](https://i.imgur.com/j295rwV.png)

They have a wide range of applications, in particular to image and text processing and manipulation:

![image manipulation by a GNN | center](https://i.imgur.com/seMlCjk.png)

# Performance Evaluation

In the previous parts we described how it is theoretically possible to calculate the exact error probability in a limited number of special cases. However, since in real-world problems the decision regions are almost never known a-priori, the error probability can only be "estimated" using the "design set $D$".

The other problem is that we can never reach a big enough set that contains all possible examples of the object we want to recognize: if we wanted to build a perfect classifier for sea bass, we would probably need an infinite amount of training data which is also "sparse" enough. This is the so-called "**Issue of generalization** (error)". This means that we can only estimate error using "patterns", in order to have a reliable estimate on how the classifier will perform on future, unknown samples and patterns found in the wild.

## Apparent Error

If we have a datased $D=[x_1,x_2,\dots,x_n]$, the easiest way to compute the error is to apply our classifier to all $n$ patterns in $D$ and compute the rate of misclassified ones:

$$
\text{Apparent Error} = \frac{n_{\text{err}}}{n}
$$

This error is called "apparent" because it is actually a _very optimistic_ estimate of the true error, because we have no idea on how the classifier will operate on actual unknown patterns (this is the problem of overfitting: we can have a classifier that performs incredibly well on a small subset, but terribly on another).

## Hold-out

A better method to estimate a more reasonable error is called "**Hold-out**". The idea is to take $D$ and divide it into two, disjoint subset:

1. The _training set_ is used to train the classifier (typically the bigger one)
2. The _test set_ is used to assess the error probability

The error computed on the test set is usually _pessimistic_, and we can improve on its reliability by doing different trials with different sets, to then compute the mean value and the standard deviation of the error estimation.

## K-fold Cross Validation

Another technique is called "**K-fold Cross Validation**". The idea here is to take $D$ and divide it into $K$ subsets of size $n/K$. Then, we design the classifier by

1. Uniting $k-1$ subsets, that make our training set
2. Estimate the error on the $k$-th set left out
3. Repeat this $k$ times
4. Compute the mean value and standard deviation of the error estimation

If we have $K=n$, the technique is named "**leave-one-out**".

## Bootstrap

Here, we generate $L$ subsets of size $n$ by random sampling from $D$ with replacement. Then, we compute the mean value and the standard deviation with the $L$ subsets.

### Choosing a method

In general:

- If $D$ is small, K-fold cross validation or bootstrap should work reasonably well, but are expensive
- If $D$ is large, hold-out should be ok

Also, if $D$ is very large it is usually better to split it into three parts:

1. The training set
2. The validation set
3. The **test set**

The test set is used as a second check to prevent the classifier from overfitting:

![validation vs test set | center](https://i.imgur.com/Occxv8d.png)

Also, performance evaluation is influenced by multiple factors:

1. The choice of the test set data: different data results in different performance evaluation
2. The choice of the training set data: some classifiers are unstable, meaning that small changes in the training data cause large changes in the error estimation
3. The "randomness" in the initialization of some classifier parameters

Meaning that the best choice is usually to test an algorithm with different sets to have more reliable results.

In particular, if the **standard deviation** of the classifier error is acceptable, then the set $D$ can be used to both design and train the classifier. If, instead, the deviation is large, different methods should be used.

## Confusion Matrix

We can also compute the classifier performance using a "**Confusion Matrix**". It is a matrix for $c$ classes of size $c \times c$: the rows represent the true classes, while the columns the _predicted ones_. The element $(i,j)$ of such a matrix provides a value estimating the probability of a sample class $\omega_i$ being predicted as $\omega_j$, while the diagonal elements represent the correct classification probabilities:

![Example confusion matrix | center](https://i.imgur.com/7l5qWQY.png)

# Data Clustering

Up until known, all the algorithms described fall into the category of "**supervised learning**": we devise a learning algorithm that is able to "better itself", since all training samples are also labeled with their correct class. However, this approach is sometimes not feasible in the real world: collecting and labeling data might be extremely costly and sometimes entirely impossible.

**Unsupervised learning** solves this problem by taking the opposite route: instead of having a defined set of classes before the training starts, the algorithm is required to identify the **clusters** of data that are not known a-priori, to get some insight into the structure of the data used. Naively, this problem might be stated in the following way:

> [!NOTE] Unsupervised Learning
> 
> An unsupervised learning algorithm categorizes data samples from a set $D$ by partitioning it into smaller clusters which are not known before training.

However, this intuitive notion gets messy very quickly, even for humans. For example, how many clusters could be created from this image?

![clustering example | center](https://i.imgur.com/GByCMyr.png)

![many possible clusters | center](https://i.imgur.com/uwgs1Mp.png)


Not to mention the many cases of _optical illusions_ and cognitive biases.

To solve this issue, clustering algorithms work through different kinds of categorization rules, such as:

- **Connectivity-based** clustering
	- i.e., Linkage Clustering
- **Centroid-based** clustering
	- i.e., the K-means algorithm
- **Model-based** clustering
	- i.e., the Gaussian mixture
- and others

## Linkage Clustering

Linkage clustering is a _Connectivity-based clustering_ algorithm: it exploits the links and connections in the data set to create clusters of interconnected data.

It starts by defining a cluster per sample, known as a _singleton_. These singletons are then combined sequentially into larger and larger clusters, until all of the elements are in a single one. The aggregation condition is that clusters are united if they have the _shortest distance_ among all the others, which is defined by the **linkage function**, of which there are many variants:

- **Single-linkage** function, which calculates the distance between the _closest_ points of two clusters:
  
  $$
   D(C_1,C_2) = \text{min}_{x_1 \in C_1, x_2\in C_2} d(x_1,x_2)
   $$

* **Complete/Maximum-linkage** function, which calculates the distance between the _farthest_ points of two clusters:
  
  $$
   D(C_1,C_2) = \text{max}_{x_1 \in C_1, x_2 \in C_2} d(x_1, x_2)
   $$

* **Average-linkage** function, which calculates the average distance among all points of two clusters:
  
  $$
   D(C_1,C_2) = \frac{1}{|C_1||C_2|} \sum_{x_1 \in C_1} \sum_{x_2 \in C_2} d(x_1,x_2)
   $$

* **Centroid-linkage** function, which calculates the squared distance of the centroids (the average center points) of the two clusters:
  
  $$
   D(C_1,C_2) = ||\mu_1 - \mu_2||^2 \text{, with } \mu_k \text{ the centroid of } C_k
   $$

Note how $d(x_1,x_2)$ can be any function to calculate distances.

> [!HELP] Visual example of single-linkage
> 
> The single-linkage algorithm starts by creating singleton clusters of data. Here, for example, we have a total of $5$ samples: the elements of the table represent the distance between the clusters.
> 
> ![samples | center](https://i.imgur.com/BEY23XE.png)
> 
> Then, the algorithm starts by grouping the closest ones: in this case, the samples smallest distance is that between $a$ and $b$, meaning they can be grouped:
> 
> ![grouping b | center](https://i.imgur.com/r7rhbL1.png)
> 
> We can then iterate this process to now group $c,e$ as well:
> 
> ![grouping c,e | center](https://i.imgur.com/tUa6Ib4.png)
> 
> This aggregation procedure can be represented graphically using a **dendrogram**:
> 
> ![dendrogram | center](https://i.imgur.com/7u44kuE.png)
> 
> The dendrogram is useful because if we need $n$ clusters we just need to "cut it" at the desired dimension.

## Complete-linkage Clustering

Complete-linkage Clustering works in a similar way to single-linkage:

> [!HELP] Example
> 
> Taking the example from above, the first step of the complete-linkage clustering still consists of having to group $b$. However, the difference is in the next step:
> 
> ![complete clustering | center](https://i.imgur.com/rx6jOL7.png)
> 
> Here we operate by taking the smallest distances, and iterating several times we end up with the above sample.
>    
> Then we take not the smallest, but the greatest value of the distances, which is $43$. The difference with single linkage is that we take the highest value for composite clusters: if we have $(a,b)$ then we take the highest, not the lowest value between the two to compute the distance with another class, say $c$. The resulting dendrogram is:
> 
> ![dendrogram | center](https://i.imgur.com/nUCWddc.png)

### Differences

Single and complete/average linkage approach the problem in two different ways, and as a result have two different "emerging" behaviors:

- Single-linkage follows "paths" that connect samples
- Complete/average-linkage tends to form "spherical clusters"

![single vs average | center](https://i.imgur.com/y8sCbig.png)

## $k$-means clustering

The $k$-means clustering algorithm works by defining a "objective" or "**distortion function**":

$$
J = \sum_{n=1}^K \sum_{k=1}^K r_{nk} ||x_n - \mu_k||^2
$$

Where $r_{nk}=1$ if the sample $n$ belongs to cluster $k$, or $0$ otherwise. $\mu_k$, instead, is the centroid of the cluster $k$.

The goal of the algorithm is to **minimize the distortion function**: the variables to be change is the position of the center of the cluster, $\mu_k$. This is done so that all elements that are part of the cluster $k$ ($r_{nk}=1$) are as close as possible to the center of the cluster, $\mu_k$ (since we are minimizing the euclidean distance). This is done through the following steps:

1. **Initialization**: we initialize $k$ cluster centers randomically. In this case, $k=2$:
   
   ![initialization | center](https://i.imgur.com/V0Xesuy.png)

2. **Expectation step (e-step)**: now, we assing all data points to the _closest cluster center_:
   
   ![e-step | center](https://i.imgur.com/6gbDnk5.png)

3. **Maximization step (m-step)**: finally, we change the cluster center as the _average_ of the assigned points.
   
   ![m-step | center](https://i.imgur.com/jICtyZE.png)

4. We repeat until the clusters converge
   
   ![convergence | center](https://i.imgur.com/sYlxBNh.png)

Here is a graphical representation of the k-means clustering algorithm used for compression/quantization: an higher value of $K$ results in more clusters and more vivid images:

![k-means example | center](https://i.imgur.com/jmgJtw2.png)

The $k$-means algorithm is guaranteed to converge in a finite number of steps, and has the property of being very simple and efficient. However, it can be used only if we know the number of clusters $K$ and is very influenced by outlier samples, since all clusters found are spherical:

![outlier | center](https://i.imgur.com/A408aUv.png)

## Gaussiam Mixture Models (GMMs)

We saw that the $k$-means algorithm operates by maximizing the distortion function:

$$
J = \sum_{n=1}^K \sum_{k=1}^K r_{nk} ||x_n - \mu_k||^2
$$

Since $J$ takes into account the term $||x_n - \mu_k||^2$ as the distance function, the clusters that end up being traced have a _spherical form_. Also, $k$-means assumes that all clusters have the same _prior probability_, and that a point is either part of a cluster or not. We could call this a "_geometrical approach_", but these assumptions end up creating strict constraints that could end up in a worse overall classifier. For example:

1. Why do we have to limit ourselves with saying that clusters must be spherical? Some more _elliptical_ shapes could help better classify data sets with many outliers
2. Why do we have to say that all clusters have the same prior probability? Maybe there are some classes with more elements than others a priori
3. Why do we have to have such a marked distinction between one cluster and another? We might also want to say that a sample has a certain _probability_ of being part of a cluster than the absolute certainty

These assumptions are made because the $k$-means algorithm is a specialized version of the more general **Gaussian Mixture Models (GMMs)**. GMMs aim at removing all these constraints in the following ways:

1. Instead of having spherical clusters, we assume that the samples in the training set follow some form of a _normal distribution_: this way, we can optimize all algorithm to find the best values for priors, means and covariances.
2. Instead of having a 0 or 1 probability for a sample to be part of a cluster, we introduce "**fuzzy clustering**": each point belongs to each cluster with a certain probability
3. Instead of having the same a priori probability for all clusters, we assume that the priors are _not known_ and that they must be learned

Combining all these, we get that each sample $x$ has a probability $p(x)$ to be generated that is:

> [!NOTE] GMM probability
>
> $$
> p(x) = \sum_z p(z) p(x\ |\ z) = \sum_{k=1}^K \pi_k N(x\ |\ \mu_k, \Sigma_k)
> $$
> 
> Where:
> 
> - $\pi_k$ is the prior probability of the cluster $k$
> - $N(x\ |\ \mu_k, \Sigma_k)$ is a Gaussian distribution with means $x\ |\ \mu_k$ and covariance $\Sigma_k$

We say "probability of being generated" because the idea is to optimize the parameters of the Gaussian (priors, means and covariance) to try and "guess" the best possible function that generated the samples.

Here, the probability of a sample being part of a cluster is given by:

$$
\gamma(z_k) = p(z_k = 1\ |\ x) = \frac{p(z_k=1)p(x\ |\ z_k=1)}{\sum_{j=1}^Kp(z_j = 1)p(x\ |\ z_j=1)} = \frac{\pi_k N(x\ |\ \mu_k, \Sigma_k)}{\sum_{j=1}^K \pi_j N(x\ |\ \mu_j, \Sigma_j)}
$$

This value can be obtained by applying Bayes' rule to $p(z_k=1\ |\ x)$ and then rewriting the value of the probability function using the Gaussian.

Now, the GMM algorithm works by trying to find the best possible values for the parameters of the Gaussian. This technique is called "**Expectation maximization**", and the aim is to maximize the function of the log likelihood:

$$
\ln p(X\ |\ \mu, \Sigma, \pi)
$$

There are multiple steps to this procedure. 

> [!NOTE] EM for GMM
> 
> First, we initialize $\mu_k, \Sigma_k, \pi_k$, and evaluate an initial $p(x)$. Then, we evaluate the responsibilities using the current parameters:
>
>$$
>\gamma(z_{nk}) = \frac{\pi_k N(x_n\ |\ \mu_k, \Sigma_k)}{\sum_{j=1}^K \pi_j N(x_n\ |\ \mu_j, \Sigma_j)}
>$$
>
>We then do the _maximization step_ (M step) by re-estimating the parameters with the responsibilities:
>
>- The mean, $\mu_k$, is calculated as the weighted average of all data points by the responsibility:
>
>	$$
>	\mu_k^{\text{new}} = \frac{1}{N_k} \sum_{n=1}^N \gamma(z_{nk}) x_n
>	$$
> 
> - The covariance, $\Sigma_k$, is the weighted average of the variance of single points by the responsibility:
>
>	$$
>	\Sigma_k^{\text{new}} = \frac{1}{N_k} \sum_{n=1}^N \gamma(z_{nk})(x_n-\mu_k^{\text{new}})(x_n-\mu_k^{\text{new}})^T
>	$$
>
> - The prior, $\pi_k$, is the mean of the responsibility of the cluster itself
>
>	$$
> 	\pi_k^{\text{new}} = \frac{N_k}{N}
>	$$
>
>	where
>
>	$$
>	N_k = \sum_{n=1}^N \gamma(z_{nk})
>	$$
>	
> Finally, we evaluate the log likelihood to see if either the parameters or the log itself converged to a stop criterion:
> 
> $$
> \ln p(X\ |\ \mu, \Sigma, \pi) = \sum_{n=1}^N \ln\{\sum_{k=1}^N \pi_k N(x_n\ |\ \mu_k, \Sigma_k)\}
> $$

Visually, we can see that clusters are no longer spherical:

![gmm clustering | center](https://i.imgur.com/RgabIqU.png)

## Cluster Validation Function

In the previous methods we discussed some limitations of clustering:

- How many clusters do we search for?
- How can we measure the validity of a cluster?
- How can we define a good similarity measure?

To address the problem of _cluster validation_, we can introduce two notion. First is that of a sampling error relative to a cluster's centroid:

$$
m_i = \frac{1}{n_i} \sum_{x \in D_i} x
$$

Where $i$ is the total number of clusters: we just calculate the centroid $m_i$ of a cluster $D_i$ as the average of coordinates of the points in the cluster. To then calculate the average error for a cluster $i$, we sum the squared distance of all points from the centroid:

$$
J_i = \sum_{x \in D_i} ||x-m_i||^2
$$

Then, the overall error $J_e$ can be measured by summing the errors of all clusters:

$$
J_e = \sum_{i=1}^c J_i = \sum_{i=1}^c \sum_{x \in D_i} ||x-m_i||^2
$$
Clusters that minimize the value of $J_e$ are called "**minimum-variance clusters**". This is, however, not always the best measure to calculate validity, as it works only if clusters are compact, well separated from each other and roughly of the same size, otherwise we can have some misleading results like these, where the cluster with the higher $J_e$ is actually better:

![j_e error | center](https://i.imgur.com/sCjGTis.png)

Other functions tend to generally promote _compact_ and _well-separated clusters_, like those that use the "**within-cluster scatter matrix, $S_w$**" and the "**between-cluster scatter matrix, $S_B$**":

$$
S_w = \sum_{i=1}^c S_i,\ \ \ \ S_i = \sum_{x \in D_i} (x-m_i)(x-m_i)^T
$$

$$
S_B = \sum_{i=1}^c n_i(m_i-m)(m_i-m)^T
$$

For $S_w$, lower values indicate better results, while for $S_B$ it is the opposite: the higher the better.

# Transformers

The transformer technology was introduced by the paper "Attention is All you Need".

Transformers are the foundational technology of **Large Language Models (LLM)**. Transformers allow LLMs to have a longer "attention span", so that they are able to understand longer and more complex sentences ("long-range" structures). Through this ability, they manage to perform complex tasks, like language translation, text generation and summarization, code generation, etc.

## Attention Mechanisms

Transformers introduced the concept of "**attention mechanisms**". This is a core difference to other classifiers: for example, linear ones have a set weight vectors which are always the same multiplied for all features:

$$
f(x) = w^Tx + b 
$$

Instead, transformers modify weights **depending on the value of $x$**:

$$
f(x) = w(x)^Tx + b
$$

This is named "attention", since LLMs can selectively "focus" on some features more than others, depending on their value.

## Training

Transformers have a pre-training phase where they are fed huge datasets of text: since the transformer architecture is parallelizable, it can scale to very big training dataset. The training is then **self-supervised**: LLMs are typically fed text with some "missing words" and are asked to complete the text (this is called "**Token prediction**"). There is then **fine-tuning**, a supervised learning with human feedback.

### Scaling Laws

LLMs scale on the number of parameters provided: performance of these models can be predicted given and the computing budget, to find the best possible amount of number of parameters:

$$
L(N, D) = E + \frac{A}{N^\alpha}+\frac{B}{D^\alpha}
$$

Where N and D are constants that depend on $C$, the budget cost measured on FLOps.

### Emergent Abilities

As LLMs scale with the given number of parameters, they are also able to learn some abilities which were not accounted for. I.E., a model learns to exploit vulnerabilities while learning how to code

## Workings

The first step of transformers is to transform text into _numerical vectors_, a process called "**Tokenization**", which could be done in many different ways:

1. _Word-level_: one token per word. This way the vocabulary becomes very large, and unseen words cannot be treated.
2. _Character-level_: one token per character. The opposite problem then word-level, tokens have very little meaning.

The best way is to use sub-word tokenization.