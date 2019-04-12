function plotMatrix(matrix,permutation,names,showGrid)
% This function plots "matrix" with indexes sorted by "permutation"

% Inputs:
% matrix: N x N matrix displayed
% permutation: indexes permutation
% names: 1 x N cell with label names (optional)
% showGrid: toggles grid on/off (logical, optional)

if nargin == 4
    names = names(permutation);
elseif nargin == 3
    names = names(permutation);
    showGrid = true;
elseif nargin == 2
    showGrid = false;
end
matrix = matrix(permutation,permutation);
imagesc(matrix)
set(gca,'XAxisLocation','top')
set(gca,'Layer','bottom')
set(gcf,'Color','white')
colormap(jet)
if nargin > 2
    set(gca,'YTick',1:size(matrix,2));
    set(gca,'YTickLabel',names)
    set(gca,'XTick',1:size(matrix,1))
    set(gca,'XTickLabel',names)
    set(gca,'XTickLabelRotation',90);
end
if showGrid
    hold on
    J = size(matrix,1);
    for s = 0:J
        plot([0.5;J+0.5],[s+0.5;s+0.5],'k')
        plot([s+0.5;s+0.5],[0.5;J+0.5],'k')
    end
    colorbar
    hold off
end
end