# Description: This is the basic code for the Deep Q Network (DQN) algorithm.
# source code comes from: https://www.youtube.com/watch?v=wc-FxNENg9U

import torch as T
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import numpy as np
import gymnasium
class DeepQNetwork(nn.Module): 
    def __init__(self, lr, input_dims: list[int], fc1_dims:int, fc2_dims:int, n_actions):
        super(DeepQNetwork, self).__init__()
        self.input_dims = input_dims
        self.fc1_dims = fc1_dims
        self.fc2_dims = fc2_dims
        self.n_actions = n_actions
        self.fc1 = nn.Linear(*self.input_dims, out_features=self.fc1_dims)
        #the *self.input_dims explained at 4:10 in the video
        self.fc2 = nn.Linear(self.fc1_dims, self.fc2_dims)
        self.fc3 = nn.Linear(self.fc2_dims, self.n_actions)
        self.optimizer = optim.Adam(self.parameters(), lr=lr)
        #why Adam? need to search for it
        self.loss = nn.MSELoss()
        #why MSELoss? explained at 5:27 in the video
        #question1
        self.device = T.device('cuda:0' if T.cuda.is_available() else 'cpu')
        self.to(self.device)
        
    def forward(self, state):
        x = F.relu(self.fc1(state)) 
        # note: the nn.linear is a function that applies a linear transformation to the incoming data
        # thus transforming the input dimensions to the output dimensions and F.relu is the activation function
        x = F.relu(self.fc2(x))
        actions = self.fc3(x) 
        return actions
    
    
class Agent(): #explain why we have agent in the early part of the vod
    def __init__(self, gamma, epsilon, lr , input_dims, batch_size , n_actions, max_mem_size=100_000, eps_end=0.01, eps_dec=5e-4):
        self.gamma = gamma
        self.epsilon = epsilon
        self.eps_min = eps_end
        self.eps_dec = eps_dec
        self.lr = lr
        self.action_space = [i for i in range(n_actions)] # ??
        self.mem_size = max_mem_size
        # mem_size is the meme explained int the answer for the question 1, the replay memory buffer size
        self.batch_size = batch_size
        self.mem_cntr= 0
        
        self.q_eval = DeepQNetwork(self.lr , n_actions=n_actions, input_dims=input_dims, fc1_dims=256, fc2_dims=256) #TS 12:10
        
        self.state_memory = np.zeros((self.mem_size, *input_dims), dtype=np.float32)
        self.new_state_memory = np.zeros((self.mem_size,*input_dims), dtype=np.float32)
        self.action_memory = np.zeros(self.mem_size, dtype=np.int32)
        self.reward_memory = np.zeros(self.mem_size, dtype=np.float32)
        self.terminal_memory = np.zeros(self.mem_size, dtype=bool)
        
    def store_transition(self, state, action, reward , state_, done):
        #get first unoccupied memory cell
        index = self.mem_cntr % self.mem_size # wrap around for overwitting oldest mem
        self.state_memory[index] = state
        self.new_state_memory[index]= state_
        self.reward_memory[index] = reward
        self.action_memory[index] = action
        self.terminal_memory[index] = done
        
        self.mem_cntr += 1
        
    def choose_action(self, observation):
        #creat a random number generator using pep compatible generator
        if np.random.random() > self.epsilon:
            state = T.tensor([observation]).to(self.q_eval.device)
            actions = self.q_eval.forward(state)
            action = T.argmax(actions).item()
        else:
            action = np.random.choice(self.action_space)
        return action
        
        
    def learn(self):
        # dilema how to learn 
        # first fill the memory using random actions and then start learning
        # or start learning when the batch size is reached
        if self.mem_cntr < self.batch_size:
            return
        
        self.q_eval.optimizer.zero_grad()  # this is to reset the gradients to zero before backpropagation
        max_mem = min(self.mem_cntr, self.mem_size)
        batch = np.random.choice(max_mem, self.batch_size, replace=False)
        
        batch_index = np.arange(self.batch_size, dtype=np.int32)
        
        state_batch = T.tensor(self.state_memory[batch]).to(self.q_eval.device)
        new_state_batch = T.tensor(self.new_state_memory[batch]).to(self.q_eval.device)
        reward_batch = T.tensor(self.reward_memory[batch]).to(self.q_eval.device)
        terminal_batch = T.tensor(self.terminal_memory[batch]).to(self.q_eval.device)
        
        action_batch = self.action_memory[batch]
        
        q_eval = self.q_eval.forward(state_batch)[batch_index, action_batch]
        q_next = self.q_eval.forward(new_state_batch)
        q_next[terminal_batch]=0.0
        
        q_target = reward_batch + self.gamma * T.max(q_next, dim=1)[0]
        loss = self.q_eval.loss(q_target, q_eval).to(self.q_eval.device)
        loss.backward() #this is the update 
        self.q_eval.optimizer.step() #use the loss to update the tensor
        self.epsilon = self.epsilon - self.eps_dec if self.epsilon > self.eps_min else self.eps_min