% Cleaning all Variables and Closing all Figures
clear
clear global
clc
close all

% Initializing data for the algorithms.. you need to have the "data.m" and
% "initialize.m" in the same folder
data
initialize()

% Parameters
Np = 10;
T = 40;
lb = [0 -5];
ub = [5 5];
d = 2;

% PSO
w = 0.7298;
c1 = 1.496;
c2 = 1.496;

% ABC
limit = Np*T;

% DE
pc = 0.8;
F = 0.5;

% RCGA

% Running all the algorithms for "nRuns"
nRuns = 10;
% Declaring the arrays
solutions = NaN(T+1, d, nRuns);
f_values = NaN(T+1, nRuns);
solutions2 = NaN(T+1, d, nRuns);
f_values2 = NaN(T+1, nRuns);
solutions3 = NaN(T+1, d, nRuns);
f_values3 = NaN(T+1, nRuns);
solutions4 = NaN(T+1, d, nRuns);
f_values4 = NaN(T+1, nRuns);
solutions5 = NaN(T+1, d, nRuns);
f_values5 = NaN(T+1, nRuns);

for k = 1:nRuns
    [solutions(:,:,k), f_values(:,k), starter] = TLBO(Np, T, @objectiveFun, lb, ub, d);
    [solutions2(:,:,k), f_values2(:,k)] = PSO(starter, Np, T, @objectiveFun, lb, ub, d, w, c1, c2);
    [solutions3(:,:,k), f_values3(:,k), ~] = ABC(starter, Np, T, @objectiveFun, lb, ub, d, limit);
    [solutions4(:,:,k), f_values4(:,k)] = DE(starter, Np, T, @objectiveFun, lb, ub, d, pc, F);
    [solutions5(:,:,k), f_values5(:,k)] = RCGA(starter, Np, T, @objectiveFun, lb, ub, etac, etam, Pc, Pm,d);
end

% TLBO
f_values = mean(f_values, 2);

% PSO
f_values2 = mean(f_values, 2);

%

% Save all these values in a matlab file "allRuns.mat" for future use
save allRuns.mat solutions solutions2 solutions3 solutions4 solutions5 f_values f_values2 f_values3 f_values4 f_values5;

figure;
hold on;
plot(0:T, f_values, 'DisplayName', 'TLBO');
plot(0:T, f_values2, 'DisplayName', 'PSO');
% All other plots go here too..
xlabel('Generation \rightarrow');
ylabel('Objective Function \rightarrow');
legend;

% Save image as "comparisonFinal.png"
saveas(gcf, "comparisonFinal.png");