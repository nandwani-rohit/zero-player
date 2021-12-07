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
d = 2;
w = 0.7298;
c1 = 1.496;
c2 = 1.496;

% [solutions, f_values, ~] = TLBO(Np, T, fitness, lb, ub, d);
[solutions, f_values] = PSO(Np, T, fitness, lb, ub, d, w, c1, c2);

figure;
hold on;
plot(0:T, f_values, 'DisplayName', "TLBO");
xlabel("Generation \rightarrow");
ylabel("Objective Function \rightarrow");
legend;