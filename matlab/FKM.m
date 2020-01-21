function [Z,e] = FKM(d,k,h)
% This function aims to solve the Fuzzy k-Medoids problem:
% minimize Z = sum{i}sum{j}d{ij}*e{ij}^h
% subject to
% sum{j}e{ij} = 1 for all i
% sum{j}e{jj} = k
% e{ij} <= e{jj} for all i,j
% 0 <= e{ij} <= 1 for all i ~= j
% e{jj} binary for all j

% Inputs:
% d: n x n dissimilarity matrix
% k: number of clusters
% h: membership fuzziness factor

% Outputs:
% Z: solution cost
% e: k x n membership matrix

n = size(d,1);

medoids = randperm(n,k);

uij = zeros(n,k);
dij = d(:,medoids);
if h == 1
    for i = 1:n
        [~,j] = min(dij(i,:));
        uij(i,j) = 1;
    end
else
    for i = 1:n
        soma = 0;
        for j = 1:k
            soma = soma + 1/dij(i,j)^(1/(h-1));
        end
        for j = 1:k
            if dij(i,j) == 0
                uij(i,j) = 1;
            else
                uij(i,j) = 1/(soma*dij(i,j)^(1/(h-1)));
            end
        end
    end
end
Z = sum(sum(dij.*uij.^h));
m_bin = zeros(n,1);
for j = 1:k
    m_bin(medoids(j)) = 1;
end

improved = true;
while improved
    improved = false;
    m = medoids;
    m_bin2 = m_bin;
    for idOut = randperm(k)
        mOut = m(idOut);
        for mIn = 1:n
            if m_bin2(mIn) == 1
                continue;
            end
            m(idOut) = mIn;
            m_bin2(mOut) = 0;
            m_bin2(mIn) = 1;
            dij = d(:,m);
            u2 = zeros(n,k);
            if h == 1
                for i = 1:n
                    [~,j] = min(dij(i,:));
                    u2(i,j) = 1;
                end
            else
                for i = 1:n
                    soma = 0;
                    for j = 1:k
                        soma = soma + 1/dij(i,j)^(1/(h-1));
                    end
                    for j = 1:k
                        if dij(i,j) == 0
                            u2(i,j) = 1;
                        else
                            u2(i,j) = 1/(soma*dij(i,j)^(1/(h-1)));
                        end
                    end
                end
            end
            Z2 = sum(sum(dij.*u2.^h));
            if Z2 < Z
                improved = true;
                medoids = m;
                m_bin = m_bin2;
                Z = Z2;
                uij = u2;
            else
                m = medoids;
                m_bin2 = m_bin;
            end
        end
    end
end
e = zeros(n,n);
e(:,medoids) = uij;
end
