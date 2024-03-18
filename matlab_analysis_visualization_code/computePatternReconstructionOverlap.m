function [patternReconstruction] = computePatternReconstructionOverlap( ...
                                   trainPath,testPath,numTrainCycles, ...
                                   trainPatStartTime,testPatStartTime, ...
                                   patDuration,trainPatDelay,testPatDelay)

% Create a variable that defines the bin window
binWindow = 10;
                                     
% Create variables that will define the different pattern start times                                     
testPat1 = testPatStartTime/binWindow + 1;
testPat2 = (testPatStartTime + patDuration*1 + testPatDelay*1)/binWindow + 1;
testPat3 = (testPatStartTime + patDuration*2 + testPatDelay*2)/binWindow + 1;

trainPat1 = (trainPatStartTime + (patDuration+trainPatDelay)*3*(numTrainCycles-1))/binWindow + 1;
trainPat2 = (trainPatStartTime + 1*(patDuration+trainPatDelay) + (patDuration+trainPatDelay)*3*(numTrainCycles-1))/binWindow + 1;
trainPat3 = (trainPatStartTime + 2*(patDuration+trainPatDelay) + (patDuration+trainPatDelay)*3*(numTrainCycles-1))/binWindow + 1;

cd(trainPath)

% Read in the input patterns and sort them so that the neuron number and
% corresponding spike counts during the 40 ms are in ascending order
input_pat_1 = readmatrix('pc_input_pat_1_half.csv');
input_pat_2 = readmatrix('pc_input_pat_2_half.csv');
input_pat_3 = readmatrix('pc_input_pat_3_half.csv');

input_pat_1(:,1) = input_pat_1(:,1) + 1;
input_pat_2(:,1) = input_pat_2(:,1) + 1;
input_pat_3(:,1) = input_pat_3(:,1) + 1;

% Create an object that will read and store spikes for the training session
% 1 
SRTrain = SpikeReader('results/spk_CA3_Pyramidal.dat');
SRPyrBinnedTrain = SRTrain.readSpikes(binWindow);
SRPyrBinnedTrain = SRPyrBinnedTrain';

cd ..

cd(testPath)

% Create an object that will read and store spikes for the test session
SRTest = SpikeReader('results/spk_CA3_Pyramidal.dat');
SRPyrBinnedTest = SRTest.readSpikes(binWindow);
SRPyrBinnedTest = SRPyrBinnedTest';

% Add in loading of degraded input patterns here
degrade_input_pat_1 = readmatrix('pc_degrade_input_pat_1.csv');
degrade_input_pat_2 = readmatrix('pc_degrade_input_pat_2.csv');
degrade_input_pat_3 = readmatrix('pc_degrade_input_pat_3.csv');

degrade_input_pat_1(:,2) = 2;
degrade_input_pat_2(:,2) = 2;
degrade_input_pat_3(:,2) = 2;

degrade_input_pat_1(:,1) = degrade_input_pat_1(:,1) + 1;
degrade_input_pat_2(:,1) = degrade_input_pat_2(:,1) + 1;
degrade_input_pat_3(:,1) = degrade_input_pat_3(:,1) + 1;

cd ..

% Get cosine similarity and correlation coefficient between input and
% output patterns for pattern 1
trainIn1 = zeros(size(SRPyrBinnedTest,1),1);
trainIn1(input_pat_1(:,1)) = input_pat_1(:,2);
trainOut1 = SRPyrBinnedTrain(:,trainPat1);
testIn1 = zeros(size(SRPyrBinnedTest,1),1);
testIn1(degrade_input_pat_1(:,1)) = degrade_input_pat_1(:,2); 
testOut1 = SRPyrBinnedTest(:,testPat1);

trainIn1(trainIn1 > 1) = 1;
testIn1(testIn1 > 1) = 1;
trainOut1(trainOut1 > 1) = 1;
testOut1(testOut1 > 1) = 1;

corrIn1 = corr(trainIn1, testIn1);
corrOut1 = corr(trainOut1,testOut1);
reconstructPat1 = ((corrOut1 - corrIn1)/(1-corrIn1))*100;

% Get cosine similarity and correlation coefficient between input and
% output patterns for pattern 2
trainIn2 = zeros(size(SRPyrBinnedTest,1),1);
trainIn2(input_pat_2(:,1)) = input_pat_2(:,2);
trainOut2 = SRPyrBinnedTrain(:,trainPat2);
testIn2 = zeros(size(SRPyrBinnedTest,1),1);
testIn2(degrade_input_pat_2(:,1)) = degrade_input_pat_2(:,2); 
testOut2 = SRPyrBinnedTest(:,testPat2);

trainIn2(trainIn2 > 1) = 1;
testIn2(testIn2 > 1) = 1;
trainOut2(trainOut2 > 1) = 1;
testOut2(testOut2 > 1) = 1;

corrIn2 = corr(trainIn2, testIn2);
corrOut2 = corr(trainOut2,testOut2);
reconstructPat2 = ((corrOut2 - corrIn2)/(1-corrIn2))*100;

% Get cosine similarity and correlation coefficient between input and
% output patterns for pattern 3
% trainPatCIn3 = [zeros(600,1); input_pat_3(:,2); zeros(size(SRPyrBinnedTest,1)-size(input_pat_3,1)-600,1)];
trainIn3 = zeros(size(SRPyrBinnedTest,1),1);
trainIn3(input_pat_3(:,1)) = input_pat_3(:,2);
trainOut3 = SRPyrBinnedTrain(:,trainPat3);
testIn3 = zeros(size(SRPyrBinnedTest,1),1);
testIn3(degrade_input_pat_3(:,1)) = degrade_input_pat_3(:,2); 
testOut3 = SRPyrBinnedTest(:,testPat3);

trainIn3(trainIn3 > 1) = 1;
testIn3(testIn3 > 1) = 1;
trainOut3(trainOut3 > 1) = 1;
testOut3(testOut3 > 1) = 1;

corrIn3 = corr(trainIn3, testIn3);
corrOut3 = corr(trainOut3,testOut3);
reconstructPat3 = ((corrOut3 - corrIn3)/(1-corrIn3))*100;

% Store the pattern reconstruction accuracies
patternReconstruction = [reconstructPat1 reconstructPat2 reconstructPat3];