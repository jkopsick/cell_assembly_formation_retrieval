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

% Create adjacency matrices for assembly and non assembly members
adjPC = adjacency(G,'weighted');
pcBlockMat = adjPC(1:numPatterns*patSize,1:numPatterns*patSize);
idx = pcBlockMat > 0;
pcBlockMat(idx) = pcBlockMat(idx)*pcpcG;
adjPC2 = adjPC(1:numPatterns*patSize,1:numPatterns*patSize);
adjPC2(adjPC2 > 0) = pcpcWInit*pcpcG;
adjPC3 = adjPC(numPatterns*patSize+1:2*numPatterns*patSize,numPatterns*patSize+1:2*numPatterns*patSize);
adjPC4 = adjPC3;
adjPC4(adjPC4 > 0) = pcpcWInit*pcpcG;

% Plot assembly members weight matrix before training
fh = figure; clf;
[x, y] = meshgrid(1:size(adjPC2,2), 1:size(adjPC2,1));
z = adjPC2(:);
scatter3(x(:), y(:), z, 8, z, 'filled');
fh.WindowState = 'maximized';
view([10 -0.001 100000000])
xlim([0 size(adjPC2,1)-1])
ylim([0 size(adjPC2,1)-1])
xlabel('PC Neuron #');
ylabel('PC Neuron #');
title('PC-PC Weights Between Assembly Members Before Training of Three Patterns')
ax = gca;
ax.LineWidth = 5;
box off
ax.TickDir = 'out';
ax.FontSize = 25;
a = colorbar;
a.TickDirection = 'out';
a.LineWidth = 5;
a.Label.String = 'Synaptic Weight (nS)';

% Plot assembly members weight matrix after training
fh = figure; clf;
[x, y] = meshgrid(1:size(pcBlockMat,2), 1:size(pcBlockMat,1));
z = pcBlockMat(:);
scatter3(x(:), y(:), z, 8, z, 'filled');
fh.WindowState = 'maximized';
view([10 -0.001 100000000])
xlim([0 size(adjPC2,1)-1])
ylim([0 size(adjPC2,1)-1])
xlabel('PC Neuron #');
ylabel('PC Neuron #');
title('PC-PC Weights Between Assembly Members After Training of Three Patterns')
ax = gca;
ax.LineWidth = 5;
box off
ax.TickDir = 'out';
ax.FontSize = 25;
a = colorbar;
a.TickDirection = 'out';
a.LineWidth = 5;
a.Label.String = 'Synaptic Weight (nS)';

% Plot matrix of non-assembly members before training
fh = figure; clf;
[x, y] = meshgrid(1:size(adjPC4,2), 1:size(adjPC4,1));
z = adjPC4(:);
scatter3(x(:), y(:), z, 8, z, 'filled');
fh.WindowState = 'maximized';
view([10 -0.001 100000000])
xlim([0 size(adjPC2,1)-1])
ylim([0 size(adjPC2,1)-1])
xlabel('PC Neuron #');
ylabel('PC Neuron #');
title('PC-PC Weights Between Non-Assembly Members Before Training of Three Patterns')
ax = gca;
ax.LineWidth = 5;
box off
ax.TickDir = 'out';
ax.FontSize = 25;
a = colorbar;
a.TickDirection = 'out';
a.LineWidth = 5;
a.Label.String = 'Synaptic Weight (nS)';

% Plot matrix of non-assembly members after training
fh = figure; clf;
[x, y] = meshgrid(1:size(adjPC3,2), 1:size(adjPC3,1));
z = adjPC3(:);
scatter3(x(:), y(:), z, 8, z, 'filled');
fh.WindowState = 'maximized';
view([10 -0.001 100000000])
xlim([0 size(adjPC2,1)-1])
ylim([0 size(adjPC2,1)-1])
xlabel('PC Neuron #');
ylabel('PC Neuron #');
title('PC-PC Weights Between Non-Assembly Members After Training of Three Patterns')
ax = gca;
ax.LineWidth = 5;
box off
ax.TickDir = 'out';
ax.FontSize = 25;
a = colorbar;
a.TickDirection = 'out';
a.LineWidth = 5;
a.Label.String = 'Synaptic Weight (nS)';