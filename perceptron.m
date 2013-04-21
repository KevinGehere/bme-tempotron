function [w, i] = perceptron(train1, train2)

y1 = [ones(size(train1, 1), 1), train1];
y2 = [ones(size(train2, 1), 1), train2];
y = [y1; -y2];

eta = 0.1;
w = 0.1 * rand(size(y, 2), 1);

for i = 1:1000
	ind = find(y * w <= 0);
	if isempty(ind), break, end;
	corr = sum(y(ind, :), 1);
	w = w + eta * corr';	
end

end