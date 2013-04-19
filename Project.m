clear;
clc
close all;

load 'RamanPNdata_OO.mat';

time_bin = 500; %ms, 8000/time_bin will give the number of windows

%calculate baseline firing rate from from 2000ms average firing rate
base_rate = zeros(116,1);
for i = 1:116 %each neuron
    sum_base_AP = 0; %each neuron's total AP number within time_bin of 30 trials
    for j = 1:30 %each trail
        a = PNOO{i}(:,j);
        sum_base_AP = sum_base_AP + sum(a(1:2000));
    end
    base_rate(i) = sum_base_AP / 60000; %baseline firing rate before stimulus, AP/ms
end

%stimulus starts from 2000ms and ends at 6000ms
%collect AP data from 2000ms to 10000ms
%time_bin

window_number = (10000-2000)/time_bin;
fire_rate = zeros(116,window_number); %for one trial
fire_rate_trial = cell(1,20);

for j = 1:20 %each trail of odor 1 and 2
    for i = 1:116 %each neuron
        a = PNOO{i}(:,j);
        for p = 1:window_number
            sum_AP = sum(a((p*time_bin-(time_bin-1)):p*time_bin));
            fire_rate(i,p) = sum_AP / time_bin - base_rate(i); %substract from baseline,AP/ms
            
        end
        sum_AP = 0;
    end
    fire_rate_trial{j} = fire_rate;
end

x1 = ones(10,16*116+1);
for j = 1:10
    for p = 1:16
        x1 (j,(116*p-115):116*p) = fire_rate_trial{j}(:,p)';
    end
end

x2 = ones(10,16*116+1);
for j = 1:10
    for p = 1:16
        x2 (j,(116*p-115):116*p) = fire_rate_trial{j+10}(:,p)';
    end
end

x_n = [x1(1:9,:);-x2(1:9,:)];

%perceptron training
iteration = 5000;
eta = 0.15;
a = rand(size(x1,2),1); %weight for each input

for t = 1:iteration
    
    [a, miss] = batch_perceptron(x_n,a,eta);
    
    if isempty (miss);
        success = t;
        break;
    end
end
x_n_test = zeros(2,16*116+1);
x_n_test = [x1(10,:);-x2(10,:)];
y_test = x_n_test * a;