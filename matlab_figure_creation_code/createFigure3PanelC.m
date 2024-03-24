function [] = createFigure3PanelC(assemSize,assemB1,assemB2,assemB3, ...
                                  nonAssemB1,nonAssemB2,nonAssemB3)

mSize = 2.5;
% mSize = 10.25;

% Activity of all neuron types during training
SRPC = SpikeReader('results/spk_CA3_Pyramidal.dat');
SRPyrRaster = SRPC.readSpikes(-1);
SRQuadD = SpikeReader('results/spk_CA3_QuadD_LM.dat');
SRQuadDRaster = SRQuadD.readSpikes(-1);
SRQuadDRaster(2,:) = SRQuadDRaster(2,:) + 75377 + 1;
SRBiC = SpikeReader('results/spk_CA3_Bistratified.dat');
SRBiCRaster = SRBiC.readSpikes(-1);
SRBiCRaster(2,:) = SRBiCRaster(2,:) + 77986 + 1;
SRAAC = SpikeReader('results/spk_CA3_Axo_Axonic.dat');
SRAACRaster = SRAAC.readSpikes(-1);
SRAACRaster(2,:) = SRAACRaster(2,:) + 80267 + 1;
SRIvy = SpikeReader('results/spk_CA3_Ivy.dat');
SRIvyRaster = SRIvy.readSpikes(-1);
SRIvyRaster(2,:) = SRIvyRaster(2,:) + 81749 + 1;
SRMFAO = SpikeReader('results/spk_CA3_MFA_ORDEN.dat');
SRMFAORaster = SRMFAO.readSpikes(-1);
SRMFAORaster(2,:) = SRMFAORaster(2,:) + 83208 + 1;
SRCCK = SpikeReader('results/spk_CA3_BC_CCK.dat');
SRCCKRaster = SRCCK.readSpikes(-1);
SRCCKRaster(2,:) = SRCCKRaster(2,:) + 83770 + 1;
SRBC = SpikeReader('results/spk_CA3_Basket.dat');
SRBCRaster = SRBC.readSpikes(-1);
SRBCRaster(2,:) = SRBCRaster(2,:) + 83938 + 1;

assemIdx = find((SRPyrRaster(2,:) >= 0 & SRPyrRaster(2,:) < assemSize*3));
C = setdiff([1:1:size(SRPyrRaster,2)],[assemIdx]);

% Re-index assembly and non-assembly elements so that the assembly elements
% appear at neuron number 50K
tempAssem = [-assemSize*3:1:-1];
assem = [0:1:assemSize*3-1];
nonAssem = [50000:1:50000+assemSize*3-1];

SRPyrRaster(2,:) = changem(SRPyrRaster(2,:),tempAssem,assem);
SRPyrRaster(2,:) = changem(SRPyrRaster(2,:),assem,nonAssem);
SRPyrRaster(2,:) = changem(SRPyrRaster(2,:),nonAssem,tempAssem);

stimAssemIdx = find((SRPyrRaster(2,:) >= 50000 & SRPyrRaster(2,:) < 50000 + assemB1) | ...
(SRPyrRaster(2,:) >= 50000 + nonAssemB1 & SRPyrRaster(2,:) < 50000 + assemB2) | ...
(SRPyrRaster(2,:) >= 50000 + nonAssemB2 & SRPyrRaster(2,:) < 50000 + assemB3));
nonStimAssemIdx = find((SRPyrRaster(2,:) >= 50000 + assemB1 & SRPyrRaster(2,:) < 50000 + nonAssemB1) | ...
(SRPyrRaster(2,:) >= 50000 + assemB2 & SRPyrRaster(2,:) < 50000 + nonAssemB2) | ...
(SRPyrRaster(2,:) >= 50000 + assemB3 & SRPyrRaster(2,:) < 50000 + nonAssemB3));
C = setdiff([1:1:size(SRPyrRaster,2)],[stimAssemIdx nonStimAssemIdx]);

fh = figure; clf; plot(SRPyrRaster(1,C), SRPyrRaster(2,C), '.k','MarkerSize', mSize);
hold on; 
plot(SRPyrRaster(1,stimAssemIdx), SRPyrRaster(2,stimAssemIdx), '.r','MarkerSize', mSize);
plot(SRPyrRaster(1,nonStimAssemIdx), SRPyrRaster(2,nonStimAssemIdx), '.b','MarkerSize', mSize);
plot(SRQuadDRaster(1,:), SRQuadDRaster(2,:), '.', 'Color', [39 170 225]./255,'MarkerSize', mSize);
plot(SRBiCRaster(1,:), SRBiCRaster(2,:), '.', 'Color', [238 42 123]./255,'MarkerSize', mSize);
plot(SRAACRaster(1,:), SRAACRaster(2,:), '.', 'Color', [237 28 36]./255,'MarkerSize', mSize);
plot(SRIvyRaster(1,:), SRIvyRaster(2,:), '.', 'Color', [102 45 145]./255,'MarkerSize', mSize);
plot(SRMFAORaster(1,:), SRMFAORaster(2,:), '.', 'Color', [141 198 63]./255,'MarkerSize', mSize);
plot(SRCCKRaster(1,:), SRCCKRaster(2,:), '.', 'Color', [96 57 19]./255,'MarkerSize', mSize);
plot(SRBCRaster(1,:), SRBCRaster(2,:), '.', 'Color', [46 49 146]./255,'MarkerSize', mSize);
fh.WindowState = 'maximized';
xlabel('time (s)');
ylabel('Neuron #');
title('Network Raster Activity During Testing of Three Patterns')
ax = gca;
ax.LineWidth = 5;
box off;
ax.TickDir = 'out';
ax.FontSize = 25;