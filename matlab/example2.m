clear
clc

rng(100)

%% Load data
load('synthetic.mat')

for s = 1:length(synthetic)
    %% Set the number of clusters and fuzziness and compute the distance matrix
    k = synthetic{s}.k;
    h = 1.5;
    g = 1.1;
    d = pdist2(synthetic{s}.x,synthetic{s}.x).^2;
    
    %% Solve FKM, FMMdd and CFKM
    [Z_fkm,e_fkm] = FKM(d,k,h);
    [Z_fmmdd,e_fmmdd,v_fmmdd] = FMMdd(d,k,h,g);
    [Z_cfkm,e_cfkm] = CFKM(d,k,h);
    
    %% Plot FKM, FMMdd and CFKM solutions
    figure(s)
    
    % Plot actual points and clusters
    subplot(2,2,1)
    colors = lines(synthetic{s}.k);
    hold on
    for c = 1:synthetic{s}.k
        plot(synthetic{s}.x(synthetic{s}.id==c,1),...
            synthetic{s}.x(synthetic{s}.id==c,2),...
            '.','MarkerSize',20,'Color',colors(c,:))
    end
    hold off
    title('Points and clusters')
    drawnow
    
    % Plot FKM solution
    subplot(2,2,2)
    points_FKM(synthetic{s}.x,e_fkm)
    title('FKM')
    drawnow
    
    % Plot FMMdd solution
    subplot(2,2,3)
    points_FMMdd(synthetic{s}.x,e_fmmdd,v_fmmdd)
    title('FMMdd')
    drawnow
    
    % Plot CFKM solution
    subplot(2,2,4)
    points_CFKM(synthetic{s}.x,e_cfkm)
    title('CFKM')
    drawnow
end