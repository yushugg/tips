## Query Expansion

1. Wikipedia redirect links
2. Wikipedia anchor text: anchor text captures a wide range of variations, as they occur in actual sentences
3. Expand names: Acronym to full names, first name to full name, add common suffixes(e.g. Ltd, Corp)
4. Reduce names: Opposite to expanding names, find possible abbreviations
5. Do 3 and 4, then use result to do in 1 and 2
6. Some entity linking and disambiguation strategies

## Slot NER

1. Stanford CoreNLP
2. State-of-the sequence perceptron named-entity tagger
3. Some other Freebase types
4. Manual slot types

## Distant Supervision

1. Use co-occurring to divide candidates
2. Active learning to reduce noise
3. Use patterns to choose positive candidates

## Feature extraction

1. Normal features
2. n-gram
3. RNN

## Classification

1. Binary Classification
2. Multiclass Classification
3. Neural Network