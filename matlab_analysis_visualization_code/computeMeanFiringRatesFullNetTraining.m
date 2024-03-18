function [firingRates] = computeMeanFiringRatesFullNetTraining(binWindow)

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


firingRates = full([mean(mean(SRPyrBinned)) mean(mean(SRAACBinned)) ...
               mean(mean(SRBCBinned)) mean(mean(SRCCKBinned)) ...
               mean(mean(SRBiCBinned)) mean(mean(SRIvyBinned)) ...
               mean(mean(SRMFAOBinned)) mean(mean(SRQuadDBinned))]);
