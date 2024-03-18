from group import Group
from synapse import Synapse
import struct
import sys

class Simulation:
    CARLSIM6_SIGNATURE = 294338571

    def __init__(self, filePath, debug=False):
        self.loadSimFID = filePath

        successFlag = False
        with open(filePath, 'rb') as f:
            # read in file header
            (self.signature,self.version,self.simulationTime, self.executionTime, self.numNeurons, self.numGroups) = struct.unpack('ifffii', f.read(24))
            if(debug):
                print('LOADED HEADER')

            # read in groups
            self.groups = []
            for g in range(self.numGroups):
                (startN,endN,sizeX,sizeY,sizeZ,groupName) = struct.unpack('iiiii100s', f.read(120))
                self.groups.append(Group(self.loadSimFID, groupName, startN, endN, sizeX, sizeY, sizeZ))
                if(debug):
                    print('LOADED GROUP: '+str(groupName))

            # read in synapses
            #  note that because saved simulations can have multiple
            #  networks, the synapses are stored on a per network
            #  basis
            (self.netCount,) = struct.unpack('i', f.read(4))
            self.numSynapses = []

            # synapses is a 2d array, with 1st index as the netID
            #  and the 2nd index as the synapseID within that network
            self.synapses = []
            for n in range(self.netCount):
                tempSynapse = []
                (numSynapsesNet,) = struct.unpack('i', f.read(4))
                self.numSynapses.append(numSynapsesNet)
                for s in range(numSynapsesNet):
                    (gGrpIdPre, gGrpIdPost, grpNIdPre, grpNIdPost, connId, weight, maxWeight, delay) = struct.unpack('iiiiiffi',f.read(32))
                    tempSynapse.append(Synapse(self.loadSimFID, gGrpIdPre, gGrpIdPost, grpNIdPre, grpNIdPost, connId, weight, maxWeight, delay))
                    if(debug and s%10000000==0):
                        print('LOADED SYNAPSE: '+str(s))
                self.synapses.append(tempSynapse)

            successFlag = True
        
        if(not successFlag):
           print('ERROR LOADING SIMULATION')
        else:
            print('SIMULATION LOADED SUCCESSFULLY')



    def save(self, filePath, debug=False):
        self.loadSimFID = filePath

        successFlag = False
        with open(filePath, 'wb') as f:
            # read in file header
            f.write(bytearray(struct.pack("i",self.signature)))
            f.write(bytearray(struct.pack("f",self.version)))
            f.write(bytearray(struct.pack("f",self.simulationTime)))
            f.write(bytearray(struct.pack("f",self.executionTime)))
            f.write(bytearray(struct.pack("i",self.numNeurons)))
            f.write(bytearray(struct.pack("i",self.numGroups)))
            if(debug):
                print('WROTE HEADER')

            # write groups
            for g in self.groups:
                f.write(bytearray(struct.pack('iiiii', g.startN, g.endN, g.sizeX, g.sizeY, g.sizeZ)))
                f.write(bytearray(struct.pack('100s',g.groupName)))
                if(debug):
                    print('WROTE GROUP: '+str(g.groupName))

            # write synapses
            #  note that because saved simulations can have multiple
            #  networks, the synapses are stored on a per network
            #  basis
            f.write(bytearray(struct.pack('i', self.netCount)))

            # synapses is a 2d array, with 1st index as the netID
            #  and the 2nd index as the synapseID within that network
            for n in range(self.netCount): # n stands for network
                f.write(bytearray(struct.pack('i',self.numSynapses[n])))
                synCounter = 0
                for s in self.synapses[n]:
                    f.write(bytearray(struct.pack('iiiiiffi',s.gGrpIdPre, s.gGrpIdPost, s.grpNIdPre, s.grpNIdPost, s.connId, s.weight, s.maxWeight, s.delay)))

                    if(debug and synCounter%10000000==0):
                        print('WROTE SYNAPSE: '+str(synCounter))
                    synCounter+=1

            successFlag = True
        
        if(not successFlag):
           print('ERROR SAVING SIMULATION')
        else:
            print('SIMULATION SAVED SUCCESSFULLY')
