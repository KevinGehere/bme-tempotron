% Multilayer perceptron
% 784 inputs corresponding to 784 columns of each digit + 1 bias input xi
% (i = 1 to 785), weight uih between input x and hidder layer y.
% 100 neurons + 1 bias neuron in hidden layer yh (h = 1 to 100),weight whj
% between hidden layer y and output o.
% 10 output oj corresponding to digits 0 to 9, (j = 0 to 9).
% Non-linear activity funtion: logistic function


function [corr_rate] = MLP (a,eta)

%combine train0-train9 to train, test0-test9 to test and generation
%corresponding output data.
%train_class and test_class give the start row and end row for each number
[train,output_train,train_class,test,output_test,test_class] = combine_data();

%MLP training
x0 = 1;%input bias node
y0 = 1;%hidden bias node
% eta = 2;%learning rate
% a = 5; %activation function constant
u = rand(size(train,2)+1,100)/100;%784+1 inputs to 100 hidden neurons
w = rand(101,10)/100;%100+1 hidden neurons to 10 outputs
x = zeros(1,size(train,2)+1);%each input
x (size(train,2)+1)=x0;
%v = zeros(1,100);%each hidden value before activation
%y = zeros(1,101);%each hidden neuron after activation
%y(101) = y0;
o = zeros(1,10);%each output after activiation
ov = zeros(1,10);%each output value before activation
e = zeros(1,10); %error before activation
%sum_e = ones(1,size(train,1));

sum_error = zeros(1,2000000);

G = 2000; %contrast gain
Ref = 0.005; %refractory period 0.005s

for epoch = 1:2000000
    train_rand = randperm(60000);
    %pick random sample of input
    input = train_rand(1); %random pick sample
    %input = epoch;  %sequentially pick sample
    x(1:size(train,2)) = train(input,:);
   x = (x/255*G)./(1+Ref*G*(x/255))/255;
    
    v = x*u;
    y = 1./(1+exp(-a.*v));
    y = [y y0];
    %get output layer value
    ov = y*w;
    o = 1./(1+exp(-a.* ov));
    
    %error = desired output - output
    e = output_train (input, :) - o;
    sum_e = sum(abs(e));
    
    %output delta
    delta_j = a.* e .* o.*(1-o);
    
    %hidden layer delta
    delta_h = a.*y.*(1-y).*(delta_j*w');
    
    %updata weight
    w = w + eta.*(y'*delta_j);
    u = u + eta.*(x'*delta_h(1:100));
    
    sum_error(epoch) = sum_e;
end



figure;
plot(sum_error);
title ('Training sum errors');
xlabel('Iterations');



%MLP testing over all perform
x_test = zeros(1,size(test,2)+1);%each input
x_test(size(test,2)+1)=x0;
%v_test = zeros(1,100);%each hidden value before activation
%y_test = zeros(1,101);%each hidden neuron after activation
%y_test(101) = y0;
o_test = zeros(1,10);%each output after activiation
ov_test = zeros(1,10);%each output value before activation
e_test = zeros(1,10); %error before activation
sum_e_test = zeros(1,size(test,1));

correct = 0;
test_record = zeros(size(test,1),1);
for input_test = 1:size(test,1)
    
    x_test(1:size(test,2)) = test(input_test,:);
    x_test = (x_test/255*G)./(1+Ref*G*(x_test/255))/255;

    %get hidden layer value
    v_test = x_test*u;
    y_test = 1./(1+exp(-a.*v_test));
    y_test = [y_test y0];
    
    %get output layer value
    %  for j = 1:10
    ov_test = y_test*w;
    %  end
    o_test = 1./(1+exp(-a.* ov_test));
    
    %error = desired output - output
    e_test = output_test (input_test, :) - o_test;
    sum_e_test(input_test) = sum(abs(e_test));
    
    if find(o_test == max(o_test)) == find(output_test (input_test, :) == max (output_test (input_test, :)))
        correct = correct +1;
        test_record(input_test) = 1;
    end
end

corr_rate = correct /size(test,1);


figure;
plot(sum_e_test);
title ('Testing sum errors');
xlabel('Testing samples');

correct_percentage = zeros(10,1);

for test_set = 1:10
    test_digit = sum(test_record(test_class(test_set,1):test_class(test_set,2)));
    correct_percentage(test_set) = test_digit/(test_class(test_set,2)-test_class(test_set,1)+1);
end

figure;
bar(correct_percentage*100, 0.5);
xlim([0 11]);
ylim([0 100]);
title('Final classification percentages for each digit');
xlabel('Digit 0 ~ 9');
ylabel('Percentation (%)');
end
