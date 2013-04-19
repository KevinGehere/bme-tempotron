function [a, miss] = batch_perceptron (x_n,a,eta)
%batch perceptron
%bla bla
y = x_n * a;
miss = [];
miss = find (y<0);
a = a + eta * sum(x_n(miss,:),1)';
end


