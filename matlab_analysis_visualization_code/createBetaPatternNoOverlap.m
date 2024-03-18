function [] = createBetaPatternNoOverlap(size)
r1 = randperm(size)';
r2 = randperm(size)';
r3 = randperm(size)';
r4 = randperm(size)';
pat1 = [r1;r2;r3;r4];
pat1 = pat1-1;
writematrix(pat1,'trainPat.csv')