function plotFKM(e,permutation,names)
% This function plots a FKM solution with indexes sorted by "permutation"

% Inputs:
% e: n x n matrix of memberships
% permutation: indexes permutation
% names: 1 x n cell with label names

e = e(permutation,permutation);
lables = names(permutation);
n = size(e,1);
k = trace(e);
medoids = diag(e)==1;
imagesc(e(:,medoids))
set(gca,'XAxisLocation','top')
set(gca,'Layer','bottom')
set(gcf,'Color','white')
colormap(jet)
set(gca,'YTick',1:size(e,2));
set(gca,'YTickLabel',lables)
drawnow
hold on
for s = 0:n
    plot([0.5;k+0.5],[s+0.5;s+0.5],'k')
end
for j = 0:k
    plot([j+0.5;j+0.5],[0.5;n+0.5],'k')
end
hold off
set(gca,'XTick',1:k);
set(gca,'XTickLabel',lables(medoids))
set(gca,'XTickLabelRotation',90);
colorbar

end