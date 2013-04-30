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
twin = 1000;
duration = 1000;
ntbin = duration/twin;
data = cell(1,30);

for j = 1:30
	stdata = [];
	for i = 1:Nneuron
% 		if i == 20 && strcmp(label, 'AP'), continue, end;
		sndata = reshape(dataset{i}(t0:t0-1+duration, j), twin, ntbin)';
		stdata = [stdata; sndata];
	end
	data{1,j} = stdata;
end


testsize = 1;

ind1 = randperm(10);
indtest1 = ind1(1:testsize);
indtrain1 = ind1((testsize+1):end);
ind2 = randperm(10);
indtest2 = ind2(1:testsize) + 10;
indtrain2 = ind2((testsize+1):end) + 10;
% 	ind3 = randperm(10);
% 	indtest3 = ind3(1:testsize) + 20;
% 	indtrain3 = ind3((testsize+1):end) + 20;

train1 = data(1, indtrain1);
test1 = data(1, indtest1);
train2 = data(1, indtrain2);
test2 = data(1, indtest2);
% 	train3 = data(1, indtrain3);
% 	test3 = data(1, indtest3);
	
% w = tempotron(train1, train2);
% save('weights', 'w');

load weights;

figure; hold on;
for i = 2:size(w,1)
	Vt1 = forward_pass(test1{1,1}, w(i,:));
	Vt2 = forward_pass(test2{1,1}, w(i,:));

	subplot(3,3,i-1); hold on;
	plot(1:twin, Vt1, 'b', 1:twin, Vt2, 'r');
	plot(1:10:twin, 0, 'k:', 1:10:twin, 1, 'k:');
    axis([0 twin -1 3]);
	title(['Iteration ', num2str(i-1)]);
	if ismember(i, [8 9 10]), xlabel('Time (ms)'); end;
	if ismember(i, [2 5 8]), ylabel('V(t)'); end;
	
end