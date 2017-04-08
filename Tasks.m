%   FILL IN / MODIFY THE CODE WITH "" or comments with !!
close all;
clear all;

% Load patient_data.mat 
load('patient_data.mat');
labels = {'Heart Rate','Pulse Rate','Respiration Rate'};

% open the result file
% !! replace # with your own groupID
fid = fopen('ECE313_Mini2_group26', 'w');

fprintf(fid, 'MiniProject2_Group26\n');
fprintf(fid, 'Shashank Bansal, Ryan  Alvaro, Louis Lu\n\n\n');

% T0
% !! Subset your data for each signal
HR = data(1,:);
PR = data(2,:);
X = data(3,:);
time = (0:1:30000-1);
% Part a
% !! Plot each signal over time
figure;
subplot(3,1,1);
plot(time, HR);
title(labels(1));
subplot(3,1,2);
plot(time, PR);
title(labels(2));
subplot(3,1,3);
plot(time, X);
title(labels(3));
xlabel('Time(seconds)')


% Note that Tasks 1.1 and 1.2 should be done only for the respiration rate signal 
% Tasks 2.1 and 2.2 should be performed using all three signals.
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
    pdf_cdf(Sample);
    
    title(strcat(strcat(char(labels(3)),' - Sample Size = '),char(num2str(sampleset(k)))));
end

fprintf(fid, 'Task 1.1 - Part a\n');
fprintf(fid, '2. The difference between the pmf plotted in part 1 and the estimated pdf is\n');
fprintf(fid, 'that pmf gives discrete probabilities at different values whereas pdf gives the\n');
fprintf(fid, 'probability that the given function falls in the particular interval.\n\n');


fprintf(fid, '3. As the sample size increases from 70 to 30000, the cdf graph becomes more smooth\n'); 
fprintf(fid, 'and regular.\n\n');

%
% Part b
% !! Use the tabulate function in MATLAB over X and floor(X). 
tab_X = tabulate(X);
tab_Y = tabulate(floor(X));


% !! Answer the question by filling in the following printf
fprintf(fid, 'Task 1.1 - Part b\n');
fprintf(fid, '1. Tabulate(X) gives a pdf while the other gives a pmf because:\n');
fprintf(fid, 'each value in the X is unique so tabulate(X) gives the same value throughout the interval\n');
fprintf(fid, 'whereas using floor gives an integer count between the discreet intervals and thus each interval.\n');
fprintf(fid, 'has a different probability which is the pmf of the function.\n\n');
fprintf(fid, '2. The difference for the derived min and max for each distribution is shown below\n');
fprintf(fid, 'Min of tabulate(X) = %f\n', min(tab_X(:,3)));
fprintf(fid, 'Max of tabulate(X) = %f\n', max(tab_X(:,3)));
fprintf(fid, 'Min of tabulate(floor(X)) = %f\n', min(tab_Y(:,3)));
fprintf(fid, 'Max of tabulate(floor(X)) = %f\n', max(tab_Y(:,3)));
fprintf(fid, 'Observed Property of PDF = %s\n\n', 'PDFs involve continuous RVs, and the probability of any single possible value is 0');

% Part c
% !! Using CDF of X, find values a and b such that P(X <= a) <= 0.02 and P(X <= b) >= 0.98.

a = find(p <= 0.02, 1, 'last');
b = find(p >= 0.98, 1, 'first');
fprintf(fid, 'Task 1.1 - Part c\n');
fprintf(fid, 'Empirical a = %f\n', xx(a));
fprintf(fid, 'Empirical b = %f\n\n', xx(b));

% Task 1.2;

% Part a
% !! Calculate mean of the signal

fprintf(fid, 'Task 1.2 - Part a\n');
fprintf(fid, 'Mean RESP = %f\n\n', mean(X));
% !! Calculate standard deviation of the signal

fprintf(fid, 'Standard Deviation RESP = %f\n\n', std(X));

% Part b
% !! Generate a normal random variable with the same mean & standard deviation 
R = normrnd(mean(X), std(X), 1, 30000);

% !! Plot pdf and CDF of the generated random variable using pdf_cdf function
figure;
pdf_cdf(R)
title(strcat(char(labels(3)),' Normal Approximation'));




% Part c
figure;
title(strcat(char(labels(3)),' Normplot'));
% !! Use normplot function to estimate the difference between distributions
normplot(X);

[p2, xx2] = ecdf(R);
a2 = find(p2 <= 0.02, 1, 'last');
b2 = find(p2 >= 0.98, 1, 'first');
    
fprintf(fid, 'Task 1.2 - Part c\n');
fprintf(fid, 'The distribution generated in this task is positive skewed that is\n');
fprintf(fid, 'the right tail is slightly longer and the mass distribution is concentrated on the\n');
fprintf(fid, 'left of the figure.\n\n\n');

% Part d
% !! Show your work in the report, then plug in the numbers that you calculated here
fprintf(fid, 'Task 1.2 - Part d\n');
fprintf(fid, 'Theoretical a = %f\n', xx2(a2));
fprintf(fid, 'Theoretical b = %f\n\n', xx2(b2));

fprintf(fid, 'The values of a and b in task 1 are less than the values in task 1.2.\n');



%Task 2.1;
%Tasks 2.1 and 2.2 should be done twice, 
%once with the empirical threshold, and once with the theoretical threshold
%!! Change the code to do this.

%Part a
%!! Call the threshold function and generate alarms for each signal

alarms_HR_Emp = threshold(HR, 80.17, 98.52);
alarms_PR_Emp = threshold(PR, 79.00, 97.07);
alarms_RR_Emp = threshold(X, xx(a), xx(b));

%Parts b and c
%!! Write the code for coalescing alarms and majority voting here 
count1 = 0;
count2 = 0;
count3 = 0;
k = 1;
coal_HR_emp = [];
coal_PR_emp = [];
coal_RR_emp = [];
votes = [];
votes_temp = zeros(1, 3);
for i = 1:10:30000
    for j = 1:10
        if alarms_HR_Emp(k) == 1
            count1 = count1 + 1;
        end
        if alarms_PR_Emp(k) == 1
            count2 = count2 + 1;
        end
        if alarms_RR_Emp(k) == 1
            count3 = count3 + 1;
        end
        k = k + 1;
    end
    if count1 > 0
        coal_HR_emp(end+1) = 1;
    else coal_HR_emp(end+1) = 0;
    end
    
    if count2 > 0
        coal_PR_emp(end+1) = 1;
    else coal_PR_emp(end+1) = 0;
    end
    
    if count3 > 0
        coal_RR_emp(end+1) = 1;
    else coal_RR_emp(end+1) = 0;
    end
    count1 = 0;
    count2 = 0;
    count3 = 0;
    votes_temp(1) = coal_HR_emp(end);
    votes_temp(2) = coal_PR_emp(end);
    votes_temp(3) = coal_RR_emp(end);
    if sum(votes_temp) > 1
    votes(end+1) = 1;
    else votes(end + 1) = 0;
    end
end



%Part d
%!! Fill in the bar functions with the name of vectors storing your alarms
figure;
subplot(5,1,1);
bar(coal_HR_emp);
title(strcat(char(labels(1)),' Alarms'));
subplot(5,1,2);
bar(coal_PR_emp);
title(strcat(char(labels(2)),' Alarms'));
subplot(5,1,3);
bar(coal_RR_emp);
title(strcat(char(labels(3)),' Alarms'));
subplot(5,1,4);
bar(votes);
title('Majority Voter Alarms - Empirical Thresholds');
subplot(5,1,5);
title('Golden Alarms');
bar(golden_alarms,'r');

% Task 2.2;
%Parts a and b
%!! Write the code to calculate the probabilities of:
%false alarm, miss detection and error 

tab_golden = tabulate(golden_alarms);
prob_no_abnormality = tab_golden(1,3)/100;

%this counts the value of voter raises and alarm and physician indicates
%no abnormality and the value of voter raises no alarm and Physician
%indicates no abnormality

count_false = 0;
count_miss = 0;
for i = 1:3000
    if votes(i) == 1 && golden_alarms(i) == 0
        count_false = count_false + 1;
    end
    
    if votes(i) == 0 && golden_alarms(i) == 1
        count_miss = count_miss + 1;
    end
end

%using the counts above, we calculate the probability of the false alarms,
%the probability of missed detections and the probability of error

prob_voter_no_abnormality = count_false/length(votes);
prob_false_alarm = prob_voter_no_abnormality/prob_no_abnormality;
prob_miss_detection = (count_miss/length(votes))/(1 - prob_no_abnormality);
prob_error = prob_voter_no_abnormality + (count_miss/length(votes));


fprintf(fid, 'Task 2.2 - Parts a and b\n');
fprintf(fid, 'Using Empirical Thresholds:\n');
fprintf(fid, 'Probability of False Alarm    = %f\n', prob_false_alarm);
fprintf(fid, 'Probability of Miss Detection = %f\n', prob_miss_detection);
fprintf(fid, 'Probability of Error          = %f\n\n', prob_error);

% Part c
% !! Repeat Tasks 2.1 and 2.2 with Theoretical thresholds

alarms_HR_Th = threshold(HR, 78.84, 96.83);
alarms_PR_Th = threshold(PR, 78.15, 96.09);
alarms_RR_Th = threshold(X, xx2(a2), xx2(b2));


count1 = 0;
count2 = 0;
count3 = 0;
k = 1;
coal_HR_th = [];
coal_PR_th = [];
coal_RR_th = [];
votes_th = [];
votes_temp_th = zeros(1, 3);
for i = 1:10:30000
    for j = 1:10
        if alarms_HR_Th(k) == 1
            count1 = count1 + 1;
        end
        
        if alarms_PR_Th(k) == 1
            count2 = count2 + 1;
        end
        
        if alarms_RR_Th(k) == 1
            count3 = count3 + 1;
        end
        
        k = k + 1;
    end
    if count1 > 0
        coal_HR_th(end+1) = 1;
    else coal_HR_th(end+1) = 0;
    end
    
    if count2 > 0
        coal_PR_th(end+1) = 1;
    else coal_PR_th(end+1) = 0;
    end
    
    if count3 > 0
        coal_RR_th(end+1) = 1;
    else coal_RR_th(end+1) = 0;
    end
    count1 = 0;
    count2 = 0;
    count3 = 0;
    votes_temp_th(1) = coal_HR_th(end);
    votes_temp_th(2) = coal_PR_th(end);
    votes_temp_th(3) = coal_RR_th(end);
    if sum(votes_temp_th) > 1
    votes_th(end+1) = 1;
    else votes_th(end + 1) = 0;
    end
end

figure;
subplot(5,1,1);
bar(coal_HR_th);
title(strcat(char(labels(1)),' Alarms'));
subplot(5,1,2);
bar(coal_PR_th);
title(strcat(char(labels(2)),' Alarms'));
subplot(5,1,3);
bar(coal_RR_th);
title(strcat(char(labels(3)),' Alarms'));
subplot(5,1,4);
bar(votes_th);
title('Majority Voter Alarms - Theoretical Thresholds');
subplot(5,1,5);
title('Golden Alarms');
bar(golden_alarms,'r');


count_false = 0;
count_miss = 0;
for i = 1:3000
    if votes_th(i) == 1 && golden_alarms(i) == 0
        count_false = count_false + 1;
    end
    
    if votes_th(i) == 0 && golden_alarms(i) == 1
        count_miss = count_miss + 1;
    end
end


%using the counts above, we calculate the probability of the false alarms,
%the probability of missed detections and the probability of error

prob_voter_no_abnormality_th = count_false/length(votes_th);
prob_false_alarm_th = prob_voter_no_abnormality_th/prob_no_abnormality;
prob_miss_detection_th = (count_miss/length(votes_th))/(1 - prob_no_abnormality);
prob_error_th = prob_voter_no_abnormality_th + (count_miss/length(votes_th));

fprintf(fid, 'Task 2.2 - Part c\n');
fprintf(fid, 'Using Theoretical Thresholds:\n');
fprintf(fid, 'Probability of False Alarm    = %f\n', prob_false_alarm_th);
fprintf(fid, 'Probability of Miss Detection = %f\n', prob_miss_detection_th);
fprintf(fid, 'Probability Error             = %f\n\n', prob_error_th);
fprintf(fid, 'The probability of False Alarm and Probability of Error went down using theoretical thresholds.\n');
fprintf(fid, 'The probability of miss detection is the same\n\n');
fprintf(fid, 'We learned that empirical thresholds are a bit higher than the theoretical thresholds, for all three cases.\n');
fprintf(fid, 'And empirical results and theoretical results have the same miss detection probability.\n\n');

%% Task 3

% Prob. of error from the testing process of each fold
nFold_p_error = [];         
% Prob. of false positives from the testing process of each fold
nFold_p_fp = [];        
% Prob. of miss detection from the testing process of each fold
nFold_p_md = [];        


% Part a.1: Divide the data into three subsets of equal length
d1 = data(:,1:10000);
d2 = data(:,10001:20000);
d3 = data(:,20001:30000);

% Part a.2: Divide the golden_alarms into three subsets of equal length
g1 = golden_alarms(:,1:1000);
g2 = golden_alarms(:,1001:2000);
g3 = golden_alarms(:,2001:3000);
g = [];

for i = 1:3
    % Hint: z = [x y]; merges the two datasets x and y
    
    if i == 1
    trainData = [d2 d3];
    testData = d1;
    tab_golden_T = tabulate(g1);
    g = g1;
    
    elseif i == 2
        trainData = [d1 d3];
        testData = d2;
        tab_golden_T = tabulate(g2);
        g = g2;
    else 
        trainData = [d1 d2];
        testData = d3;
        tab_golden_T = tabulate(g3);
        g = g3;
    end

    train_data_R = trainData(3,:);
    
    % Part b: Train the decision model using trainData
    [p, xx] = ecdf(train_data_R);

training_a = xx(find(p <= 0.02, 1, 'last'));
training_b = xx(find(p >= 0.98, 1, 'first'));

    % Part c: Test the decision model using testData
    
alarms_HR_Emp_T = threshold(testData(1,:), 80.17, 98.52);
alarms_PR_Emp_T = threshold(testData(2,:), 79.00, 97.07);
alarms_RR_Emp_T = threshold(testData(3,:), training_a, training_b);

count1 = 0;
count2 = 0;
count3 = 0;
k = 1;
coal_HR_emp_T = [];
coal_PR_emp_T = [];
coal_RR_emp_T = [];
votes_T = [];
votes_temp = zeros(1, 3);
  for m = 1:10:10000
    for j = 1:10
        if alarms_HR_Emp_T(k) == 1
            count1 = count1 + 1;
        end
        if alarms_PR_Emp_T(k) == 1
            count2 = count2 + 1;
        end
        if alarms_RR_Emp_T(k) == 1
            count3 = count3 + 1;
        end
        k = k + 1;
    end
    
    if count1 > 0
        coal_HR_emp_T(end+1) = 1;
    else coal_HR_emp_T(end+1) = 0;
    end
    
    if count2 > 0
        coal_PR_emp_T(end+1) = 1;
    else coal_PR_emp_T(end+1) = 0;
    end
    
    if count3 > 0
        coal_RR_emp_T(end+1) = 1;
    else coal_RR_emp_T(end+1) = 0;
    end
    
    count1 = 0;
    count2 = 0;
    count3 = 0;
    votes_temp(1) = coal_HR_emp_T(end);
    votes_temp(2) = coal_PR_emp_T(end);
    votes_temp(3) = coal_RR_emp_T(end);
    if sum(votes_temp) > 1
    votes_T(end+1) = 1;
    else votes_T(end + 1) = 0;
    end
  end
  
prob_no_abnormality_T = tab_golden_T(1,3)/100;

count_false_T = 0;
count_miss_T = 0;
for n = 1:1000
    if votes_T(n) == 1 && g(n) == 0
        count_false_T = count_false_T + 1;
    end
    
    if votes_T(n) == 0 && g(n) == 1
        count_miss_T = count_miss_T + 1;
    end
end

prob_voter_no_abnormality_T = count_false_T/length(votes_T);
prob_false_alarm_T = prob_voter_no_abnormality_T/prob_no_abnormality_T;
prob_miss_detection_T = (count_miss_T/length(votes_T))/(1 - prob_no_abnormality_T);
prob_error_T = prob_voter_no_abnormality_T + (count_miss_T/length(votes_T));

nFold_p_error(end+1) = prob_error_T;         
% Prob. of false positives from the testing process of each fold
nFold_p_fp(end+1) = prob_false_alarm_T;        
% Prob. of miss detection from the testing process of each fold
nFold_p_md(end+1) = prob_miss_detection_T;    
end

% Find the mean of the the performances from the 3-fold analysis
% Hint: mean(x) provides the mean of elements in array x


fprintf(fid, 'Task 3\n');
fprintf(fid, 'Mean Probability of False Alarm = %f\n', mean(nFold_p_fp));
fprintf(fid, 'Mean Probability of Miss Detection = %f\n', (nFold_p_md(3))/2);
fprintf(fid, 'Mean Probability of Error = %f\n', mean(nFold_p_error));
fprintf(fid, 'The average of false alarm probability and error probability all went up (roughly doubled)\n');
fprintf(fid, 'While the probability of miss dections is lowered\n');

fclose(fid);