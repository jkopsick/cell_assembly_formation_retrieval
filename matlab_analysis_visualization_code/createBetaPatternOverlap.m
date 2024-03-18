function [uqPat1,uqPat2,uqPat3] = createBetaPatternOverlap(patSize,ovPct)

% Define the # of overlapping neurons
ovN = ceil(patSize*ovPct);
ovN2 = ceil(patSize*ovPct);

% Create assembly 1
p1 = 0:1:patSize-1;
rP11 = p1(randperm(numel(p1)))';
rP12 = p1(randperm(numel(p1)))';
rP13 = p1(randperm(numel(p1)))';
rP14 = p1(randperm(numel(p1)))';
pat1 = [rP11;rP12;rP13;rP14];
writematrix(pat1,'trainPat.csv')
writematrix(unique(pat1),'trainPatUnique.csv')

% Create overlaps between assembly 1 and 2, and between 1 and 3
uqPat1 = unique(pat1);
ov12 = randsample(uqPat1,ovN);
ov13 = randsample(setdiff(uqPat1,ov12),ovN2);

% Create assembly 2
p2 = patSize:1:2*patSize-patSize*ovPct-1;
p2 = [p2 ov12'];
rP21 = p2(randperm(numel(p2)))';
rP22 = p2(randperm(numel(p2)))';
rP23 = p2(randperm(numel(p2)))';
rP24 = p2(randperm(numel(p2)))';
pat2 = [rP21;rP22;rP23;rP24];
writematrix(pat2,'trainPat2.csv')
writematrix(unique(pat2),'trainPat2Unique.csv')

% Create overlap between assembly 2 and 3
uqPat2 = unique(pat2);
ov23 = randsample(setdiff(uqPat2,[ov12 ; ov13]),ovN);

% Create assembly 3
p3 = 2*patSize:1:3*patSize-2*patSize*ovPct-1;
p3 = [p3 ov13' ov23'];
rP31 = p3(randperm(numel(p3)))';
rP32 = p3(randperm(numel(p3)))';
rP33 = p3(randperm(numel(p3)))';
rP34 = p3(randperm(numel(p3)))';
pat3 = [rP31;rP32;rP33;rP34];
uqPat3 = unique(pat3);
writematrix(pat3,'trainPat3.csv')
writematrix(unique(pat3),'trainPat3Unique.csv')

size(uqPat1)
size(uqPat2)
size(uqPat3)

size(intersect(ov12,ov13))
size(intersect(ov12,ov23))
size(intersect(ov13,ov23))