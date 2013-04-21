clear;
close all;
clc;

% label = 'AP';
label = 'OO';

%load and preprocess data
if strcmp(label, 'AP')
    load RamanPNdata_AP;
    dataset = PNAP;
    Nneuron = 115;
    t0 = 15001;
elseif strcmp(label, 'OO')
    load RamanPNdata_OO;
    dataset = PNOO;
    Nneuron = 116;
    t0 = 2001;  
end

twin = 500;
ntbin = 8000/twin;
sndata = zeros(ntbin, 20);
data = [];

for i = 1:Nneuron
    if i == 20 && strcmp(label, 'AP'), continue, end;
	baseline = mean(dataset{i}(1:(t0-1), 1:20)) * twin;
	for j = 1:ntbin
		sndata(j,:) = sum(dataset{i}((t0+twin*(j-1)):(t0+twin*j-1), 1:20)) - baseline;
	end
	data = [data; sndata];
end

data = data';

%PCA
[eigvec, newdata, eigval] = princomp(data);
data = newdata(:, 1:2);

Ntest = 100;
testsize = 5;
result = zeros(Ntest, 1);
Ninter = zeros(Ntest, 1);

for i = 1:Ntest
    %divide data into training and test datasets
    ind1 = randperm(10); 
    indtest1 = ind1(1:testsize);
    indtrain1 = ind1((testsize+1):end);
    ind2 = randperm(10); 
    indtest2 = ind2(1:testsize) + 10;
    indtrain2 = ind2((testsize+1):end) + 10;
       
    train1 = data(indtrain1, :);
    test1 = data(indtest1, :);
    train2 = data(indtrain2, :);
    test2 = data(indtest2, :);
    
    %train perceptron
    [w, Ninter(i)] = perceptron(train1, train2);
    
    %test perceptron
    result1 = [ones(testsize, 1) test1] * w;
    result2 = [ones(testsize, 1) test2] * w;
    
    if isequal(sign(result1), ones(testsize, 1)) && isequal(sign(result2), -ones(testsize, 1))
        result(i) = 1;
    end
end

disp(['Number of trials used in training is ', num2str(10-testsize), ' for each odor']);
disp(['Number of tests = ', num2str(Ntest)]);
disp(['Percentage of correct classification = ', num2str(100*sum(result)/length(result)), '%']);

figure;
plot(Ninter, 'bo-');
xlabel('# of tests');
ylabel('# of iterations');
title('Number of iterations used in training perceptron');

figure; hold on;
plot(train1(:,1), train1(:,2), 'b*');
plot(test1(:,1), test1(:,2), 'bo');
plot(train2(:,1), train2(:,2), 'r*');
plot(test2(:,1), test2(:,2), 'ro');
db = @(x) -w(2)/w(3) * x - w(1)/w(3);        %decision boundary
fplot(db, [-40 40], 'k');
axis([-40 40 -40 40]);
xlabel('PC1');
ylabel('PC2');
title('Visualizing the classification result of the last test');
legend('training set 1', 'test set 1', 'training set 2', 'test set 2', 'decision boundary', 'location', 'NorthEastOutside');

