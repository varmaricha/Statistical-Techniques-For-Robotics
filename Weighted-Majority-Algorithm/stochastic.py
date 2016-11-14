import random

class Stochastic(object):

    def __init__(self, matchID):
        #self.matchID += 1
        self.labels = [1,-1]
        self.obsVector = [matchID]
        self.T= 100

    def generateLabel(self):
        label = random.choice(self.labels)
        return label

    def generateObservation(self, matchID):
        self.obsVector[0] += 1
        return self.obsVector[0]


