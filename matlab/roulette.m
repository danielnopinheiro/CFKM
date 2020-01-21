function [id] = roulette(weights)
% This function returns an index randomly with probability weighted by
% "weights"

weights = weights/sum(weights);
v=rand();
n = length(weights);
if weights(1)>=v
    id = 1;
    return;
end
for i = 2:n
    weights(i)=weights(i)+weights(i-1);
    if weights(i)>=v
        id = i;
        return;
    end
end
end