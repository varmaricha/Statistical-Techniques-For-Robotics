import random

class Adversarial(object):

    def __init__(self, matchID):
        #self.matchID += 1
        self.labels = [1,-1]
        self.obsVector = [matchID]
        self.T = 100

    def generateLabel(self, weightVec, expertPrediction):
        mwi = weightVec.index(max(weightVec))
        #label = [x for x in self.labels if x != expertPrediction[mwi]]
        label = expertPrediction[mwi]
        return -label

    def generateObservation(self, matchID):
        self.obsVector[0] += 1
        return self.obsVector[0]


