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
A Multi-Agent Reinforcement Learning (MARL) is a subfield of the Reinforcement Learning domain which focuses on the interaction between multiple agents in a shared environment. Through the recent years, an increasly amount of research has been conducted in this field to resolve issue that has arisen in the reel world. However, most of the research are done through simulations on environments which does not involve incremental changes. This thesis aims to evaluate the learning performance of MARL algorithms from a know environment to an slightly modified one by adding an unknown element. Under the suppervision of Prof. Tom Lenaerts, and advisor Yannick Molinghen, from the Machine Learning Group (MLG) of the Université Libre de Bruxelles (ULB).

Currently, the research is focused on the the environment of LLE (Laser Learning Reinforcement) which is a environment created by Yannick Molinghen. The environment is a grid world where a single or multiple agents are placed in a grid world. The goal of the agent is to reach a target while avoiding obstacles.

The objective of the Master thesis is to develop a new feature in the LLE environment that was also includes in the original Game morever this feature has also a other objective which is to add a new element in the environment which are not included in the agents learning process. 


== Notations and Definitions

= State of the Art
== Distributed artificial intelligence
// all the following section are from the article "Cooperative Multi-Agent Learning The State of the Art" by [ref to article]
!!(this section has content form the article "Cooperative Multi-Agent Learning The State of the Art" by [ref to article])!!

Distributed artificial intelligence (DAI) is the a field of study which is rising in the last two decades. which is mainly focused on the domain of distributed systems. A distributed system by the definition of [ref to book] is a 
(quote)"where a number of entities work together to cooperatively solve problems"(endquote). this kind of study is not new, it has been studied for a long time. But what is new is the rise of the internet and the multiple electronic devices that we have today. Which bring the need of a new field of study which is the DAI  that simply is the study of the interaction between multiple artificial intelligence (AI) or agents in a distributed system.
=== Multi-Agent Systems vs. Distributed problems Solving
In the field of DAI, we can find two main subfields a more traditional one which is the Distributed Problem Solving (DPS) which us the paradigm of a divide and conquer. The DPS is a field which is focused on distributing the problem to independent slaves which are solving the problem independently. On the other hand, the Multi-Agent Systems (MAS) emphasizes on the interaction between the agents. 

=== Multi-Agent Systems

== Cooperative Multi-Agent Reinforcement Learning


// use article that explain different MAS article to explain what is MARL
// new why MARL is intresting
// get the mollinghen article to explain the LLE environment
// explain why adding a new element in the environment is intresting
// explain LLE agent standard
== Multi-Agent Reinforcement Learning
#lorem(50)




x