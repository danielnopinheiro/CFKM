function [Z,g] = fun_e_grad(e,coef,h)
% This function returns the cost and gradient of a given CFKM solution

% Inputs:
% e: column vector of a reshaped membership matrix
% coef: row vector of a reshaped dissimilarity matrix
% h: fuzziness factor

% Outputs:
% Z: solution cost
% g: solution gradient

Z=coef*(e.^h);
if nargout==2
    g=h*coef'.*(e.^(h-1));
end

end