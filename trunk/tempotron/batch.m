function [a,delta] = batch(YX, Y)

%initializations
a = 0.1*ones(1,785);
eta = 0.1;
threshold = 0.01;
k = 0;

%X1 = [1 6; 7 2; 8 9; 9 9];
%X2 = [2 1; 2 2; 2 4; 7 1];

len = length(Y);

% YX = zeros(len, 785);
% 
% for i = 1:len
% YX(i,:) = Y(i);
% for j = 1:784;
% YX(i,:) = [YX(i,:) Y(i).*X(i,j)];
% end
% end

stop = 0;

iters = 1000;
count = zeros(1, iters);
delta = zeros(1, iters);

while ~stop
    k = k + 1;
    if k == iters
        stop = 1;
    end
    misclass = zeros(1,785);
    for i = 1:len
        if YX(i,:) * a' < 0
            misclass = misclass + YX(i,:);
            count(k) = count(k) + 1;
        end
    end
    a = a + eta .* misclass;
    b = eta .* misclass;
    delta(k) = norm(b);
    if norm(b) < threshold
        stop = 1;
    end
end
