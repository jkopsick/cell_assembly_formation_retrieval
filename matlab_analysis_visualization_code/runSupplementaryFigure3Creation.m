% This script will create all figure panels accompanying Supplementary
% Figure 3

% Create Supplementary Figure 3 panel a
assemSize = 75;
activePct = 0.5;
activePC = ceil(assemSize*activePct);

cd('supplementary_figure_3_a_data')

createSupplementaryFigure3(activePC,activePC+assemSize,activePC+2*assemSize,assemSize,assemSize*2,assemSize*3)

cd ..

% Create Supplementary Figure 3 panel b
cd('supplementary_figure_3_b_data')

createSupplementaryFigure3(activePC,activePC+assemSize,activePC+2*assemSize,assemSize,assemSize*2,assemSize*3)

cd ..