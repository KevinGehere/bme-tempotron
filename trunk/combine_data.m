function [train, output_train, train_class, test, output_test, test_class] = combine_data()

%combine train0-train9 to train, test0-test9 to test and generation
%corresponding output data.

load ('mnist_all.mat');

% count how many sample for each digits in both testing and training set
train_size = zeros(10,1);
train_class = zeros(10,2);
test_size = zeros(10,1);
test_class = zeros(10,2);

train_size(1) = size (train0, 1);
train_size(2) = size (train1, 1);
train_size(3) = size (train2, 1);
train_size(4) = size (train3, 1);
train_size(5) = size (train4, 1);
train_size(6) = size (train5, 1);
train_size(7) = size (train6, 1);
train_size(8) = size (train7, 1);
train_size(9) = size (train8, 1);
train_size(10) = size (train9, 1);
%combine all the train date
train = [train0;train1;train2;train3;train4;train5;train6;train7;train8;train9];
%generate corresponding output data
output_train = zeros(size(train,1),10);
for digit = 1:10
    if digit == 1
        output_train (1:train_size(1:digit),digit) = 1;
        train_class (digit,:) = [1, train_size(1:digit)];
    else
        output_train(((sum(train_size(1:digit))-train_size(digit)+1): sum(train_size(1:digit))),digit) = 1;
        train_class (digit,:) = [(sum(train_size(1:digit))-train_size(digit)+1), sum(train_size(1:digit))];
    end
end


test_size(1) = size (test0, 1);
test_size(2) = size (test1, 1);
test_size(3) = size (test2, 1);
test_size(4) = size (test3, 1);
test_size(5) = size (test4, 1);
test_size(6) = size (test5, 1);
test_size(7) = size (test6, 1);
test_size(8) = size (test7, 1);
test_size(9) = size (test8, 1);
test_size(10) = size (test9, 1);
%combine all the test date
test = [test0;test1;test2;test3;test4;test5;test6;test7;test8;test9];
%generate corresponding test data
output_test = zeros(size(test,1),10);
for digit = 1:10
    if digit == 1
        output_test (1:test_size(1:digit),digit) = 1;
        test_class (digit,:) = [1, test_size(1:digit)];
    else
        output_test(((sum(test_size(1:digit))-test_size(digit)+1): sum(test_size(1:digit))),digit) = 1;
        test_class (digit,:) = [(sum(test_size(1:digit))-test_size(digit)+1), sum(test_size(1:digit))];
    end
end


end