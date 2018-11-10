## Introduction

### 强化学习与监督学习的区别

1. 不是label而是reward，reward可能是有延迟的；
2. 强化学习的输入总是在变化的，一个action影响下一次的输入，而监督学习是独立同分布的；
3. exploration会尝试很多新事情，看是否比以前好，exploitation会尝试过去经验中最有效的行为，而监督学习没有这两种平衡，只是exploitative；

### 强化学习与非监督学习区别

1. 非监督学习是学习数据中的pattern，不接受反馈

### 强化学习特点

1. 强化学习是完整流程的、交互式的、目标导向的学习

### 强化学习组成

1. agent、environment、state、action、reward

### 强化学习四要素

1. policy: agent的行为, states -> actions
2. reward signal: immediate sense, agent的唯一目标是在长远上最大化total reward
3. value function: agent期望累积的total reward, 包含以后可能, 侧重在预测的未来, 用于action的选择(而不是reward)
4. model of environment: 预测环境的行为, 有助于planning, state+action -> next state+next reward，有model-based方法和model-free方法之分

### Limitations and Scope

1. state很重要，这里只侧重讲decision-making
2. 大部分强化学习方法是围绕value functions，但evolutionary methods不是，evolutionary methods更像是适应环境，不去与环境交互，**多次尝试**后得到每种policy的获胜概率，适合policy空间小、policy易于探索、探索时间允许足够或agent无法完全感知环境的state
3. 有些类似evolutionary methods的方法，定义一些参数，以提高policy的perf来调参，它是和环境有交互的
