% !! Write a funcion for calculating and ploting pdf and CDF of X    

function  pdf_cdf(X)
    % !! Find the possible values of Y
    y = floor(X);
    Y = unique(y);
    
    % !! Calculate the PMF of Y 
    pmf_tab = tabulate(floor(X));
    pmf = pmf_tab(:,3)/100;
        
    
    % !! Bar Plot the PMF of Y
    subplot(2,1,2);
    bar(pmf);
    
    hold on; % For the next plots to be on the same figure
    
    % Plot the estimated PDF of X using Kernel Density Estimation
    % See the following links for more information on kernel density estimation based on data:
    % http://en.wikipedia.org/wiki/Kernel_density_estimation
    % http://www.mathworks.com/help/stats/kernel-distribution.html 
    pd = fitdist(X', 'kernel', 'Kernel', 'box');
    xi = floor(min(X)):1:floor(max(X));
    yi = pdf(pd, xi);
    plot(xi, yi, 'LineWidth', 2, 'Color', 'g');hold on;
    hold on;  % For the next plots to be on the same figure
    
    % !! Calculate and plot CDF of X - First hold on subplot(2,1,1)
    subplot(2,1,1); hold on;
    [pf, xxf] = ecdf(X);
    plot(xxf,pf, 'Color', 'b');
    

    
    
   
    
   