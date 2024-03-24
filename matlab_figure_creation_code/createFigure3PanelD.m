function [] = createFigure3PanelD(assemB1,assemB2,assemB3, ...
                                  nonAssemB1,nonAssemB2,nonAssemB3)

% mSize = 2.5;
mSize = 10.25;
% mSize = 50;

% Activity of all neuron types during testing of patterns zoomed view
SRPC = SpikeReader('results/spk_CA3_Pyramidal.dat');
SRPyrRaster = SRPC.readSpikes(-1);
SRQuadD = SpikeReader('results/spk_CA3_QuadD_LM.dat');
SRQuadDRaster = SRQuadD.readSpikes(-1);
SRBiC = SpikeReader('results/spk_CA3_Bistratified.dat');
SRBiCRaster = SRBiC.readSpikes(-1);
SRAAC = SpikeReader('results/spk_CA3_Axo_Axonic.dat');
SRAACRaster = SRAAC.readSpikes(-1);
SRIvy = SpikeReader('results/spk_CA3_Ivy.dat');
SRIvyRaster = SRIvy.readSpikes(-1);
SRMFAO = SpikeReader('results/spk_CA3_MFA_ORDEN.dat');
SRMFAORaster = SRMFAO.readSpikes(-1);
SRCCK = SpikeReader('results/spk_CA3_BC_CCK.dat');
SRCCKRaster = SRCCK.readSpikes(-1);
SRBC = SpikeReader('results/spk_CA3_Basket.dat');
SRBCRaster = SRBC.readSpikes(-1);

% Find 50 random QuadD cells to plot during testing window along with PCs
randQuadD = randsample(unique(SRQuadDRaster(2,:)),10);
randQuadDRaster = ismember(SRQuadDRaster(2,:),randQuadD);
randQuadD = [nonAssemB3+1:1:nonAssemB3+10; randQuadD];
randQuadDRasterIdx = find(randQuadDRaster);
SRQuadDRandRaster = SRQuadDRaster(:,randQuadDRasterIdx);
[x,randQuadDLookup] = ismember(SRQuadDRandRaster(2,:),randQuadD);
[~,col] = ind2sub(size(randQuadD),randQuadDLookup);
SRQuadDRandRaster(2,:) = randQuadD(1,col);

% Find 50 random Bistratified cells to plot during testing window along with PCs
randBiC = randsample(unique(SRBiCRaster(2,:)),10);
randBiCRaster = ismember(SRBiCRaster(2,:),randBiC);
randBiC = [nonAssemB3+11:1:nonAssemB3+20; randBiC];
randBiCRasterIdx = find(randBiCRaster);
SRBiCRandRaster = SRBiCRaster(:,randBiCRasterIdx);
[x,randBiCLookup] = ismember(SRBiCRandRaster(2,:),randBiC);
[~,col] = ind2sub(size(randBiC),randBiCLookup);
SRBiCRandRaster(2,:) = randBiC(1,col);

% Find 50 random Axo-axonic cells to plot during testing window along with PCs
randAAC = randsample(unique(SRAACRaster(2,:)),10);
randAACRaster = ismember(SRAACRaster(2,:),randAAC);
randAAC = [nonAssemB3+21:1:nonAssemB3+30; randAAC];
randAACRasterIdx = find(randAACRaster);
SRAACRandRaster = SRAACRaster(:,randAACRasterIdx);
[x,randAACLookup] = ismember(SRAACRandRaster(2,:),randAAC);
[~,col] = ind2sub(size(randAAC),randAACLookup);
SRAACRandRaster(2,:) = randAAC(1,col);

% Find 50 random Axo-axonic cells to plot during testing window along with PCs
randIvy = randsample(unique(SRIvyRaster(2,:)),10);
randIvyRaster = ismember(SRIvyRaster(2,:),randIvy);
randIvy = [nonAssemB3+31:1:nonAssemB3+40; randIvy];
randIvyRasterIdx = find(randIvyRaster);
SRIvyRandRaster = SRIvyRaster(:,randIvyRasterIdx);
[x,randIvyLookup] = ismember(SRIvyRandRaster(2,:),randIvy);
[~,col] = ind2sub(size(randIvy),randIvyLookup);
SRIvyRandRaster(2,:) = randIvy(1,col);

% Find 50 random MFAO cells to plot during testing window along with PCs
randMFAO = randsample(unique(SRMFAORaster(2,:)),10);
randMFAORaster = ismember(SRMFAORaster(2,:),randMFAO);
randMFAO = [nonAssemB3+41:1:nonAssemB3+50; randMFAO];
randMFAORasterIdx = find(randMFAORaster);
SRMFAORandRaster = SRMFAORaster(:,randMFAORasterIdx);
[x,randMFAOLookup] = ismember(SRMFAORandRaster(2,:),randMFAO);
[~,col] = ind2sub(size(randMFAO),randMFAOLookup);
SRMFAORandRaster(2,:) = randMFAO(1,col);

% Find 50 random basket cck cells to plot during testing window along with PCs
randCCK = randsample(unique(SRCCKRaster(2,:)),10);
randCCKRaster = ismember(SRCCKRaster(2,:),randCCK);
randCCK = [nonAssemB3+51:1:nonAssemB3+60; randCCK];
randCCKRasterIdx = find(randCCKRaster);
SRCCKRandRaster = SRCCKRaster(:,randCCKRasterIdx);
[x,randCCKLookup] = ismember(SRCCKRandRaster(2,:),randCCK);
[~,col] = ind2sub(size(randCCK),randCCKLookup);
SRCCKRandRaster(2,:) = randCCK(1,col);

% Find 50 random basket cells to plot during testing window along with PCs
randBC = randsample(unique(SRBCRaster(2,:)),10);
randBCRaster = ismember(SRBCRaster(2,:),randBC);
randBC = [nonAssemB3+61:1:nonAssemB3+70; randBC];
randBCRasterIdx = find(randBCRaster);
SRBCRandRaster = SRBCRaster(:,randBCRasterIdx);
[x,randBCLookup] = ismember(SRBCRandRaster(2,:),randBC);
[~,col] = ind2sub(size(randBC),randBCLookup);
SRBCRandRaster(2,:) = randBC(1,col);

stimAssemIdx = find((SRPyrRaster(2,:) >= 0 & SRPyrRaster(2,:) < assemB1) | ...
(SRPyrRaster(2,:) >= nonAssemB1 & SRPyrRaster(2,:) < assemB2) | ...
(SRPyrRaster(2,:) >= nonAssemB2 & SRPyrRaster(2,:) < assemB3));
nonStimAssemIdx = find((SRPyrRaster(2,:) >= assemB1 & SRPyrRaster(2,:) < nonAssemB1) | ...
(SRPyrRaster(2,:) >= assemB2 & SRPyrRaster(2,:) < nonAssemB2) | ...
(SRPyrRaster(2,:) >= assemB3 & SRPyrRaster(2,:) < nonAssemB3));
fh = figure; clf; plot(SRPyrRaster(1,stimAssemIdx), SRPyrRaster(2,stimAssemIdx), '.r','MarkerSize', mSize);
hold on;
plot(SRPyrRaster(1,nonStimAssemIdx), SRPyrRaster(2,nonStimAssemIdx), '.b','MarkerSize', mSize);
plot(SRQuadDRandRaster(1,:), SRQuadDRandRaster(2,:), '.', 'Color', [39 170 225]./255,'MarkerSize', mSize);
plot(SRBiCRandRaster(1,:), SRBiCRandRaster(2,:), '.', 'Color', [238 42 123]./255,'MarkerSize', mSize);
plot(SRAACRandRaster(1,:), SRAACRandRaster(2,:), '.', 'Color', [237 28 36]./255,'MarkerSize', mSize);
plot(SRIvyRandRaster(1,:), SRIvyRandRaster(2,:), '.', 'Color', [102 45 145]./255,'MarkerSize', mSize);
plot(SRMFAORandRaster(1,:), SRMFAORandRaster(2,:), '.', 'Color', [141 198 63]./255,'MarkerSize', mSize);
plot(SRCCKRandRaster(1,:), SRCCKRandRaster(2,:), '.', 'Color', [96 57 19]./255,'MarkerSize', mSize);
plot(SRBCRandRaster(1,:), SRBCRandRaster(2,:), '.', 'Color', [46 49 146]./255,'MarkerSize', mSize);

fh.WindowState = 'maximized';
xlim([515 1005])
xlabel('time (ms)');
ylabel('Neuron #');
title('Network Raster Activity During Testing of Three Patterns')
ax = gca;
ax.LineWidth = 5;
box off;
ax.TickDir = 'out';
ax.FontSize = 25;



