close all;
clear;
clc;

load comparisons;

figure; hold on;
plot(1:8000, Vt12(1,:), 'b', 1:8000, Vt12(2,:), 'r');
plot(1:100:8000, 0, 'k:', 1:100:8000, 1, 'k:');
plot([1,4000], [-0.5, -0.5], 'k-', 'LineWidth', 8);
xlabel('Time (ms)');
ylabel('V(t)');
legend('Odor C', 'Odor D');
axis([0 8000 -0.7 1.7]);
 
figure; hold on;
plot(1:8000, Vt23(1,:), 'r', 1:8000, Vt23(2,:), 'g');
plot(1:100:8000, 0, 'k:', 1:100:8000, 1, 'k:');
plot([1,4000], [-0.5, -0.5], 'k-', 'LineWidth', 8);
xlabel('Time (ms)');
ylabel('V(t)');
legend('Odor D', 'Odor C+D');
axis([0 8000 -0.7 1.7]);

clear;

load comparisons60;

figure; hold on;
plot(1:8000, Vt13(1,:), 'b', 1:8000, Vt13(2,:), 'g');
plot(1:100:8000, 0, 'k:', 1:100:8000, 1, 'k:');
plot([1,4000], [-0.5, -0.5], 'k-', 'LineWidth', 8);
xlabel('Time (ms)');
ylabel('V(t)');
legend('Odor C', 'Odor C+D');
axis([0 8000 -0.7 1.7]);
