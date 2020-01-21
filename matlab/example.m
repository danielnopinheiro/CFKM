clear
clc

rng(100)

%% Load data and set the number of clusters and fuzziness
foods = load('foods.mat');
k = 5;
h = 1.5;

%% Solve FKM, FMMdd and CFKM
[Z_fkm,e_fkm] = FKM(foods.d,k,h);
[Z_fmmdd,e_fmmdd,v_fmmdd] = FMMdd(foods.d,k,h);
[Z_cfkm,e_cfkm] = CFKM(foods.d,k,h);

%% Sort indexes and plot CFKM solution
time = 2*60;
permutation = MinWLA(e_cfkm,false,true,foods.names,time);
% plotMatrix(e_cfkm,permutation,foods.names)

%% Plot FKM and FMMdd solutions
figure(2)
plotFKM(e_fkm,permutation,foods.names)
drawnow
figure(3)
plotFMMdd(e_fmmdd,v_fmmdd,permutation,foods.names)
drawnow
