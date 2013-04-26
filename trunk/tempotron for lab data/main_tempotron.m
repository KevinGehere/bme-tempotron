function main_tempotron
close all;
clear;
clc;

label = 'AP';
% label = 'OO';

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
twin = 500;
ntbin = 8000/twin;
data = cell(1,20);

for j = 1:20
	stdata = [];
	for i = 1:Nneuron
		if i == 20 && strcmp(label, 'AP'), continue, end;
		sndata = reshape(dataset{i}(t0:t0+8000-1, j), twin, ntbin)';
		stdata = [stdata; sndata];
	end
	data{1,j} = stdata;
end

train1 = data(1, 2:10);
test1 = data(1, 1);
train2 = data(1, 12:20);
test2 = data(1, 11);

w = tempotron(train1, train2);

Vt1 = forward_pass(test1{1,1}, w);
Vt2 = forward_pass(test2{1,1}, w);

figure;
plot(Vt1);
figure;
plot(Vt2);

end

