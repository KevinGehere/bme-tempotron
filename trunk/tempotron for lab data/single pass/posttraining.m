close all;
clear;
clc;

load comparisons;

figure;hold on;
plot(1:8000, Vt12(1,:), 'b', 1:8000, Vt12(2,:), 'r');
plot(1:100:8000, 0, 'k:', 1:100:8000, 1, 'k:');
plot([1,4000], [-0.3, -0.3], 'k-', 'LineWidth', 8);
xlabel('Time (ms)');
ylabel('V(t)');
legend('Odor C', 'Odor D');
axis([0 8000 -0.5 1.5]);