function points_FMMdd(x,e,v)
% This function plots 2D points "x" and a FMMdd solution represented by
% lines between points whose intensity is proportional to the assignment
% and representativeness

% Inputs:
% x: n x 2 matrix of data points
% e: k x n matrix of memberships
% v: k x n matrix of representativeness

e = e';
v = v';
n = size(e,1);
plots = cell(n*n,2);
uv = zeros(n*n,1);
pl = 0;
for i = 1:n
    for j = 1:n
        pl = pl+1;
        plots{pl,1} = x(i,:);
        plots{pl,2} = x(j,:);
        uv(pl) = e(i,:)*v(j,:)';
    end
end
uv = uv/max(uv);
[uv,ids] = sort(uv);
plots = plots(ids,:);
plots = plots(uv>.05,:);
uv = uv(uv>.05);
hold on
for pl = 1:length(uv)
    plot([plots{pl,1}(1);plots{pl,2}(1)],[plots{pl,1}(2);plots{pl,2}(2)],'Color',1-[1 1 1]*uv(pl));
end
plot(x(:,1),x(:,2),'.','MarkerSize',10,'Color','black')
hold off
end