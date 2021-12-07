clear;
clear global;
clc;
close all;

data;
initialize();

Np = 10;
T = 30;
fitness = @objectiveFun;
lb = [0 -5];
ub = [5 5];
etac = 20;
etam = 20;
Pc = 0.8;
Pm = 0.2;
d = 2;

[solutions, f_values] = RCGA(Np, T, fitness, lb, ub, etac, etam, Pc, Pm,d);

figure;
hold on;
plot(0:T, f_values, 'DisplayName', "RCGA");
xlabel("Generation \rightarrow");
ylabel("Objective Function \rightarrow");
legend;

% Alert when the program is done running...
load handel.mat;
sound([y; y], 2*Fs);