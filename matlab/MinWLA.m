function [bestBestPerm,bestBestCost] = MinWLA(matrix,showCosts,showImages,names,maxTime)
% This function aims to solve the Minimum Weighted Linear Arrangement
% problem, which sorts the indexes of "matrix" so that the elements with
% higher values get close to the diagonal

% Inputs:
% matrix: N x N matrix to be sorted
% showCosts: toggles on/off the display of costs at each iteration
% (logical)
% showImages: toggles on/off the display of images at each iteration
% (logical)
% names: 1 x N cell with label names
% maxTime: maximum time in seconds

% Outputs:
% bestBestPerm: best index permutation found
% bestBestCost: solution cost

N = size(matrix,1);

permutation = randperm(N);

bestBestCost = getCost(matrix,permutation);
bestBestPerm = permutation;

stepMax = round(N/4);

if nargin < 4
    names = 1:N;
end

if nargin < 5
    maxTime = 5*60; % default 5 minutes
end

start = tic;
shakingStep = 1;
while toc(start) < maxTime
    permutation = bestBestPerm;
    for shake = 1:shakingStep
        itemCosts = zeros(N,1);
        mat = matrix(permutation,permutation);
        for n = 1:N
            for m = 1:N
                itemCosts(n) = itemCosts(n) + abs(n-m)*(mat(n,m)+mat(m,n))^2;
            end
        end
        id1 = roulette(itemCosts);
        id2 = roulette(itemCosts);
        while id1==id2
            id2 = roulette(itemCosts);
        end
        tmp = permutation(id1);
        permutation(id1) = permutation(id2);
        permutation(id2) = tmp;
    end
    
    bestCost = getCost(matrix,permutation);
    bestPermutation = permutation;
    
    step = 1;
    while step < N
        improved = false;
        for n = randperm(N)
            permutation = move(bestPermutation,n,step);
            cost = getCost(matrix,permutation);
            if cost < bestCost
                improved = true;
                break;
            end
            permutation = move(bestPermutation,n,-step);
            cost = getCost(matrix,permutation);
            if cost < bestCost
                improved = true;
                break;
            end
        end
        if improved
            bestCost = cost;
            bestPermutation = permutation;
            step = 1;
            if showCosts
                if bestCost < bestBestCost
                    disp(bestCost)
                end
            end
            if showImages
                if bestCost < bestBestCost
                    plotMatrix(matrix,bestPermutation,names,false);
                    drawnow
                end
            end
        else
            step = step + 1;
        end
    end
    
    if bestCost < bestBestCost
        shakingStep = 1;
        bestBestCost = bestCost;
        bestBestPerm = bestPermutation;
    else
        shakingStep = mod(shakingStep,stepMax)+1;
    end
end

if showImages
    plotMatrix(matrix,bestBestPerm,names,true);
    drawnow
end
end

function cost = getCost(matrix,permutation)
m = matrix(permutation,permutation);
cost = 0;
t = size(m,1);
for a = 1:t
    for b = 1:t
        cost = cost + abs(a-b)*m(a,b)^2;
    end
end
end

function newperm = move(perm,i,passo)
newperm = perm;
N = length(newperm);
v = newperm(i);
if passo >= 0
    for j = 1:passo
        newperm(mod(i+j-2,N)+1) = newperm(mod(i+j-1,N)+1);
    end
    newperm(mod(i+passo-1,N)+1) = v;
else
    passo = -passo;
    for j = 1:passo
        newperm(mod(i-j,N)+1) = newperm(mod(i-j-1,N)+1);
    end
    newperm(mod(i-passo-1,N)+1) = v;
end
end