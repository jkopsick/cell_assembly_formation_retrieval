% This script will create all figure panels accompanying Figure 2

% Create Figure 2 panel a
assemSize = 275;
activePct = 1.0;
activePC = ceil(assemSize*activePct);

cd('figure_2_a_c_data')

createFigure2Panels(activePC,activePC+assemSize,activePC+2*assemSize,assemSize,assemSize*2,assemSize*3,"a")

cd ..

% Create Figure 2 panel b
assemSize = 275;
activePct = 0.5;
activePC = ceil(assemSize*activePct);

cd('figure_2_b_d_data')

createFigure2Panels(activePC,activePC+assemSize,activePC+2*assemSize,assemSize,assemSize*2,assemSize*3,"b")

cd ..

% Create Figure 2 panel c
assemSize = 275;
activePct = 1.0;
activePC = ceil(assemSize*activePct);

cd('figure_2_a_c_data')

createFigure2Panels(activePC,activePC+assemSize,activePC+2*assemSize,assemSize,assemSize*2,assemSize*3,"c")

cd ..

% Create Figure 2 panel d
assemSize = 275;
activePct = 0.5;
activePC = ceil(assemSize*activePct);

cd('figure_2_b_d_data')

createFigure2Panels(activePC,activePC+assemSize,activePC+2*assemSize,assemSize,assemSize*2,assemSize*3,"d")

cd ..


