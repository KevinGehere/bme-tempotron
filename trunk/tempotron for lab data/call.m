close all;
clear;
clc;

Vt12 = main_tempotron(1);
Vt13 = main_tempotron(2);
Vt23 = main_tempotron(3);

save('comparisons', 'Vt12', 'Vt13', 'Vt23');