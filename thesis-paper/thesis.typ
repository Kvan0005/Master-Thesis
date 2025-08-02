#import "typyst-template/template.typ": project
#import "@preview/dashy-todo:0.0.2": todo

#set footnote(numbering: "*")
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
A Multi-Agent Reinforcement Learning (MARL) is a subfield of the Reinforcement Learning domain which focuses on the interaction between multiple agents in a shared environment. Through the recent years, an increasly amount of research has been conducted in this field to resolve issue that has arisen in the reel world @weiss_multiagent_2001 @stone_multiagent_1997. However, most of the research are done through simulations on environments which does not involve unknown elements in existing environment. This thesis aims to evaluate the learning performance of MARL algorithms from a know environment with with proven working result, to an slightly modified modified environment by adding an unknown elements. Under the suppervision of Prof. Tom Lenaerts, and advisor Yannick Molinghen, from the Machine Learning Group (MLG) of the Université Libre de Bruxelles (ULB).

Currently, the research is focused on the the environment of #link("https://github.com/yamoling/lle")[LLE] (Laser Learning Reinforcement) which is a environment created by Yannick Molinghen based on the original game. The environment is a 2D world also known as grid world where a single or multiple agents will be interacting in a Cooperative manner. The goal of each individual agent is to reach an exit point while aquiring rewards (under the form of Gems) and avoiding obstacles.

The objective of the Master thesis is to develop a new feature in the LLE environment that was also includes in the original game of Oxen. Morever this feature has also a other objective which is to add a new element in the environment which are not included in the agents learning process and thus reevaluate the performance of a already fine tuned algorithms that is trained on the original environment and observe of any possible bottleneck that may arise from the addition of additional elements.


== Notations and Definitions
=== Notations
#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom:black)
  },
)
#table(
  columns: 2,
  table.header(
    [Notations],
    [Description],
  ),
  // [mathematical base notation:],[],
  [$approx$], [approximately equal],
  [$in$], [is an element of e.g. 3.2 in bb(R)],  
  [$[a,b)$], [is the interval from $a$ to $b$ where $a$ is included and $b$ is excluded],
  [$sum_(a in A) a$], [the sum of all elements $a$ in the set $A$],
  [$f:X times Y arrow Z$],[a function $f$ that has a domain from the set $X times Y$ and image of the set $Z$],
  [$Pr(x|y,z)$], [the probability of $x$ given $y$ and $z$],
  [$x tilde X$], [a random variable $x$ that follows the distribution $X$],
  [$bb(N)$], [the set of natural numbers],
  [$bb(R)$], [the set of real numbers],
  [$Delta_X$], [the set of probability distributions over the set $X$],
  [$t$], [a time step which belong to the set of natural numbers $t in bb(N)$],
  [$EE$], [the expected value],
  [$gamma$], [the discount factor which is a real number in the interval $[0,1]$],
  
  

  // [Markov Decision Process:],[],
  // [$s$,$s'$], [state],
  // [$a$],[an action],
  // [$r$],[a reward],
  // [$S$], [the state space],
  // [$A$], [the action space],
  // [$A(s)$], [the action space available in state $s$],
  // [$t$], [discrete time step],
  // [$s_t$], [the state at time $t$],
  // [$a_t$], [the action at time $t$],
  // [$r_t$], [the reward at time $t$],
  // [$A(s)$], [the action space available in state $s$],
  //! [$T(s,a,s')$], [the transition function from state $s$ to state $s'$ given action $a$],
  // [$T(s,a)$], [the transition function from state $s$ given action $a$],
  // [$R(s,a,s')$], [the reward function from state $s$ to state $s'$ given action $a$],
  //! [$R(s,a)$], [the reward function from state $s$ given action $a$],
  // [$rho_0$], [the initial state distribution],
  //? [$pi$], [policy (decision-making rule)],
  //? [$pi(s)$], [action choose by the policy $pi$ in state $s$],
  
  //? [$Q(s,a)$], [the action-value function of state $s$ and action $a$],
  //? [$V(s)$], [the value function of state $s$],
  //? [$V^*(s)$], [the optimal value function of state $s$],
  //? [$Q^*(s,a)$], [the optimal action-value function of state $s$ and action $a$],
  //? [$gamma$], [the discount factor],
  //? [$alpha$], [the learning rate],

  // [Multi-Agent Markov Decision Process:], [],
  // [$cal(A)$], [the joint action space],
  // [$cal(a)$], [the joint action],
  // [$cal(T)(s,cal(a),s')$], [the transition function from state $s$ to state $s'$ given joint action $cal(a)$],
  // [$cal(T)(s,cal(a))$], [the transition function from state $s$ given joint action $cal(a)$],
  // [$cal(R)(s,cal(a),s')$], [the reward function from state $s$ to state $s'$ given joint action $cal(a)$],
  // [$cal(R)(s,cal(a))$], [the reward function from state $s$ given joint action $cal(a)$],
  // [$A^i$], [the action space of agent $i$],
  // [$a^i$], [the action of agent $i$],
  // [$tau$], [a transition defined as $tau = angle.l s, cal(a), r, s' angle.r$],
)
// (temporary place) temporary place for some definition
// - State Space $S$
// - Agent i action space $A_i$
// - joint Action Space *$A$* = $A_1 times A_2 times ... times A_n$ where $n$ is the number of agents
// - specific action in the joint action space denoted *$a$* st. *$a$*$in$*$A$*  
// - transition function $T$ 
// - reward function $R$
// the notation will be using the notation of ref to book #link("https://spinningup.openai.com/_/downloads/en/latest/pdf/")[here]
= State of the Art
== Introduction
// all the following section are from the article "Cooperative Multi-Agent Learning The State of the Art" by [ref to article]
!!(this section has content form the article "Cooperative Multi-Agent Learning The State of the Art" by [ref to article])!!

Distributed artificial intelligence (DAI) is the a field of study which is rising in the last two decades. which is mainly focused on the domain of distributed systems. A distributed system by the definition of @panait_cooperative_2005 is #quote("where a number of entities work together to cooperatively solve problems") . this kind of study is not new, it has been studied for a long time. But what is new is the rise of the internet and the multiple electronic devices that we have today. Which bring the need of a new field of study which is the DAI  that simply is the study of the interaction between multiple artificial intelligence (AI) or agents in a distributed system.
=== Multi-Agent Systems vs. Distributed problems Solving
In the field of DAI, we can find two main subfields a more traditional one which is the Distributed Problem Solving (DPS) which us the paradigm of a divide and conquer. The DPS is a field which is focused on distributing the problem to independent slaves which are solving the problem independently. On the other hand, the Multi-Agent Systems (MAS) emphasizes on the interaction between the agents.
=== Multi-Agent Systems
In MAS there are few constraints that are imposed on the agents. such as even though the agents are working together to solve a problem in a same environment they are not able to share their knowledge of the environment with each other they may only acces to the information that they have, in RL we often refer this as a local obsevation. This is a important point because if they were able to share their knowledge this would be able to simply syncronize their knowledge and solve this problem as a DPS problem if the problem need no interaction between the agents #todo("may be more write"). 
== Multi-Agent Learning
The Multi-Agent Learning (MAL) 
(todo):
- use article that explain different MAS article to explain what is MARL
- new why MARL is intresting
- get the mollinghen article to explain the LLE environment
- explain why adding a new element in the environment is intresting
- explain LLE agent standard
== Machine Learning
(todo)
- is this section needed for explaining base of ML and split between SL unsupervised and RL
=== Supervised Learning
Supervised Learning (SL) is a subfield of Machine Learning (ML) which focuses on the learning of a model from a set of labeled data. The goal of SL is to learn a function that maps as much as possible the entry data (something e.g image) to a outgoing data (or label e.g. a class of the image). The SL is often used in the field of computer vision or natural language processing (e.g @kamath_deep_2019). Where the goal is to get a model that is able to classify the data into a certain class based on the data that it has initially learned from training. 
=== Reinforcement Learning

The domain of Reinforcement Learning (RL) is a subfield of Machine Learning (ML) which focuses on learning from the interaction between an agent and its environment. Compared to supervised learning, Learner (learning agent) is not provided with explicit information about the environment neither which action to perform. It mainly focuses on the idea of trial and error, by interacting with its environment the learner will be acquiring or losing points and will be his only source of feedback. Thus the agents will be trying to maximize the number of points given. @sutton_reinforcement_2014
==== Agent 
An agent in RL can be seen as a learner or decision maker that is equipped with a set of tool to observe and interact with its environment. the set of tools is can be split into two components:
- the sensor used to percept the environment and gather information (e.g 5 sens of humain).
- the actuator which is used to interact with the environment and perform action. (e.g. the hand or leg of humain).

== Single Agent Reinforcement Learning
=== Markov Decision Process
In a Single agent Reinforcement Learning (RL) the methodology used to model the environment is the Markov Decision Process (MDP)@puterman_markov_2009. The MDP is a mathematical framework that is used to model the interaction between an agent and its environment(#todo find the lost ref). It is often used to represent the decision-making process of an agent in a stochastic environment. The MDP is a powerful tool that allows us to model the environment in a way that is easy to understand and analyze.

The Markov Decision Process (MDP) @SpinningUp2018 is often represented as a 5-tuple $angle.l S, A, T, R, rho_0 angle.r$ where the elements are:
- $S$ is the state space
- $A$ is the action space 
- $T$ is the transition function 
- $R$ is the reward function
- $rho_0$ is the initial state distribution

One of the key properties of the MDP is that it based on the Markov property, which states that the future state of a system only depends on the current state and not on the previous states. In mathematical term this is often represented as:
$ Pr(s_(t+1) | s_t, a_t) = Pr(s_(t+1) | s_t, a_(t-1), ..., s_0, a_0) $

A another strenght is that by doing the reduction to a MDP we can abstract all sensory, memory and control aspects(ref rl: an introduction sutton and barto) to a simply 3 signal between the agent and the environment:
- the state $s$
- the action $a$
- the reward $r$
but also introduce key functions such as the Bellman equation which is used the markov properties to represent the relationship between the value of a state and the value of its successor states. 
==== State
A ways to represent the environment is to use a state. A state is an abstract ways to decribe the joint information of all elements in the environment. we can use as exemple the game of tick-tac-toe where the representation of the board at a given time such as this image @state is a state. But a state is not only the representation of the board but also the information of the player turn. So a state is a representation of the environment at a given time. In the mathematical notation we usually use the notation $s$ to represent a state, and $S$ to represent the state space. The state space is the set of all possible states imagineable for a given environment. 
- $S$ is the state space of the environment
- $s$ is a state in the state space given that $s in S$ ($s'$ may be used for a new state)
- $s_t$ is the state at time $t$

#figure(image("images/state.png", width: 45%),
        caption: "A state in the game of tick-tac-toe")<state>

=== Observation
An observation is a partial description of a state. but instead of providing complete information of the environment, the observation provide only the information aquired by the agent. An observation is often used in the case where the agent does not have access to the complete information of the environment, such as in a partially observable environment POMDP(#todo("getref")). The observation is denoted as:
- $O$ is the observation space
- $o_t$ is the observation at a time $t$ in the observation space given that $o_t in O$
A analogy to the observation is the case where you are in a room and you can only see what is in front of you, but you cannot see what is behind you. In this case, your observation is only the information that you can see in front of you, but not the complete information of the room.
=== Action 
A action reffers to the possible movement doable by the agent in the environment. In the case of the game of tick-tac-toe, the possible actions is to put a mark in one of the available cell out the 9 cells, for exemple in the previous example @state the "O" player has the following possible action to choose from [top left, top center, middle right, bottom left, bottom center, bottom right]. In the mathematical notation we usually use the notation $a$ to represent an action (e.g. 'top left'), and $A$ to represent the action space (e.g list of all actions listed above). 
- $A$ is the action space of the environment
- $A(s)$ is the action space available in state $s$ (e.g. the list of all actions available in the state $s$)
- $a$ is an action in the action space given that $a in A$
- $a_t$ is the action at time $t$ in the action space.

=== Transition
The transition is the function that is used to represent the change of a given state, given a action. The transition is a probability function that is used to represent the stochasticity of a given environment. A more real life example, for those who have done sport, you may have experience the case where you where about to do a certain action like a squat or a sprint but you got a cramp or a mucle tear which put you in a state where you were not expecting to be. This is a good example of the stochasticity of a given environment. If we use that example we can put it this way:
- $s$ or $s'$ is the state of my body which is "healthy"
- $c$ is the state of my body which is "cramped" or "unhealthy"
- $a$ is the action that I am about to do
and then the transition function $T$ is the function that is used to represent the change of state of my body given a action. and in this case we can simply use this notation:
- $T(s' | a, s)$ is the probability of having nothing happen to my body given a action $a$.
- $T(c | a, s)$ is the probability of having a cramp or a muscle tear given a action $a$.
they also posses certain properties such as:
- the function $T$ : $S times A times S -> [0,1]$
- $sum_(s' in S) T(s' | a, s) = 1$
alternatively we can also represent the transition function as a conditional probability function which is often used in the literature. In this case we can use the notation:
- $T(dot| s, a)$ which $ T : S times A -> Delta_S$ and $Delta_S$ is the set of probability distributions over the state space $S$.
note that mathematically the transition function is a re-writing of the conditional probability function often represented as
$$Pr(s'|s, a)$$ 
=== Reward
The reward function, which takes a initial state, an action and a final state. Unlike the transition is a function which return a probability the reward function return a scalar which can be interpreted as a score. Instead of representing the change of a state, the reward function is to give a purpose or goal to the agent. Going back to the example of the sport, the score can be seen as the motivation to perform the action based on a certain goal, such as on the treadmill when you are aiming to lose certain amount of calories, the reward function is the calories burned. While running faster put you in a state where you are burning more calories but also put your body in a state that is more likely to have a cramp. The reward function is often represented as:
$ R(s' | a, s) $
where $s$ is the initial state, $a$ is the action and $s'$ is the final state. 
And mathematically the reward function is:
$ R : S times A times S -> bb(R) $
the reward that result from the reward function is often assigned to the variable $r$ and the reward at time $t$ is often represented as:
$ r_t = R(s_(t+1) | a_t, s_(t)) $
=== Return
Opposed to the reward which is a scalar value that is given at a given time, the return is the observation of the cumulative reward over a period of time. it can be eiter finite or infinite. In the finite case the return also called #strong("finite-horizon undiscounted return") which is often represented as:
$ R("trajectory placeholder") = sum_(t=0)^(T-1) r_t $#todo("need to have beter notation due to conflict with the reward and multi-agent notation")
where $T$ is the time horizon and $tau$ is the trajectory of the agent. In the infinite case we need to take into account the discount factor $gamma$ for not having a not fixed return. (#todo("do infinite case")) 



=== Trajectory
A Trajectory is a sequence of states, actions and rewards that the agent has taken in the environment. The Trajectory writen as $ "trajectory placeholder "=(S_1, A_1, R_1, S_2, A_2, R_2, ...) $ where the initial state of the environment $S_1$ is randomly sampled from the start state distribution $rho_0$:
$ S_1 tilde rho_0 $
the state transition must follow the transition function $T$ and the action must be sampled from the action space $A$ at a given time $t$:
$ S_(t+1) tilde T(dot | S_(t), A_(t)) $

=== History
A history is a sequence of actions, observations and rewards that the agent has taken in the environment. The history is often used to represent the past actions and observations of the agent. The history is often represented as:
$ h_t = (o_1, a_1, r_1, o_2, a_2, r_2, ..., o_(t-1), a_(t-1), r_(t-1)) $
where $o_t$ is the observation, $a_t$ is the action and $r_t$ is the reward at time $t$. The main difference between a trajectory and a history is one is all information about the environment while the other is only the information gathered by a specific agent. An analogy to this is the escape room where the history is what the player has recalled from the past actions and observations, while the trajectory what the game master (who know all secrets information that the player dont know) has seen from the player actions in the escape room.

=== Policy
A policy can be seen as the decision-making rule of the agent that whatever state you are in, it will recommend the actions. The policy is often represented as:
$ pi : S -> Delta_A $
where $pi$ is the policy, $S$ is the state space and $Delta_A$ is the set of probability distributions over the action space $A$.
==== Optimal Policy 
#todo("add finish the optimal policy definition")
The optimal policy is the policy that maximizes the expected return of the agent. The optimal policy is often represented as:


=== Action-Utility Function
#todo("double check the action-utility function definition")
The action-utility function is a function that is used to represent the expected return of a given state and an action. The action-utility function is often represented as:
$ Q(s, a) = EE[ sum_(t=0)^(infinity) gamma^t r_t | s_0 = s, a_0 = a, pi ] $
where $Q(s, a)$ is the action-utility function, $EE$ is the expected value, $gamma$ is the discount factor and $r_t$ is the reward at time $t$. The action-utility function is often used to represent the expected return of a given state and an action. The action-utility function can be used to find the optimal policy by maximizing the expected return.

=== Value Function
#todo(("same as action-utility function"))
The value function is a function that is used to represent the expected return of a given state and a policy. The value function is often represented as:
$ V(s) = E[ sum_(t=0)^(infinity) gamma^
t r_t | s_0 = s, pi ] $
where $V(s)$ is the value function, $E$ is the expected value, $gamma$ is the discount factor and $r_t$ is the reward at time $t$. The value function is often used to represent the expected return of a given state and a policy. The value function can be used to find the optimal policy by maximizing the expected return.



== Multi-Agent Reinforcement Learning
=== Stationary vs. Non-stationary
Originaly we can say that multiple independent agents may not increase dramaticaly in complexity from the RL with single agant but proven
The MARL can be naively seen as adding more than one agent to the RL environment. This leads to new challenges such as non-stationarity, as the presence of multiple agents can change the dynamics of the environment @bowling_analysis_nodate and @panait_cooperative_2005.

The non-stationarity is one of the main challenges in MARL, as the presence of multiple agents which see each others as environment that is "undeterministic" due to their own learning process and by the definition violate the Markov property.

Based on this 2 main trend of research have emerged in the MARL field
- the first one also known as concurrent learning is the one where the agents are learning independently from each other, this does not solve the non-stationarity problem 
=== Search space
As the number of agents increases, the number of possible joint actions increases exponentially. This leads to a combinatorial explosion in the search space, making computationally impossible to find the optimal joint action in a reasonable time. 

=== Current approaches
The current approaches to solve 
 
= LLE Environment
== Overview
The Laser Learning Environment (LLE) is a 2D grid world with discrete times and multiple cooperative agents. The game is based on the original game of Oxen, where the goal of each agent is to reach an exit point while acquiring gems (bonus points). All agents are cooperating to reach they respective exit point while avoiding obstacles. The environment is designed to be simple and esay to understand, while still being challenging enough to test the performance of MARL algorithms.

== Enviroment challenges
The environment is aimed at testing the performance of MARL algorithms tailored for decentralized cooperative scenarios and possess some challenges that are not pressent in other environment such as StarCraft Multi-Agent Challenge or SMAC @samvelyan_starcraft_2019 or the Hanabi environment @bard_hanabi_2020. Instead this environment is designed to take into account other cooperating factors such as the perfect coordination, interdependence and the zero incentive dynamics@molinghen_laser_2024.

== multiagent Markov Decision Process
The model of the environment is based on the multiagent Markov decision process (MMDPs)@boutilier_planning_nodate is a generalization of the Markov decision process (MDP) to multiple agents. The MMDP is a tuple $angle.l n, S, cal(A), cal(T), cal(R), s_0, s_f angle.r$ 
where:
- $n$ is the number of agents
- $S$ is the set of states
- $cal(A) equiv A^1 times A^2 times ... times A^n$ is the joint action space and $A^i$ is the set of actions available to agent $i$ #footnote[$A^i$ has be modified from the original notation $A_i$ to avoid confusion with the action space at a given time $t$])
- $cal(a) equiv (a^1, a^2, ..., a^n) in cal(A)$ is the joint action of all agents $a^i$ is an action of agent $i$  
- $cal(T) : S times cal(A) arrow Delta_S$ is a function that gives the probability of transitionning from state $s$ to state $s'$ given a joint action $cal(a)$
- $cal(R): S times cal(A) times S arrow bb(R)$ is the function return the reward obtained by the transitioning from state $s$ to state $s'$ given a joint action $cal(a)$
- $s_0 in S$ is the initial state
- $s_f in S$ is the final state
A transition is defined as $tau = angle.l s, cal(a), r, s' angle.r$ with $r in bb(R)$

== Algorithm 
the algorithm used in the LLE environment is based the CTDE approach, which mentionned previously.  
Bases on the current state of the LLE environment, only a few algorithms where tested on the environment @molinghen_laser_2024.
=== Value Decomposition Networks
The Value Decomposition Networks (VDN) @sunehag_value-decomposition_2017 is a MARL algorithm that is leveraging the hypothesis of decomposing the joint action-value function into individual value functions for each agent, $ Q((h^1, h^2, ..., h^n), (a^1, a^2, ..., a^n)) approx sum_(i=1)^n tilde(Q)_i (h^i, a^i) $where $tilde(Q)_i$ is the value function of agent $i$ and $h^i$ is the history of agent $i$. This methodology allows the agents to learn independently with the help of $tilde(Q)$ while still being able to have a global result for the group $Q$.

=== independent Q-learning


= Objectives
The objective of this thesis is to develop a new feature in the LLE environment which consists of adding an lift which allow agents to have more possibilities of action. with this new feature, we aim to evaluate the performance of previously trained MARL algorithms on the original environment and observe if potential bottlenecks arise from the addition of this new element. The lift is designed to be used in conjunction with the lever, which is used to activate the lift.
== Lift and Lever
=== Lift
The lift will be a terrain type that allows agents to reach higher levels in the environment. It is designed to be used in conjunction with the lever, which is used to activate the lift. The lift can be used to reach new areas of the environment, allowing agents to explore and find new paths to their goals.
=== Lever
The lever is a terrain type which will be intercatible for the agents are on it. The lever is used to activate the lift, allowing agents on the lift to switch floors. The lever is designed to be used in conjunction with the lift, allowing agents to reach new areas of the environment.
=== Plane extension
The plane extension is the addition of a new dimension which will allow the lift to move vertically... 
== Evaluation
...


#bibliography("bibliography.bib")
