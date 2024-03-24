% Declare variables for the PC-PC synaptic conductance and initial CARLsim
% weight
pcpcWInit = 0.625;
pcpcG = 0.553062478;

% Declare an array for the file strings associated with the network
% structure and PCs involved in each assembly
fileNames = ["network65p_assem275_divnorm.dat","pc_input_pat_1.csv","pc_input_pat_2.csv","pc_input_pat_3.csv"];

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
preNonAssemIdx = find(ismember(G.Edges.EndNodes(:,1),1:1:825));
preNonAssemG = G.Edges(preNonAssemIdx,:);
postNonAssemIdx = find(ismember(preNonAssemG.EndNodes(:,2),1:1:825));
fullNonAssemG = preNonAssemG(postNonAssemIdx,:);
fullNonAssemG = setdiff(fullNonAssemG, assemG);

% Modify synaptic weights so that w is the total weight, i.e., 
% w = CS6 weight * conductance
fullAssem1G.Weight = fullAssem1G.Weight*pcpcG;
fullAssem2G.Weight = fullAssem2G.Weight*pcpcG;
fullAssem3G.Weight = fullAssem3G.Weight*pcpcG;
fullNonAssemG.Weight = fullNonAssemG.Weight*pcpcG;
assemG2 = [fullAssem1G; fullAssem2G; fullAssem3G];

% Create adjacency matrices for assembly and non assembly members
adjPC = adjacency(G,'weighted');
adjPC2 = adjPC(1:numPatterns*patSize,1:numPatterns*patSize);
adjPC2(adjPC2 > 0) = pcpcWInit*pcpcG;
adjPC3 = adjPC(numPatterns*patSize+1:2*numPatterns*patSize,numPatterns*patSize+1:2*numPatterns*patSize);
nonA_nonA = adjPC3(adjPC3>0);

% Take random samples of the assembly-non-assembly and non-assembly
% synapses so that the cdfs have the same number of samples as
% assembly-assembly
s = RandStream('mlfg6331_64');
fullNonAssemWeights = randsample(s,fullNonAssemG.Weight,size(assemG2,1)); 
nonA_nonA_2 = randsample(s,nonA_nonA,size(assemG2,1));
nonA_nonA_2 = nonA_nonA_2*pcpcG;

% Combine all assembly-assembly, assembly-non-assembly, and
% non-assembly-non-assembly weights into one vector for the initial weight
% cdf
allWeights = [assemG2.Weight; fullNonAssemWeights; nonA_nonA_2];
allWeights(allWeights > 0) = pcpcWInit*pcpcG;

% Plot the probability densities for each weight distribution using kernel
% density estimation
fh = figure; clf;
x = xline(full(mean(allWeights)), '--', 'LineWidth', 5, 'Color', 'k');
x.Alpha = 1.0;
hold on;
[f,xi] = ksdensity(assemG2.Weight,'Bandwidth', 0.1);
f(f < 0.1) = 0.1;
plot(xi,f,'Color','r','LineWidth',5);
[f,xi] = ksdensity(fullNonAssemWeights);
f(f < 0.1) = 0.1;
plot(xi,f,'Color','b','LineWidth',5);
[f,xi] = ksdensity(nonA_nonA_2);
f(f < 0.1) = 0.1;
plot(xi,f,'Color','g','LineWidth',5);

% Set the figure in full-screen mode, set x- and y-axis labels, and set the
% names of each neuron type in the legend
fh.WindowState = 'maximized';
hold off;
xlabel('Synaptic Weight (nS)','FontSize',60)
ylabel('Kernel Density','FontSize',60)
title('KDE for Synaptic Weights')
ax = gca;
ax.LineWidth = 5;
ax.FontSize = 25;
grid off;
set(gca,'box','off')
set(gca,'xscale','log')
set(gca,'yscale','log')
xlim([0.1 20])
ax.TickDir = 'out';
legend({'Before Training','Assembly - Assembly','Cross Assembly','Non-Assembly - Non-Assembly'}, 'Interpreter', 'None');