import random

class Deterministic(object):

    def __init__(self, matchID):
        #self.matchID += 1
        self.labels = [1,-1]
        self.obsVector = [matchID]
        self.T = 100
        #self.labelList = generateSetSequence()


    def generateLabel(self, matchID):
        #return labelList[matchID]
        if matchID%3 is 0:
            return 1
        else:
            return -1

    def generateObservation(self, matchID):
        self.obsVector[0] += 1
        return self.obsVector[0]




