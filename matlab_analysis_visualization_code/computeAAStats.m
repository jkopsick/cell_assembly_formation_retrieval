function [aaStats] = computeAAStats(fileNames)

% Declare variables for the # of patterns, the pattern size, and variables
% for the network structure to be read in and the readout of the input
% pattern files
simFile = fileNames(1);

input_pat_1 = readmatrix(fileNames(2));
input_pat_1 = input_pat_1(:,1);
input_pat_1 = input_pat_1 + 1;

input_pat_2 = readmatrix(fileNames(3));
input_pat_2 = input_pat_2(:,1);
input_pat_2 = input_pat_2 + 1;

input_pat_3 = readmatrix(fileNames(4));
input_pat_3 = input_pat_3(:,1);
input_pat_3 = input_pat_3 + 1;

numPatterns = 3;
patSize = size(input_pat_1,1);
    
% Computing Auto-Associative SNR
SimR_train1 = SimulationReader(simFile,true);
% Obtain the indices of the recurrent collaterals (RCs)
idx = find(SimR_train1.syns.connId == 50);
% Use the indices to obtain the neuron ids that correspond to the pre and
% postsynaptic PCs involved in the RCs
pyr2pyrPreTrain1 = SimR_train1.syns.grpNIdPre(idx);
pyr2pyrPostTrain1 = SimR_train1.syns.grpNIdPost(idx);
% Use the indices to obtain the weights of the RCs
pyr2pyrWTrain1 = SimR_train1.syns.weights(idx);
G = digraph(pyr2pyrPreTrain1+1,pyr2pyrPostTrain1+1,double(pyr2pyrWTrain1));
adjPC = adjacency(G,'weighted');
figure; clf; imagesc(adjPC(1:numPatterns*patSize,1:numPatterns*patSize))
xlabel('PC Neuron #');
ylabel('PC Neuron #');
title('PC-PC Weight Matrix After Training of Three Patterns')
ax = gca;
ax.LineWidth = 5;
box off
ax.TickDir = 'out';
ax.FontSize = 25;

% Gather all weights associated with assembly members
preAssem1Idx = find(ismember(G.Edges.EndNodes(:,1),input_pat_1(:,1)));
preAssem1G = G.Edges(preAssem1Idx,:);
postAssem1Idx = find(ismember(preAssem1G.EndNodes(:,2),input_pat_1(:,1)));
fullAssem1G = preAssem1G(postAssem1Idx,:);

preAssem2Idx = find(ismember(G.Edges.EndNodes(:,1),input_pat_2(:,1)));
preAssem2G = G.Edges(preAssem2Idx,:);
postAssem2Idx = find(ismember(preAssem2G.EndNodes(:,2),input_pat_2(:,1)));
fullAssem2G = preAssem2G(postAssem2Idx,:);

preAssem3Idx = find(ismember(G.Edges.EndNodes(:,1),input_pat_3(:,1)));
preAssem3G = G.Edges(preAssem3Idx,:);
postAssem3Idx = find(ismember(preAssem3G.EndNodes(:,2),input_pat_3(:,1)));
fullAssem3G = preAssem3G(postAssem3Idx,:);

assemG = [fullAssem1G; fullAssem2G; fullAssem3G];
[nonAssemG] = setdiff(G.Edges, assemG);

figure; clf; histogram([assemG.Weight; nonAssemG.Weight])
hold on;
histogram(assemG.Weight)
xlabel('CS6 Synaptic Weight');
ylabel('Frequency');
title('PC-PC Synaptic Weights After Training of Three Patterns')
ax = gca;
ax.LineWidth = 5;
box off
ax.TickDir = 'out';
ax.FontSize = 25;

meanAssemW = mean(assemG.Weight);
sdAssemW = std(assemG.Weight);
cvAssemW = sdAssemW/meanAssemW;
maxAssemW = max(assemG.Weight);
minAssemW = min(assemG.Weight);

meanNonAssemW = mean(nonAssemG.Weight);
sdNonAssemW = std(nonAssemG.Weight);
cvNonAssemW = sdNonAssemW/meanNonAssemW;
maxNonAssemW = max(nonAssemG.Weight);
minNonAssemW = min(nonAssemG.Weight);
AssemSNR = meanAssemW/meanNonAssemW;

idx = find(assemG.Weight == max(assemG.Weight));
pctMaxW = (size(idx,1)/size(assemG,1))*100;

meanW = mean(G.Edges.Weight);
sdW = std(G.Edges.Weight);
cvW = sdW/meanW;

aaStats = [meanW,sdW,cvW,meanAssemW,sdAssemW,cvAssemW,maxAssemW,minAssemW, ...
           pctMaxW, meanNonAssemW,sdNonAssemW,cvNonAssemW,maxNonAssemW, ...
           minNonAssemW,AssemSNR];