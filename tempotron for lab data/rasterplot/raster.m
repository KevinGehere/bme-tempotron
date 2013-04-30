close all;
clear;
clc;

load RamanPNdata_OO;

times1 = [];
for i = 1:10
	ind = find(PNOO{1}(:, 20+i) == 1)';
	ind = ind + 30000 * (10-i);
	times1 = [ind times1];
end

times2 = [];
for i = 1:10
	ind = find(PNOO{2}(:, 20+i) == 1)';
	ind = ind + 30000 * (10-i);
	times2 = [ind times2];
end

times3 = [];
for i = 1:10
	ind = find(PNOO{116}(:, 20+i) == 1)';
	ind = ind + 30000 * (11-i);
	times3 = [ind times3];
end

ind = 2001:6000;
times3 = [ind times3];

rasterplot(times1,10,30000);
rasterplot(times2,10,30000);
rasterplot(times3,11,30000);