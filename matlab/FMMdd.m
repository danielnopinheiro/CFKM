function [Z,e,v] = FMMdd(d,k,h,g)
% This function solves the Fuzzy Clustering with Multi-Medoids problem:
% minimize Z = sum{c}sum{i}sum{j}d{ij}*e{ci}^h*v{cj}^g
% subject to
% sum{c}e{ci} = 1 for all i
% sum{j}v{cj} = 1 for all c
% 0 <= e{ci},v{cj} <= 1 forall c,i,j

% Inputs:
% d: n x n dissimilarity matrix
% k: number of clusters
% h: membership fuzziness factor
% g: representativeness fuzziness degree (optional). If not provided, g=h

% Outputs:
% Z: solution cost
% e: k x n membership matrix
% v: k x n representativeness matrix

if nargin < 4
    g = h;
end

n = size(d,1);
v = zeros(k,n);
for c=1:k
    j = randi(n);
    while sum(v(:,j))==1
        j = randi(n);
    end
    v(c,j) = 1;
end
e = membership(d,v,h,g);

old_u = e;
old_v = v;
while true
    v = prot_weight(d,e,h,g);
    e = membership(d,v,h,g);
    if sum(sum((e-old_u).^2 + (v-old_v).^2)) < 1e-15
        break;
    end
    old_v = v;
    old_u = e;
end

Z = 0;
for c = 1:k
    for i = 1:n
        for j = 1:n
            Z = Z + e(c,i)^h*v(c,j)^g*d(i,j);
        end
    end
end
end
