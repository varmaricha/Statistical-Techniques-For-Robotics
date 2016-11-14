'''1. Nature sends observation.
2.  Learner receives observation, asks each expert to make a prediction.
3.  Nature determines the label.  For adversarial case, the nature gets to see
the weight vector and prediction for each expert (but not directly the nal
prediction made by the learner).
4.  Learner makes a nal prediction and the true label is revealed.
5.  Learner suers loss and updates expert weight.
6.  Repeat.'''

from stochastic import Stochastic
from deterministic import Deterministic
from adversarial import Adversarial
import matplotlib.pyplot as plt
import random

class RWMA(object):

    def __init__(self, N, eta, nature):

        self.N = N
        self.weights = [1]*self.N
        self.eta = eta
        self.T = 100
        self.matchID = 0
        self.h = [0]*self.N
        self.naturelabel= nature
        self.nature = Stochastic(self.matchID)
        self.learner_loss = [0]*self.T
        self.expert_loss = [[0 for i in range(self.N)] for j in range(self.T)]
        self.sum_learner = 0
        self.sum_experts = [0]*self.N
        self.init_nature(self.naturelabel)

    def init_nature(self, naturelabel):
        if naturelabel == 'stochastic':
            self.nature = Stochastic(self.matchID)
        elif naturelabel == 'deterministic':
            self.nature = Deterministic(self.matchID)
        else:
            self.nature = Adversarial(self.matchID)


    def makeExpertPrediction(self):
        obs = self.nature.generateObservation(self.matchID)
        self.h[0] = self.expertOne(obs)
        self.h[1] = self.expertTwo(obs)
        self.h[2] = self.expertThree(obs)


    def getLabel(self):
        print "nature", self.nature
        if self.naturelabel == 'stochastic':
            return self.nature.generateLabel()
        if self.naturelabel == 'deterministic':
            return self.nature.generateLabel(self.matchID)
        else:
            return self.nature.generateLabel(self.weights, self.h)

    def makeLearnerPrediction(self):
        r = random.random()
        sumofweights = sum(self.weights)
        weight_probs = [weight*1.0/sumofweights for weight in self.weights]
        sumofprobs = 0
        for n in range(len(weight_probs)):
            sumofprobs = sumofprobs + weight_probs[n]
            if (r<=sumofprobs):
                index = n
        return self.h[index]



    def updateWeights(self, trueLabel):
        for i in range(len(self.h)):
            #print trueLabel
            #print "\n"
            #print "expert h" + str(self.h[i])
            indicator = 1 if (trueLabel != self.h[i]) else 0
            #print "indicator is", indicator
            #self.weights[i] = [x*(1-(self.eta*indicator)) for x in self.weights]
            self.weights[i] = self.weights[i]*(1-(self.eta*indicator))
        print self.weights
        self.matchID += 1

    def expertOne(self, obs):
        return 1

    def expertTwo(self, obs):
        return -1

    def expertThree(self, obs):
        if obs%2 == 0:
            return -1
        else:
            return 1

    def plot_loss(self):
        plt.plot([expert[0] for expert in self.expert_loss], 'ro',
                 [expert[1] for expert in self.expert_loss], 'yo',
                 [expert[2] for expert in self.expert_loss], 'go',
                 self.learner_loss, 'bo')
        plt.xlabel('Time')
        plt.ylabel('Losses')


    def plot_regret(self, learner_loss, expert_loss):
        best_expert_loss = [min(loss) for loss in expert_loss]
        regret = [0] * self.T
        for t in range(self.T):
            regret[t] = (1.0 *(learner_loss[t] - best_expert_loss[t]))/(t+1)
        plt.figure(2)
        plt.plot(regret,'r-')
        plt.xlabel('t')
        plt.ylabel('regret')
        plt.title(self.nature)
        print "plotted regret"

    def WeightedMajorityAlgorithm(self):

        while self.matchID <self.T:
            self.makeExpertPrediction()
            trueLabel = self.getLabel()
            learnerPrediction = self.makeLearnerPrediction()
            self.sum_learner = self.sum_learner+1 if trueLabel != learnerPrediction else self.sum_learner
            self.learner_loss[self.matchID] = self.sum_learner
            print "sumlearner is", self.sum_learner
            for i in range(self.N):
                self.sum_experts[i] = self.sum_experts[i] + 1 if trueLabel != self.h[i] else self.sum_experts[i]
                self.expert_loss[self.matchID][i] = self.sum_experts[i]
                print "ex loss", self.expert_loss
                print "match id while expert loss update is", self.matchID
            print "sum experts is", self.sum_experts
            #indicator = [1 if trueLabel != learnerPrediction else 0]
            self.updateWeights(trueLabel)
        print "learner loss is", self.learner_loss
        print "expert loss is", self.expert_loss
        self.plot_loss()
        self.plot_regret(self.learner_loss, self.expert_loss)
        plt.show()

if __name__ == "__main__":
    RWMAobj = RWMA(3, 0.1, 'deterministic')
    RWMAobj.WeightedMajorityAlgorithm()










