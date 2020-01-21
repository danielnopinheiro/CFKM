function points_FKM(x,e)
% This function plots 2D points "x" and a FKM solution represented by lines
% between points whose intensity is proportional to the assignment

% Inputs:
% x: n x 2 matrix of data points
% e: n x n matrix of memberships

medoids = [];
for i = 1:size(x,1)
    if e(i,i)==1
        medoids = [medoids,i];
    end
end
u = e(:,medoids);
[n,k] = size(u);
for c = 1:k
    u(medoids(c),c) = 0;
end
u = u/max(max(u));
plots = cell(n*k,2);
uu = zeros(n*k,1);
pl = 0;
for i = 1:n
    for c = 1:k
        pl = pl+1;
        plots{pl,1} = x(i,:);
        plots{pl,2} = x(medoids(c),:);
        uu(pl) = u(i,c);
    end
end
[uu,ids] = sort(uu);
plots = plots(ids,:);
hold on
for pl = 1:n*k
    if uu(pl)>.05
        plot([plots{pl,1}(1);plots{pl,2}(1)],[plots{pl,1}(2);plots{pl,2}(2)],'Color',[1 1 1]-uu(pl));
    end
end
plot(x(:,1),x(:,2),'.','MarkerSize',10,'Color','black')
hold off
end