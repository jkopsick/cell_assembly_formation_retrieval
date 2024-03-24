% Plot domain and range of Pattern Reconstruction in 2D, with Rin on x and
% Rout on y
fh = figure; clf;
[X,Y] = meshgrid(0:0.001:1,0:0.001:1);
Z = (Y-X)./(1-X);
Z(Z<=0)=0;
x = X(1,:) ;
y = Y(:,1) ;
imagesc('XData',x,'YData',y,'CData',Z)
fh.WindowState = 'maximized';
xlabel('R_{In}')
ylabel('R_{Out}')
zlabel('Pattern Reconstruction')
xlim([-0.0025 1])
ylim([-0.005 1])
xticks([0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1])
yticks([0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1])
ax = gca;
ax.LineWidth = 5;
box off;
ax.TickDir = 'out';
ax.FontSize = 25;
a = colorbar;
a.TickDirection = 'out';
a.LineWidth = 5;
a.Label.String = 'Reconstruction';

