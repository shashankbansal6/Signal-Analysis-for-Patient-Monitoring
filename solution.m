% Load patient_data.mat 
load('patient_data.mat');
labels = {'Heart Rate','Pulse Rate','Respiration Rate'};

% open the result file
% !! replace # with your own groupID
fid = fopen('ECE313_Mini2_group 26', 'w');


% !! Subset your data for each signal
HR = data(1,:);
PR = data(2,:);
X = data(3,:);

% Part a
% !! Plot each signal over time
figure;
subplot(3,1,1);
plot(HR);
title(labels(1));
subplot(3,1,2);
plot(PR);
title(labels(2));
subplot(3,1,3);
plot(X);
title(labels(3));
xlabel('Time(seconds)')


% T1.1
% Part a
% Generating three sample sets of different sizes
sampleset = [70,1000,30000];
for k = 1:3
    % Pick a random sample of size sampleset(k) from the data set  
    % (Without replacement)
    Sample = datasample(X,sampleset(k),'Replace',false);

    % Plot the CDF of the whole data set as the reference (in red color)
    figure;  
    subplot(2,1,1);
    [p, xx] = ecdf(X);
    plot(xx,p);
    hold on;% For the next plots to be on the same figure        
    h = get(gca,'children'); set(h,'LineWidth',2);set(h,'Color','r')
    
    % !! Call the funcion for calculating and ploting pdf and CDF of X     
    
    title(strcat(strcat(char(labels(3)),' - Sample Size = '),char(num2str(sampleset(k)))));
end

% Part b
% !! Use the tabulate function in MATLAB over X and floor(X). 


% % !! Answer the question by filling in the following printf
% fprintf(fid, 'Task 1.1 - Part b\n');
% fprintf(fid, 'Min of tabulate(X) = %f\n', "min_tabulate_X");
% fprintf(fid, 'Max of tabulate(X) = %f\n', "max_tabulate_X");
% fprintf(fid, 'Min of tabulate(floor(X)) = %f\n', "min_tabulate_floor_X");
% fprintf(fid, 'Max of tabulate(floor(X)) = %f\n', "max_tabulate_floor_X");
% fprintf(fid, 'Observed Property of PDF = %s\n\n', "e.g. F(X) is non-decreasing?");
% 
% % Part c
% % !! Using CDF of X, find values a and b such that P(X <= a) <= 0.02 and P(X <= b) >= 0.98.
% 
% a = 
% b = 
% fprintf(fid, 'Task 1.1 - Part c\n');
% fprintf(fid, 'Empirical a = %f\n', "Empirical a");
% fprintf(fid, 'Empirical b = %f\n\n', "Empirical b");
