function [v] = prot_weight(d,e,h,g)
% This function computes the optimal representativeness given the
% assignments

% Inputs:
% d: n x n dissimilarity matrix
% u: k x n membership matrix
% h: membership fuzziness factor
% g: representativeness fuzziness degree

% Outputs:
% v: k x n matrix of representativeness

[k,n] = size(e);
v = zeros(k,n);
for c = 1:k
    for j = 1:n
        if isnan((e(c,:).^h*d(:,j))^(-1/(g-1))/sum((e(c,:).^h*d).^(-1/(g-1))))
            warning('0/0 division')
        end
        v(c,j) = (e(c,:).^h*d(:,j))^(-1/(g-1))/sum((e(c,:).^h*d).^(-1/(g-1)));
    end
end
end
