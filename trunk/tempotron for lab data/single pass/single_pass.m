close all;
clear;
clc;

load RamanPNdata_OO;

stdata1 = zeros(116, 8000);
stdata2 = zeros(116, 8000);

for i = 1:116
	stdata1(i,:) = PNOO{i}(2001:10000, 1);
	stdata2(i,:) = PNOO{i}(2001:10000, 11);
end

w = 0.05 * rand(1, 116);

Vt1 = forward_pass(stdata1, w);
Vt2 = forward_pass(stdata2, w);

figure;hold on;
plot(1:8000, Vt1);
plot(1:100:8000, 0, 'k:', 1:100:8000, 1, 'k:');
plot([1,4000], [-0.05, -0.05], 'k-', 'LineWidth', 8);
xlabel('Time (ms)');
ylabel('V(t)');
legend('Odor C');
axis([0 8000 -0.1 1.2]);

figure;hold on;
plot(1:8000, Vt1, 'b', 1:8000, Vt2, 'r');
plot(1:100:8000, 0, 'k:', 1:100:8000, 1, 'k:');
plot([1,4000], [-0.05, -0.05], 'k-', 'LineWidth', 8);
xlabel('Time (ms)');
ylabel('V(t)');
legend('Odor C', 'Odor D');
axis([0 8000 -0.1 1.2]);