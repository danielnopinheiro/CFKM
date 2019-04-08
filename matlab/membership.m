function [u] = membership(r,v,m,n)
% Usado no FMMdd
[K,N] = size(v);
u = zeros(K,N);
for c = 1:K
    for i = 1:N
        if v(c,i)==1 % se i for uma medoid inteira do cluster c
            u(c,i) = 1;
        else
            u(c,i) = (v(c,:).^n*r(i,:)')^(-1/(m-1))/sum((v.^n*r(i,:)').^(-1/(m-1)));
        end
        if isnan(u(c,i))
            u(c,i) = 1;
        end
    end
end
end