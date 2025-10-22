---
title: 01 - Machine Learning Introduction
tags: []
draft: false
date: 2025-10-07
header-includes: \usepackage[most]{tcolorbox}
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
