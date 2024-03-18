### Constructor for Synapses
class Synapse:
    def __init__(self, loadSimFID, gGrpIdPre, gGrpIdPost, grpNIdPre, grpNIdPost, connId, weight, maxWeight, delay):
        self.loadSimFID = loadSimFID
        self.gGrpIdPre = gGrpIdPre
        self.gGrpIdPost = gGrpIdPost
        self.grpNIdPre = grpNIdPre
        self.grpNIdPost = grpNIdPost
        self.connId = connId
        self.weight = weight
        self.maxWeight = maxWeight
        self.delay = delay
