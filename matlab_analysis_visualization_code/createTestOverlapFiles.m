function [] = createTestOverlapFiles(fileNames)

% Declare variables for the # of patterns, the pattern size, and variables
% for the network structure to be read in and the readout of the input
% pattern files

pat_1 = readmatrix(fileNames(1));
pat_1 = pat_1(:,1);

pat_2 = readmatrix(fileNames(2));
pat_2 = pat_2(:,1);

pat_3 = readmatrix(fileNames(3));
pat_3 = pat_3(:,1);

patSize = size(pat_1,1);

ov12 = intersect(pat_1,pat_2);
ov13 = intersect(pat_1,pat_3);
ov23 = intersect(pat_2,pat_3);

writematrix(setdiff(pat_1,[ov12;ov13;ov23]),'nonOverlapAssem1.csv')
writematrix(setdiff(pat_2,[ov12;ov13;ov23]),'nonOverlapAssem2.csv')
writematrix(setdiff(pat_3,[ov12;ov13;ov23]),'nonOverlapAssem3.csv')

writematrix(ov12,'overlap12.csv')
writematrix(ov13,'overlap13.csv')
writematrix(ov23,'overlap23.csv')