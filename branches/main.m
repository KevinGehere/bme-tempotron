clear;
close all;
clc;

load RamanPNdata_AP;
% load RamanPNdata_OO;

Nneuron = 115;
twin = 500;
t0 = 15001;
ntbin = 8000/twin;

sndata = zeros(ntbin, 20);
data = [];
for i = 1:Nneuron
	if i == 20, continue, end;
	baseline = mean(PNAP{i}(1:(t0-1), 1:20)) * twin;
	for j = 1:ntbin
		sndata(j,:) = sum(PNAP{i}((t0+twin*(j-1)):(t0+twin*j-1), 1:20)) - baseline;
	end
	data = [data; sndata];
end

data = data';
[eigvec, newdata, eigval] = princomp(data);
data = newdata(:, 1:19);

train1 = data(1:9, :);
train2 = data(11:19, :);
test1 = data(10, :);
test2 = data(20, :);

w = perceptron(train1, train2);

[0 test1] * w
[0 test2] * w



