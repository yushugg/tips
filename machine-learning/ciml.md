## Decision Tree

### Learning problems

1. Regression: predict a real value.
2. Binary Classification: predict a simple yes/no.
3. Multiclass Classification: put an example into one of a number of classes.
4. Ranking: put a set of objects in order of relevance.

### Decision Tree key problems

1. What questions to ask
2. What order to ask
3. What answer to predict once you have asked enough questions

### Loss functions

1. Regression: squared loss (y - y')^2 or absolute loss |y - y'|
2. Binary Classification: zero/one loss - 0, if y = y', 1 otherwise
3. Multiclass Classification: also zero/one loss

### Learning problem is defined by two quantities

1. The loss function l, which captures our notion of what is important to learn
2. The data generating distribution D, which defines what sort of data we expect to see

Given (i) a loss function l and (ii) a sample D from some **unknown** distribution D, you must compute a function f that has low expected error ε over D with respect to l.

### Shallow decision tree

We will not allow the trees to grow beyond some pre-defined maximum depth, d. That is, once we have queried on d-many fea- tures, we cannot query on any more and must just make the best guess we can at that point. This variant is called a **shallow decision tree**.