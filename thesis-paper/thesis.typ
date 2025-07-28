#import "typyst-template/template.typ": project
#import "@preview/dashy-todo:0.0.2": todo

#show: project.with(
  title: "Analyzing MARL algorithms in 
  dynamic environments: 
  Evaluating performance with an 
  additional unknown element",
  authors: (
    (
      name: "Yannick MOLINGHEN",
      status: "Promoter",
    ),
    (
      name: "Kevin VANDERVAEREN",
      status: "Author",
    ),
    (
      name: "Prof. Tom LENAERTS",
      status: "Supervisor",
    )
  ),
logo: "ulb_logo.jpg",
abstract: "#todo{Abstract}",
)

= Introduction

== Background and Objectives
A Multi-Agent Reinforcement Learning (MARL) is a subfield of the Reinforcement Learning domain which focuses on the interaction between multiple agents in a shared environment. Through the recent years, an increasly amount of research has been conducted in this field to resolve issue that has arisen in the reel world. However, most of the research are done through simulations on environments which does not involve unknown elements in existing envirement. This thesis aims to evaluate the learning performance of MARL algorithms from a know environment with with proven working result, to an slightly modified modified envirement by adding an unknown elements. Under the suppervision of Prof. Tom Lenaerts, and advisor Yannick Molinghen, from the Machine Learning Group (MLG) of the Université Libre de Bruxelles (ULB).

Currently, the research is focused on the the environment of #link("https://github.com/yamoling/lle")[LLE] (Laser Learning Reinforcement) which is a environment created by Yannick Molinghen based on the original game. The environment is a 2D world also known as grid world where a single or multiple agents will be interacting in a Cooperative manner. The goal of each individual agent is to reach an exit point while aquiring rewards (under the form of Gems) and avoiding obstacles.

The objective of the Master thesis is to develop a new feature in the LLE environment that was also includes in the original game of Oxen. Morever this feature has also a other objective which is to add a new element in the environment which are not included in the agents learning process and thus reevaluate the performance of a already fine tuned algorithms that is trained on the original environment and observe of any possible bottleneck that may arise from the addition of additional elements.


== Notations and Definitions
// #show table.cell.where(y: 0): strong
// #set table(
//   stroke: (x, y) => if y == 0 {
//     (bottom: 0.7pt + black)
//   },
//   align: (x, y) => (
//     if x > 0 { center }
//     else { left }
//   )

// )
#table(
  columns: 2,
  table.header(
    [Notations],
    [Description],
  ),

  [S], [the state space of the environment],
  [s], [a state in the state space given that $s in S$],
  [$s_t$], [the state at time $t$],
  [A], [the action space of the environment],
  [a],[an action in the action space given that $a in A$],
  [T], [the transition function],
)

(temporary place) temporary place for some definition
- State Space $S$
- Agent i action space $A_i$
- joint Action Space *$A$* = $A_1 times A_2 times ... times A_n$ where $n$ is the number of agents
- specific action in the joint action space denoted *$a$* st. *$a$*$in$*$A$*  
- transition function $T$ 
- reward function $R$
the notation will be using the notation of ref to book #link("https://spinningup.openai.com/_/downloads/en/latest/pdf/")[here]

(end temporary place)
= State of the Art
== Distributed artificial intelligence
// all the following section are from the article "Cooperative Multi-Agent Learning The State of the Art" by [ref to article]
!!(this section has content form the article "Cooperative Multi-Agent Learning The State of the Art" by [ref to article])!!

Distributed artificial intelligence (DAI) is the a field of study which is rising in the last two decades. which is mainly focused on the domain of distributed systems. A distributed system by the definition of [ref to book] is a 
(quote)"where a number of entities work together to cooperatively solve problems"(endquote). this kind of study is not new, it has been studied for a long time. But what is new is the rise of the internet and the multiple electronic devices that we have today. Which bring the need of a new field of study which is the DAI  that simply is the study of the interaction between multiple artificial intelligence (AI) or agents in a distributed system.
=== Multi-Agent Systems vs. Distributed problems Solving
In the field of DAI, we can find two main subfields a more traditional one which is the Distributed Problem Solving (DPS) which us the paradigm of a divide and conquer. The DPS is a field which is focused on distributing the problem to independent slaves which are solving the problem independently. On the other hand, the Multi-Agent Systems (MAS) emphasizes on the interaction between the agents. 

=== Multi-Agent Systems
In MAS there are few constraints that are imposed on the agents. such as even though the agents are working together to solve a problem in a same environment they are not able to share their knowledge of the envirement with each other they may only acces to the information that they have, in RL we often refer this as a local obsevation. This is a important point because if they were able to share their knowledge this would be able to simply syncronize their knowledge and solve this problem as a DPS problem if the problem need no interaction between the agents (#todo may be more ). 
== Multi-Agent Learning
The Multi-Agent Learning (MAL) 

// use article that explain different MAS article to explain what is MARL
// new why MARL is intresting
// get the mollinghen article to explain the LLE environment
// explain why adding a new element in the environment is intresting
// explain LLE agent standard
== Machine Learning
//? is this section needed for explaining base of ML and split between SL unsupervised and RL

== Single Agent Reinforcement Learning
=== Markov Decision Process
The Markov Decision Process (MDP) is a model that is used to
often represented as a 5-tuple $angle.l S, A, T, R, rho_0 angle.r$ where the elements are:
- $S$ is the state space
- $A$ is the action space 
- $T$ is the transition function 
- $R$ is the reward function
- $rho_0$ is the initial state distribution
The MDP is a mathematical framework that is based on the principle of the Markov property, which states that the future state of a system only depends on the current state and not on the previous states. In mathematical term this is often represented as:
$ Pr(s_(t+1) | s_t, a_t) = Pr(s_(t+1) | s_t, a_(t-1), ..., s_0, a_0) $
this framework is often used to abstract the pr
the MDP is has been formalized in the ... by ... , which 
==== State
A ways to represent the environment is to use a state. A state is an abstract ways to decribe the joint information of all elements in the environment. we can use as exemple the game of tick-tac-toe where the representation of the board at a given time such as this image @state is a state. But a state is not only the representation of the board but also the information of the player turn. So a state is a representation of the environment at a given time. In the mathematical notation we usually use the notation $s$ to represent a state, and $S$ to represent the state space. The state space is the set of all possible states imagineable for a given environment. 
- $S$ is the state space of the environment
- $s$ is a state in the state space given that $s in S$ ($s'$ may be used for a new state)
- $s_t$ is the state at time $t$

#figure(image("images/state.png", width: 45%),
        caption: "A state in the game of tick-tac-toe")<state>
=== Action 
A action reffers to the possible movement doable by the agent in the environment. In the case of the game of tick-tac-toe, the possible actions is to put a mark in one of the available cell out the 9 cells, for exemple in the previous example @state the "O" player has the following possible action to choose from [top left, top center, middle right, bottom left, bottom center, bottom right]. In the mathematical notation we usually use the notation $a$ to represent an action (e.g. 'top left'), and $A$ to represent the action space (e.g list of all actions listed above). 
- $A$ is the action space of the environment
- $a$ is an action in the action space given that $a in A$
// maybe ? - $a_t$ is the action at time $t$
=== Transition
The transition is the function that is used to represent the change of a given state, given a action. The transition is a probability function that is used to represent the stochasticity of a given environment. A more real life example, for those who have done sport, you may have experience the case where you where about to do a certain action like a squat or a sprint but you got a cramp or a mucle tear which put you in a state where you were not expecting to be. This is a good example of the stochasticity of a given environment. If we use that example we can put it this way:
- $s$ or $s'$ is the state of my body which is "healthy"
- $c$ is the state of my body which is "cramped" or "unhealthy"
- $a$ is the action that I am about to do
and then the transition function $T$ is the function that is used to represent the change of state of my body given a action. and in this case we can simply use this notation:
- $T(s, a, s')$ is the probability of having nothing happen to my body given a action $a$.
- $T(s, a, c)$ is the probability of having a cramp or a muscle tear given a action $a$.
they also posses certain properties such as:
- the function $T$ : $S times A times S -> [0,1]$
- $sum_(s' in S) T(s,a, s') = 1$
note that mathematically the transition function is a re-writing of the conditional probability function often represented as
$$Pr(s'|s, a)$$ 
=== Reward
Like the transition function, the reward is a function that is used between two states given a action. Instead of representing the change of a state, the reward function is to give a purpose or goal to the agent. Going back to the example of the sport, the reward can be the distance that i have lessend over the finish line.  
== Multi-Agent Reinforcement Learning
=== Stationary vs. Non-stationary
The MARL can be naively seen as adding more than 