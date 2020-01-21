function points_CFKM(x,e)
% This function plots 2D points "x" and a CFKM solution represented by
% lines between points whose intensity is proportional to the assignment

% Inputs:
% x: n x 2 matrix of data points
% e: n x n matrix of memberships

n = size(e,1);
for i = 1:n
    e(i,i) = 0;
end
e = e/max(max(e));
plots = cell(n*n,2);
ee = zeros(n*n,1);
pl = 0;
for i = 1:n
    for j = 1:n
        pl = pl+1;
        plots{pl,1} = x(i,:);
        plots{pl,2} = x(j,:);
        ee(pl) = e(i,j);
    end
end
[ee,ids] = sort(ee);
plots = plots(ids,:);
hold on
for pl = 1:n*n
    if ee(pl)>.05
        plot([plots{pl,1}(1);plots{pl,2}(1)],[plots{pl,1}(2);plots{pl,2}(2)],'Color',[1 1 1]-ee(pl));
    end
end
plot(x(:,1),x(:,2),'.','MarkerSize',10,'Color','black')
hold off
end