function [v] = prot_weight(r,u,m,n)
% Usado no FMMdd
[K,N] = size(u);
v = zeros(K,N);
for c = 1:K
    for j = 1:N
        if isnan((u(c,:).^m*r(:,j))^(-1/(n-1))/sum((u(c,:).^m*r).^(-1/(n-1))))
            disp('opa')
        end
        v(c,j) = (u(c,:).^m*r(:,j))^(-1/(n-1))/sum((u(c,:).^m*r).^(-1/(n-1)));
    end
end
end