function plotFMMdd(e,v,permutation,names)
% This function plots a FMMdd solution (e,v) with indexes sorted by
% "permutation"

% Inputs:
% e: k x n matrix of memberships
% v: k x n matrix of representativeness
% permutation: indexes permutation
% names: 1 x n cell with label names

e = e(:,permutation)';
v = v(:,permutation)';
lables = names(permutation);
[N,K] = size(e);

[~,column_indexes] = sort(e'*(1:N)');
e = e(:,column_indexes);
v = v(:,column_indexes);

subplot(1,2,1)
imagesc(e)
set(gca,'XAxisLocation','top')
set(gca,'Layer','bottom')
set(gcf,'Color','white')
colormap(jet)
set(gca,'YTick',1:N);
set(gca,'YTickLabel',lables)
drawnow
hold on
for s = 0:N
    plot([0.5;K+0.5],[s+0.5;s+0.5],'k')
end
for j = 0:K
    plot([j+0.5;j+0.5],[0.5;N+0.5],'k')
end
hold off
set(gca,'XTick',1:K);
XTickLabel=cell(1,K);
for x = 1:K
    XTickLabel{x} = ' ';
end
set(gca,'XTickLabel',XTickLabel);
set(gca,'XTickLabelRotation',90);
colorbar

subplot(1,2,2)
imagesc(v)
set(gca,'XAxisLocation','top')
set(gca,'Layer','bottom')
set(gcf,'Color','white')
colormap(jet)

YTick = get(gca,'YTick');
YTickLabel=cell(1,length(YTick));
for y = 1:length(YTick)
    YTickLabel{y} = ' ';
end
set(gca,'YTickLabel',YTickLabel);
drawnow
hold on
for s = 0:N
    plot([0.5;K+0.5],[s+0.5;s+0.5],'k')
end
for j = 0:K
    plot([j+0.5;j+0.5],[0.5;N+0.5],'k')
end
hold off
set(gca,'XTick',1:K);
XTickLabel=cell(1,K);
for x = 1:K
    XTickLabel{x} = ' ';
end
set(gca,'XTickLabel',XTickLabel);
set(gca,'XTickLabelRotation',90);
colorbar

end