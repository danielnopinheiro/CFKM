function [u] = membership(d,v,h,g)
% This function computes the optimal assignments given the
% representativeness

% Inputs:
% d: n x n dissimilarity matrix
% v: k x n matrix of representativeness
% h: membership fuzziness factor
% g: representativeness fuzziness degree

% Outputs:
% u: k x n membership matrix

[k,n] = size(v);
u = zeros(k,n);
for c = 1:k
    for i = 1:n
        if v(c,i)==1
            u(c,i) = 1;
        else
            u(c,i) = (v(c,:).^g*d(i,:)')^(-1/(h-1))/sum((v.^g*d(i,:)').^(-1/(h-1)));
        end
        if isnan(u(c,i))
            u(c,i) = 1;
        end
    end
end
end