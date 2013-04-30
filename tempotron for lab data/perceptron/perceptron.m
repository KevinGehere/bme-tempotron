function [w, i] = perceptron(train1, train2)

y1 = [ones(size(train1, 1), 1), train1];
y2 = [ones(size(train2, 1), 1), train2];
y = [y1; -y2];

eps = 100;
eta = 0.2;
w = 0.1 * rand(size(y, 2), 1);

for i = 1:1000
	ind = find(y * w <= eps);
	if isempty(ind) && i>=3, break, end;
	corr = sum(y(ind, :), 1);
	w = w + eta * corr';
% 	w = w / sqrt(w'*w);
end

end