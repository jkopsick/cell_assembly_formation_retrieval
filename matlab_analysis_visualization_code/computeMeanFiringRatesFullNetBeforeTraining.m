function [firingRates,stdFiringRates] = computeMeanFiringRatesFullNetBeforeTraining(binWindow)

SRPC = SpikeReader('results/spk_CA3_Pyramidal.dat');
SRPyrBinned = SRPC.readSpikes(binWindow);
SRPyrBinned = SRPyrBinned';

SRAAC = SpikeReader('results/spk_CA3_Axo_Axonic.dat');
SRAACBinned = SRAAC.readSpikes(binWindow);
SRAACBinned = SRAACBinned';

SRBC = SpikeReader('results/spk_CA3_Basket.dat');
SRBCBinned = sparse(SRBC.readSpikes(binWindow));
SRBCBinned = SRBCBinned';

SRCCK = SpikeReader('results/spk_CA3_BC_CCK.dat');
SRCCKBinned = SRCCK.readSpikes(binWindow);
SRCCKBinned = SRCCKBinned';

SRBiC = SpikeReader('results/spk_CA3_Bistratified.dat');
SRBiCBinned = SRBiC.readSpikes(binWindow);
SRBiCBinned = SRBiCBinned';

SRIvy = SpikeReader('results/spk_CA3_Ivy.dat');
SRIvyBinned = SRIvy.readSpikes(binWindow);
SRIvyBinned = SRIvyBinned';

SRMFAO = SpikeReader('results/spk_CA3_MFA_ORDEN.dat');
SRMFAOBinned = sparse(SRMFAO.readSpikes(binWindow));
SRMFAOBinned = SRMFAOBinned';

SRQuadD = SpikeReader('results/spk_CA3_QuadD_LM.dat');
SRQuadDBinned = SRQuadD.readSpikes(binWindow);
SRQuadDBinned = SRQuadDBinned';


firingRates = full([mean(SRPyrBinned(:,1)) mean(SRAACBinned(:,1)) ...
               mean(SRBCBinned(:,1)) mean(SRCCKBinned(:,1)) ...
               mean(SRBiCBinned(:,1)) mean(SRIvyBinned(:,1)) ...
               mean(SRMFAOBinned(:,1)) mean(SRQuadDBinned(:,1))]);
           
stdFiringRates = full([std(SRPyrBinned(:,1)) std(SRAACBinned(:,1)) ...
               std(SRBCBinned(:,1)) std(SRCCKBinned(:,1)) ...
               std(SRBiCBinned(:,1)) std(SRIvyBinned(:,1)) ...
               std(SRMFAOBinned(:,1)) std(SRQuadDBinned(:,1))]);