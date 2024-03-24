% This script will create all figure panels accompanying Figure 3

% Create figure 3 panel a

cd('figure_3_a_data')

assemSize = 275;
createFigure3PanelA(assemSize)

cd ..

% Create figure 3 panel b

cd('figure_3_b_data')

createFigure3PanelB

cd ..

% Create figure 3 panel c and d

cd('figure_3_c_d_data')

assemSize = 275;
activePct = 0.5;
activePC = ceil(assemSize*activePct);

createFigure3PanelC(assemSize,activePC,activePC+assemSize,activePC+2*assemSize,assemSize,assemSize*2,assemSize*3)
createFigure3PanelD(activePC,activePC+assemSize,activePC+2*assemSize,assemSize,assemSize*2,assemSize*3)

cd ..