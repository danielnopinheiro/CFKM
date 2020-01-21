function [Z,e] = CFKM(d,k,h,e0,precision)
% This function solves the Convex Fuzzy k-Medoids problem:
% minimize Z = sum{i}sum{j}d{ij}*e{ij}^h
% subject to
% sum{j}e{ij} = 1 for all i
% sum{j}e{jj} = k
% e{ij} <= e{jj} for all i,j
% 0 <= e{ij} <= 1 for all i,j

% Inputs:
% d: n x n dissimilarity matrix
% k: number of clusters
% h: fuzziness factor
% e0: n x n matrix with an initial solution (optional)
% precision: fmincon's step tolerance (optional, default is 1e-6)

% Outputs:
% Z: solution cost
% e: n x n membership matrix

% We use fmincon to solve problems like:
% minimize f(x)
% subject to
% A*x <= b
% Aeq*x = beq
% lb <= x <= ub

n = size(d,1);

Aeq = zeros(n+1,n*n);
beq = zeros(n+1,1);
A = zeros(n*n,n*n);
b = zeros(n*n,1);

if nargin < 5
    precision = 1e-6;
end

if nargin < 4 || isempty(e0)
    e0 = zeros(n,n)+(1-k/n)/(n-1);
    e0 = e0 - diag(diag(e0)) + diag(ones(1,n)*k/n);
    e0 = reshape(e0',[n*n,1]);
else
    e0 = reshape(e0',[n*n,1]);
end

% Constraint  #1: sum{j}e{ij} = 1 for all i
for i=1:n
    for j=1:n
        Aeq(i,j+n*(i-1)) = 1;
    end
    beq(i) = 1;
end

% Constraint #2: sum{j}e{jj} = k
for j=1:n
    Aeq(n+1,j+n*(j-1)) = 1;
end
beq(n+1) = k;

% Constraint #3: e{ij} - e{jj} <= 0 for all i,j
for i=1:n
    for j=1:n
        if i ~= j
            A(j+n*(i-1),j+n*(i-1)) = 1;
            A(j+n*(i-1),j+n*(j-1)) = -1;
        else
            A(j+n*(i-1),j+n*(i-1)) = 0;
        end
        b(j+n*(i-1)) = 0;
    end
end

% Lower and upper bounds
lb = zeros(n*n,1);
ub = ones(n*n,1);

options = optimoptions('fmincon');
options = optimoptions(options,'Display','iter-detailed','UseParallel',...
    'never','GradObj','on','Algorithm','interior-point','Hessian',...
    'user-supplied','MaxFunEvals',inf,'MaxIter',inf,'TolX',precision,...
    'TolFun',0,'TolCon',0);

coef = zeros(1,n*n);
for i = 1:n
    for j = 1:n
        coef(j+n*(i-1)) = d(i,j);
    end
end
obj_func = @(e)fun_e_grad(e,coef,h);

if h == 1
    hess = @(x,l)zeros(length(x));
else
    hess = @(x,l)h*(h-1)*diag((coef').*(x.^(h-2)));
end
options = optimoptions(options,'HessFcn',hess);

[e0,Z] = fmincon(obj_func,e0,A,b,Aeq,beq,lb,ub,[],options);

e = zeros(n,n);
for i = 1:n
    for j = 1:n
        e(i,j) = e0(j+n*(i-1));
    end
end

end