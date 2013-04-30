close all;
clear;
clc;

figure; hold on;
h = bar(1, 70);
set(h, 'FaceColor', [0.5 0.5 0.5]);
h = bar(2, 90);
set(h, 'FaceColor',[0.3 0.3 0.3]);
h = bar(3, 90);
set(h, 'FaceColor',[0 0 0]);
set(gca, 'Xtick', [1 2 3], 'XtickLabel', [10; 30; 60]);
ylim([0 100]);
xlabel('Number of iterations');
ylabel('Percentage of correct classification');
title('Odor C vs. Odor D');


figure; hold on;
h = bar(1, 20);
set(h, 'FaceColor', [0.5 0.5 0.5]);
h = bar(2, 50);
set(h, 'FaceColor',[0.3 0.3 0.3]);
h = bar(3, 70);
set(h, 'FaceColor',[0 0 0]);
set(gca, 'Xtick', [1 2 3], 'XtickLabel', [10; 30; 60]);
ylim([0 100]);
xlabel('Number of iterations');
ylabel('Percentage of correct classification');
title('Odor C vs. Odor C+D');


figure; hold on;
h = bar(1, 30);
set(h, 'FaceColor', [0.5 0.5 0.5]);
h = bar(2, 50);
set(h, 'FaceColor',[0.3 0.3 0.3]);
h = bar(3, 80);
set(h, 'FaceColor',[0 0 0]);
set(gca, 'Xtick', [1 2 3], 'XtickLabel', [10; 30; 60]);
ylim([0 100]);
xlabel('Number of iterations');
ylabel('Percentage of correct classification');
title('Odor D vs. Odor C+D');