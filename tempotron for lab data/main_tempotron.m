function main_tempotron
close all;
clear;
clc;

% label = 'AP';
label = 'OO';

%load and preprocess data
if strcmp(label, 'AP')
    load RamanPNdata_AP;
    dataset = PNAP;
    t0 = 15001;
elseif strcmp(label, 'OO')
    load RamanPNdata_OO;
    dataset = PNOO;
    t0 = 2001;  
end

Nneuron = size(dataset, 2);
twin = 8000;
duration = 8000;
ntbin = duration/twin;
data = cell(1,30);

for j = 1:30
	stdata = [];
	for i = 1:Nneuron
		if i == 20 && strcmp(label, 'AP'), continue, end;
		sndata = reshape(dataset{i}(t0:t0-1+duration, j), twin, ntbin)';
		stdata = [stdata; sndata];
	end
	data{1,j} = stdata;
end

Ntest = 1;
testsize = 1;
result = zeros(Ntest, 1);

for i = 1:Ntest
	ind1 = randperm(10);
	indtest1 = ind1(1:testsize);
	indtrain1 = ind1((testsize+1):end);
	ind2 = randperm(10);
	indtest2 = ind2(1:testsize) + 10;
	indtrain2 = ind2((testsize+1):end) + 10;
	ind3 = randperm(10);
	indtest3 = ind3(1:testsize) + 20;
	indtrain3 = ind3((testsize+1):end) + 20;
	
	train1 = data(1, indtrain1);
	test1 = data(1, indtest1);
	train2 = data(1, indtrain2);
	test2 = data(1, indtest2);
	train3 = data(1, indtrain3);
	test3 = data(1, indtest3);
	
	w = tempotron(train1, train2);
% 	w = tempotron(train1, train3);
% 	w = tempotron(train2, train3);
	
	Vt1 = forward_pass(test1{1,1}, w);
	Vt2 = forward_pass(test2{1,1}, w);
% 	Vt3 = forward_pass(test3{1,1}, w);
	
	if max(Vt1) >=1 && max(Vt2) < 1
% 	if max(Vt1) >=1 && max(Vt3) < 1
% 	if max(Vt2) >=1 && max(Vt3) < 1
		result(i) = 1;
	end
end

disp(['Number of trials used in training is ', num2str(10-testsize), ' for each odor']);
disp(['Number of tests = ', num2str(Ntest)]);
disp(['Percentage of correct classification = ', num2str(100*sum(result)/length(result)), '%']);

figure; hold on;
plot(1:twin, 1, 'k:');
plot(1:twin, Vt1, 'b', 1:twin, Vt2, 'r');
% plot(1:twin, Vt1, 'b', 1:twin, Vt3, 'g');
% plot(1:twin, Vt2, 'r', 1:twin, Vt3, 'g');

end

