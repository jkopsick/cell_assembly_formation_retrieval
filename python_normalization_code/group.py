### Constructor for Groups
class Group:
    def __init__(self, loadSimFID, groupName, startN, endN, sizeX, sizeY, sizeZ):
        self.loadSimFID = loadSimFID
        self.groupName = groupName
        self.startN = startN
        self.endN = endN
        self.sizeX = sizeX
        self.sizeY = sizeY
        self.sizeZ = sizeZ
