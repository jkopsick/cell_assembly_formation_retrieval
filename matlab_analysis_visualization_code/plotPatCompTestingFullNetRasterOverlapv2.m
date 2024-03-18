function [] = plotPatCompTestingFullNetRasterOverlapv2(fileNames)

% Declare variables for the # of patterns, the pattern size, and variables
% for the network structure to be read in and the readout of the input
% pattern files

stim_pat_1 = readmatrix(fileNames(1));
stim_pat_1 = stim_pat_1(:,1);
stim_pat_2 = readmatrix(fileNames(2));
stim_pat_2 = stim_pat_2(:,1);
stim_pat_3 = readmatrix(fileNames(3));
stim_pat_3 = stim_pat_3(:,1);

pat_1 = readmatrix(fileNames(4));
pat_1 = pat_1(:,1);

pat_2 = readmatrix(fileNames(5));
pat_2 = pat_2(:,1);

pat_3 = readmatrix(fileNames(6));
pat_3 = pat_3(:,1);

patSize = size(pat_1,1);

ov12 = intersect(pat_1,pat_2);
ov13 = intersect(pat_1,pat_3);
ov23 = intersect(pat_2,pat_3);

maxCellAssemNum = 3*patSize;

pat1StartTime = 521;
pat1EndTime = 540;
pat2StartTime = 751;
pat2EndTime = 770;
pat3StartTime = 981;
pat3EndTime = 1000;

% Activity of all neuron types during testing of patterns
SRPC = SpikeReader('results/spk_CA3_Pyramidal.dat');
SRPyrRaster = SRPC.readSpikes(-1);
pyrRasterZeroIdx = find((SRPyrRaster(1,:)==0) & (SRPyrRaster(2,:)==0));
SRPyrRaster(:,pyrRasterZeroIdx) = [];
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

stimOvAssem1Idx = find(ismember(SRPyrRaster(2,:),intersect([ov12;ov13],stim_pat_1)));
stimOvAssem1 = SRPyrRaster(2,stimOvAssem1Idx);
stimOvAssem1U = unique(stimOvAssem1);
stimAssem1Idx = find(ismember(SRPyrRaster(2,:),setdiff(stim_pat_1,stimOvAssem1U)));
stimAssem1 = SRPyrRaster(2,stimAssem1Idx);
stimAssem1U = unique(stimAssem1);

nonStimOvAssem1Idx = find(ismember(SRPyrRaster(2,:),intersect([ov12;ov13],setdiff(pat_1,stim_pat_1))));
nonStimOvAssem1 = SRPyrRaster(2,nonStimOvAssem1Idx);
nonStimOvAssem1U = unique(nonStimOvAssem1);
nonStimAssem1Idx = find(ismember(SRPyrRaster(2,:),setdiff(setdiff(pat_1,stim_pat_1),nonStimOvAssem1U)));
nonStimAssem1 = SRPyrRaster(2,nonStimAssem1Idx);
nonStimAssem1U = unique(nonStimAssem1);

% pat_1(:,2) = 0;
% pat_1(intersect(stimAssem1U,pat_1)+1,2) = 1;
% pat_1(intersect(stimOvAssem1U,pat_1)+1,2) = 2;
% pat_1(intersect(nonStimAssem1U,pat_1)+1,2) = 3;
% pat_1(intersect(nonStimOvAssem1U,pat_1)+1,2) = 4;
% nonActivePat1Idx = find(pat_1(:,2)==0);
% pat_1(nonActivePat1Idx,:) = [];
% pat_1 = sortrows(pat_1,2);
% pat_1(:,3) = 0:1:patSize-1-size(nonActivePat1Idx,1);

pat_1(:,2) = 0;
stimPat1Idx = ismember(pat_1(:,1),stimAssem1U);
stimPat1Idx = find(stimPat1Idx);
pat_1(stimPat1Idx,2) = 1;
stimPatOv1Idx = ismember(pat_1(:,1),stimOvAssem1U);
stimPatOv1Idx = find(stimPatOv1Idx);
pat_1(stimPatOv1Idx,2) = 2;
nonStimPat1Idx = ismember(pat_1(:,1),nonStimAssem1U);
nonStimPat1Idx = find(nonStimPat1Idx);
pat_1(nonStimPat1Idx,2) = 3;
nonStimPatOv1Idx = ismember(pat_1(:,1),nonStimOvAssem1U);
nonStimPatOv1Idx = find(nonStimPatOv1Idx);
pat_1(nonStimPatOv1Idx,2) = 4;
if nnz(pat_1(:,2)) < patSize
    nonActivePat1Idx = find(pat_1(:,2)==0);
    pat_1(nonActivePat1Idx,:) = [];
    pat_1 = sortrows(pat_1,2);
    pat_1(:,3) = 0:1:patSize-1-size(nonActivePat1Idx,1);
else
    pat_1 = sortrows(pat_1,2);
    pat_1(:,3) = 0:1:patSize-1;
end

stimOvAssem2Idx = find(ismember(SRPyrRaster(2,:),intersect([ov12;ov23],stim_pat_2)));
stimOvAssem2 = SRPyrRaster(2,stimOvAssem2Idx);
stimOvAssem2U = unique(stimOvAssem2);
stimAssem2Idx = find(ismember(SRPyrRaster(2,:),setdiff(stim_pat_2,stimOvAssem2U)));
stimAssem2 = SRPyrRaster(2,stimAssem2Idx);
stimAssem2U = unique(stimAssem2);

nonStimOvAssem2Idx = find(ismember(SRPyrRaster(2,:),intersect([ov12;ov23],setdiff(pat_2,stim_pat_2))));
nonStimOvAssem2 = SRPyrRaster(2,nonStimOvAssem2Idx);
nonStimOvAssem2U = unique(nonStimOvAssem2);
nonStimAssem2Idx = find(ismember(SRPyrRaster(2,:),setdiff(setdiff(pat_2,stim_pat_2),nonStimOvAssem2U)));
nonStimAssem2 = SRPyrRaster(2,nonStimAssem2Idx);
nonStimAssem2U = unique(nonStimAssem2);

pat_2(:,2) = 0;
stimPat2Idx = ismember(pat_2(:,1),stimAssem2U);
stimPat2Idx = find(stimPat2Idx);
pat_2(stimPat2Idx,2) = 1;
stimPatOv2Idx = ismember(pat_2(:,1),stimOvAssem2U);
stimPatOv2Idx = find(stimPatOv2Idx);
pat_2(stimPatOv2Idx,2) = 2;
nonStimPat2Idx = ismember(pat_2(:,1),nonStimAssem2U);
nonStimPat2Idx = find(nonStimPat2Idx);
pat_2(nonStimPat2Idx,2) = 3;
nonStimPatOv2Idx = ismember(pat_2(:,1),nonStimOvAssem2U);
nonStimPatOv2Idx = find(nonStimPatOv2Idx);
pat_2(nonStimPatOv2Idx,2) = 4;
if nnz(pat_2(:,2)) < patSize
    nonActivePat2Idx = find(pat_2(:,2)==0);
    pat_2(nonActivePat2Idx,:) = [];
    pat_2 = sortrows(pat_2,2);
    pat_2(:,3) = patSize:1:2*patSize-1-size(nonActivePat2Idx,1);
else
    pat_2 = sortrows(pat_2,2);
    pat_2(:,3) = patSize:1:2*patSize-1;
end

stimOvAssem3Idx = find(ismember(SRPyrRaster(2,:),intersect([ov13;ov23],stim_pat_3)));
stimOvAssem3 = SRPyrRaster(2,stimOvAssem3Idx);
stimOvAssem3U = unique(stimOvAssem3);
stimAssem3Idx = find(ismember(SRPyrRaster(2,:),setdiff(stim_pat_3,stimOvAssem3U)));
stimAssem3 = SRPyrRaster(2,stimAssem3Idx);
stimAssem3U = unique(stimAssem3);

nonStimOvAssem3Idx = find(ismember(SRPyrRaster(2,:),intersect([ov13;ov23],setdiff(pat_3,stim_pat_3))));
nonStimOvAssem3 = SRPyrRaster(2,nonStimOvAssem3Idx);
nonStimOvAssem3U = unique(nonStimOvAssem3);
nonStimAssem3Idx = find(ismember(SRPyrRaster(2,:),setdiff(setdiff(pat_3,stim_pat_3),nonStimOvAssem3U)));
nonStimAssem3 = SRPyrRaster(2,nonStimAssem3Idx);
nonStimAssem3U = unique(nonStimAssem3);

pat_3(:,2) = 0;
stimPat3Idx = ismember(pat_3(:,1),stimAssem3U);
stimPat3Idx = find(stimPat3Idx);
pat_3(stimPat3Idx,2) = 1;
stimPatOv3Idx = ismember(pat_3(:,1),stimOvAssem3U);
stimPatOv3Idx = find(stimPatOv3Idx);
pat_3(stimPatOv3Idx,2) = 2;
nonStimPat3Idx = ismember(pat_3(:,1),nonStimAssem3U);
nonStimPat3Idx = find(nonStimPat3Idx);
pat_3(nonStimPat3Idx,2) = 3;
nonStimPatOv3Idx = ismember(pat_3(:,1),nonStimOvAssem3U);
nonStimPatOv3Idx = find(nonStimPatOv3Idx);
pat_3(nonStimPatOv3Idx,2) = 4;
if nnz(pat_3(:,2)) < patSize
    nonActivePat3Idx = find(pat_3(:,2)==0);
    pat_3(nonActivePat3Idx,:) = [];
    pat_3 = sortrows(pat_3,2);
    pat_3(:,3) = 2*patSize:1:3*patSize-1-size(nonActivePat3Idx,1);
else
    pat_3 = sortrows(pat_3,2);
    pat_3(:,3) = 2*patSize:1:3*patSize-1;
end

new_pat_1 = pat_1;
new_pat_2 = pat_2;
new_pat_3 = pat_3;
new_pat_2 = sortrows(new_pat_2);
new_pat_3 = sortrows(new_pat_3);
ov12Idx = ismember(new_pat_1(:,1),new_pat_2(:,1));
ov13Idx = ismember(new_pat_1(:,1),new_pat_3(:,1));
ov21Idx = ismember(new_pat_2(:,1),new_pat_1(:,1));
ov23Idx = ismember(new_pat_2(:,1),new_pat_3(:,1));
ov31Idx = ismember(new_pat_3(:,1),new_pat_1(:,1));
ov32Idx = ismember(new_pat_3(:,1),new_pat_2(:,1));
ov321Idx = ismember(new_pat_3(:,1),[new_pat_1(:,1); new_pat_2(:,1)]);

new_pat_1_ov12 = sortrows(new_pat_1(ov12Idx,:));
new_pat_2(ov21Idx,3) = new_pat_1_ov12(:,3);

new_pat_1_ov13 = sortrows(new_pat_1(ov13Idx,:));
new_pat_2_ov23 = sortrows(new_pat_2(ov23Idx,:));
new_pat_3(ov31Idx,3) = new_pat_1_ov13(:,3);
new_pat_3(ov32Idx,3) = new_pat_2_ov23(:,3);



SRPyrRaster(2,:) = changem(SRPyrRaster(2,:),pat_1(:,3),pat_1(:,1));
% SRPyrRaster(2,:) = changem(SRPyrRaster(2,:),new_pat_2(:,3),new_pat_2(:,1));
SRPyrRaster(2,:) = changem(SRPyrRaster(2,:),new_pat_2(~ov21Idx,3),new_pat_2(~ov21Idx,1));
% SRPyrRaster(2,:) = changem(SRPyrRaster(2,:),new_pat_3(:,3),new_pat_3(:,1));
SRPyrRaster(2,:) = changem(SRPyrRaster(2,:),new_pat_3(~ov321Idx,3),new_pat_3(~ov321Idx,1));

newStimAssem1Idx = any(pat_1(:,2) == 1, 2);
newStimAssem2Idx = any(new_pat_2(:,2) == 1, 2);
newStimAssem3Idx = any(new_pat_3(:,2) == 1, 2);
newStimAssemIdx = [find(ismember(SRPyrRaster(2,:),pat_1(newStimAssem1Idx,3))) ...
                find(ismember(SRPyrRaster(2,:),new_pat_2(newStimAssem2Idx,3))) ...
                find(ismember(SRPyrRaster(2,:),new_pat_3(newStimAssem3Idx,3)))
                ];

newStimOvAssem1Idx = any(pat_1(:,2) == 2, 2);            
newStimOvAssem2Idx = any(new_pat_2(:,2) == 2, 2);
newStimOvAssem3Idx = any(new_pat_3(:,2) == 2, 2);
newStimOvAssemIdx = [find(ismember(SRPyrRaster(2,:),pat_1(newStimOvAssem1Idx,3))) ...
                find(ismember(SRPyrRaster(2,:),new_pat_2(newStimOvAssem2Idx,3))) ...
                find(ismember(SRPyrRaster(2,:),new_pat_3(newStimOvAssem3Idx,3)))
                ];
            
newNonStimAssem1Idx = any(pat_1(:,2) == 3, 2);
newNonStimAssem2Idx = any(new_pat_2(:,2) == 3, 2);
newNonStimAssem3Idx = any(new_pat_3(:,2) == 3, 2);
newNonStimAssemIdx = [find(ismember(SRPyrRaster(2,:),pat_1(newNonStimAssem1Idx,3))) ...
                find(ismember(SRPyrRaster(2,:),new_pat_2(newNonStimAssem2Idx,3))) ...
                find(ismember(SRPyrRaster(2,:),new_pat_3(newNonStimAssem3Idx,3)))
                ];
            
newNonStimOvAssem1Idx = any(pat_1(:,2) == 4, 2);
newNonStimOvAssem2Idx = any(new_pat_2(:,2) == 4, 2);
newNonStimOvAssem3Idx = any(new_pat_3(:,2) == 4, 2);
newNonStimOvAssemIdx = [find(ismember(SRPyrRaster(2,:),pat_1(newNonStimOvAssem1Idx,3))) ...
                find(ismember(SRPyrRaster(2,:),new_pat_2(newNonStimOvAssem2Idx,3))) ...
                find(ismember(SRPyrRaster(2,:),new_pat_3(newNonStimOvAssem3Idx,3)))
                ];
            
C = setdiff([1:1:size(SRPyrRaster,2)],[newStimAssemIdx newStimOvAssemIdx ...
                                       newNonStimAssemIdx newNonStimOvAssemIdx]);

fh = figure; clf; plot(SRPyrRaster(1,C), SRPyrRaster(2,C), '.k','MarkerSize', 5.25);
hold on; 
plot(SRPyrRaster(1,newStimAssemIdx), SRPyrRaster(2,newStimAssemIdx), '.r','MarkerSize', 5.25);
plot(SRPyrRaster(1,newNonStimAssemIdx), SRPyrRaster(2,newNonStimAssemIdx), '.b','MarkerSize', 5.25);
plot(SRPyrRaster(1,newStimOvAssemIdx), SRPyrRaster(2,newStimOvAssemIdx), '.c','MarkerSize', 5.25);
plot(SRPyrRaster(1,newNonStimOvAssemIdx), SRPyrRaster(2,newNonStimOvAssemIdx), '.g','MarkerSize', 5.25);
plot(SRQuadDRaster(1,:), SRQuadDRaster(2,:), '.', 'Color', [39 170 225]./255,'MarkerSize', 0.25);
plot(SRBiCRaster(1,:), SRBiCRaster(2,:), '.', 'Color', [238 42 123]./255,'MarkerSize', 0.25);
plot(SRAACRaster(1,:), SRAACRaster(2,:), '.', 'Color', [237 28 36]./255,'MarkerSize', 0.25);
plot(SRIvyRaster(1,:), SRIvyRaster(2,:), '.', 'Color', [102 45 145]./255,'MarkerSize', 0.25);
plot(SRMFAORaster(1,:), SRMFAORaster(2,:), '.', 'Color', [141 198 63]./255,'MarkerSize', 0.25);
plot(SRCCKRaster(1,:), SRCCKRaster(2,:), '.', 'Color', [96 57 19]./255,'MarkerSize', 0.25);
plot(SRBCRaster(1,:), SRBCRaster(2,:), '.', 'Color', [46 49 146]./255,'MarkerSize', 0.25);
fh.WindowState = 'maximized';
xlabel('time (ms)');
ylabel('Neuron #');
title('Network Raster Activity During Testing of Three Patterns')
ax = gca;
ax.LineWidth = 5;
box off;
ax.TickDir = 'out';
ax.FontSize = 15;

% Activity of all neuron types during testing of patterns zoomed view
% SRPC = SpikeReader('results/spk_CA3_Pyramidal.dat');
% SRPyrRaster = SRPC.readSpikes(-1);
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
randQuadD = [maxCellAssemNum+1:1:maxCellAssemNum+10; randQuadD];
randQuadDRasterIdx = find(randQuadDRaster);
SRQuadDRandRaster = SRQuadDRaster(:,randQuadDRasterIdx);
[x,randQuadDLookup] = ismember(SRQuadDRandRaster(2,:),randQuadD);
[~,col] = ind2sub(size(randQuadD),randQuadDLookup);
SRQuadDRandRaster(2,:) = randQuadD(1,col);

% Find 50 random Bistratified cells to plot during testing window along with PCs
randBiC = randsample(unique(SRBiCRaster(2,:)),10);
randBiCRaster = ismember(SRBiCRaster(2,:),randBiC);
randBiC = [maxCellAssemNum+11:1:maxCellAssemNum+20; randBiC];
randBiCRasterIdx = find(randBiCRaster);
SRBiCRandRaster = SRBiCRaster(:,randBiCRasterIdx);
[x,randBiCLookup] = ismember(SRBiCRandRaster(2,:),randBiC);
[~,col] = ind2sub(size(randBiC),randBiCLookup);
SRBiCRandRaster(2,:) = randBiC(1,col);

% Find 50 random Axo-axonic cells to plot during testing window along with PCs
randAAC = randsample(unique(SRAACRaster(2,:)),10);
randAACRaster = ismember(SRAACRaster(2,:),randAAC);
randAAC = [maxCellAssemNum+21:1:maxCellAssemNum+30; randAAC];
randAACRasterIdx = find(randAACRaster);
SRAACRandRaster = SRAACRaster(:,randAACRasterIdx);
[x,randAACLookup] = ismember(SRAACRandRaster(2,:),randAAC);
[~,col] = ind2sub(size(randAAC),randAACLookup);
SRAACRandRaster(2,:) = randAAC(1,col);

% Find 50 random Axo-axonic cells to plot during testing window along with PCs
randIvy = randsample(unique(SRIvyRaster(2,:)),10);
randIvyRaster = ismember(SRIvyRaster(2,:),randIvy);
randIvy = [maxCellAssemNum+31:1:maxCellAssemNum+40; randIvy];
randIvyRasterIdx = find(randIvyRaster);
SRIvyRandRaster = SRIvyRaster(:,randIvyRasterIdx);
[x,randIvyLookup] = ismember(SRIvyRandRaster(2,:),randIvy);
[~,col] = ind2sub(size(randIvy),randIvyLookup);
SRIvyRandRaster(2,:) = randIvy(1,col);

% Find 50 random MFAO cells to plot during testing window along with PCs
randMFAO = randsample(unique(SRMFAORaster(2,:)),10);
randMFAORaster = ismember(SRMFAORaster(2,:),randMFAO);
randMFAO = [maxCellAssemNum+41:1:maxCellAssemNum+50; randMFAO];
randMFAORasterIdx = find(randMFAORaster);
SRMFAORandRaster = SRMFAORaster(:,randMFAORasterIdx);
[x,randMFAOLookup] = ismember(SRMFAORandRaster(2,:),randMFAO);
[~,col] = ind2sub(size(randMFAO),randMFAOLookup);
SRMFAORandRaster(2,:) = randMFAO(1,col);

% Find 50 random basket cck cells to plot during testing window along with PCs
randCCK = randsample(unique(SRCCKRaster(2,:)),10);
randCCKRaster = ismember(SRCCKRaster(2,:),randCCK);
randCCK = [maxCellAssemNum+51:1:maxCellAssemNum+60; randCCK];
randCCKRasterIdx = find(randCCKRaster);
SRCCKRandRaster = SRCCKRaster(:,randCCKRasterIdx);
[x,randCCKLookup] = ismember(SRCCKRandRaster(2,:),randCCK);
[~,col] = ind2sub(size(randCCK),randCCKLookup);
SRCCKRandRaster(2,:) = randCCK(1,col);

% Find 50 random basket cells to plot during testing window along with PCs
randBC = randsample(unique(SRBCRaster(2,:)),10);
randBCRaster = ismember(SRBCRaster(2,:),randBC);
randBC = [maxCellAssemNum+61:1:maxCellAssemNum+70; randBC];
randBCRasterIdx = find(randBCRaster);
SRBCRandRaster = SRBCRaster(:,randBCRasterIdx);
[x,randBCLookup] = ismember(SRBCRandRaster(2,:),randBC);
[~,col] = ind2sub(size(randBC),randBCLookup);
SRBCRandRaster(2,:) = randBC(1,col);

fh = figure; clf; plot(SRPyrRaster(1,newStimAssemIdx), SRPyrRaster(2,newStimAssemIdx), '.r','MarkerSize', 5.25);
hold on;
plot(SRPyrRaster(1,newNonStimAssemIdx), SRPyrRaster(2,newNonStimAssemIdx), '.b','MarkerSize', 5.25);
plot(SRPyrRaster(1,newStimOvAssemIdx), SRPyrRaster(2,newStimOvAssemIdx), '.c','MarkerSize', 5.25);
plot(SRPyrRaster(1,newNonStimOvAssemIdx), SRPyrRaster(2,newNonStimOvAssemIdx), '.g','MarkerSize', 5.25);
plot(SRQuadDRandRaster(1,:), SRQuadDRandRaster(2,:), '.', 'Color', [39 170 225]./255,'MarkerSize', 5.25);
plot(SRBiCRandRaster(1,:), SRBiCRandRaster(2,:), '.', 'Color', [238 42 123]./255,'MarkerSize', 5.25);
plot(SRAACRandRaster(1,:), SRAACRandRaster(2,:), '.', 'Color', [237 28 36]./255,'MarkerSize', 5.25);
plot(SRIvyRandRaster(1,:), SRIvyRandRaster(2,:), '.', 'Color', [102 45 145]./255,'MarkerSize', 5.25);
plot(SRMFAORandRaster(1,:), SRMFAORandRaster(2,:), '.', 'Color', [141 198 63]./255,'MarkerSize', 5.25);
plot(SRCCKRandRaster(1,:), SRCCKRandRaster(2,:), '.', 'Color', [96 57 19]./255,'MarkerSize', 5.25);
plot(SRBCRandRaster(1,:), SRBCRandRaster(2,:), '.', 'Color', [46 49 146]./255,'MarkerSize', 5.25);

fh.WindowState = 'maximized';
% xlim([3995 4495])
xlim([515 1005])
xlabel('time (ms)');
ylabel('Neuron #');
title('Network Raster Activity During Testing of Three Patterns')
ax = gca;
ax.LineWidth = 5;
box off;
ax.TickDir = 'out';
ax.FontSize = 15;
