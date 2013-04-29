clear;
clc;
close all;
%
% a = [0.01,0.1,1,5,10,50,100];
% eta = [5,2,1,0.5,0.1,0.01];
% corr_rate = [];
% for i = 1: size(a,2)
%     for j = 1: size(eta,2)
%        corr_rate = [corr_rate, MLP(a(i),eta(j))];
%     end
% end

corr_rate_1 = MLP(1,0.1);
corr_rate_2 = SLP(1,0.1);


