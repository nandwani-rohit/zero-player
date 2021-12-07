% Cleaning the previous workspace variables and closing all figures..
cleanIt;

% % Initialization...
% data;
% initialize();
% 
% % TLBO + others...
% Np = 10;
% T = 50;
% lb = [0 -5];
% ub = [5 5];
% d = 2;
% 
% % PSO
% w = 0.7298;
% c1 = 1.496;
% c2 = 1.496;
% 
% % ABC
% limit = Np*T;
% 
% % DE
% pc = 0.8;
% F = 0.8;
% 
% % GA
% etac = 20;
% etam = 20;
% Pc = 0.8;
% Pm = 0.2;
% 
% % Averaging parameters....
% nRuns = 1;
% 
% solutions = NaN(T+1, d, nRuns);
% solutions2 = NaN(T+1, d, nRuns);
% solutions3 = NaN(T+1, d, nRuns);
% solutions4 = NaN(T+1, d, nRuns);
% solutions5 = NaN(T+1, d, nRuns);
% 
% f_values = NaN(T+1, nRuns);
% f_values2 = NaN(T+1, nRuns);
% f_values3 = NaN(T+1, nRuns);
% f_values4 = NaN(T+1, nRuns);
% f_values5 = NaN(T+1, nRuns);
% 
% c_values = NaN(T+1, nRuns);
% c_values2 = NaN(T+1, nRuns);
% c_values3 = NaN(T+1, nRuns);
% c_values4 = NaN(T+1, nRuns);
% c_values5 = NaN(T+1, nRuns);
% 
% a_values = NaN(T+1, nRuns);
% a_values2 = NaN(T+1, nRuns);
% a_values3 = NaN(T+1, nRuns);
% a_values4 = NaN(T+1, nRuns);
% a_values5 = NaN(T+1, nRuns);
% 
% for k = 1:nRuns
%     [solutions(:,:,k), f_values(:,k), c_values(:,k), a_values(:,k), starter] = TLBOTime(Np, T, @objectiveFunTime, lb, ub, d);
%     [solutions2(:,:,k), f_values2(:,k), c_values2(:,k), a_values2(:,k)] = PSOTime(starter, Np, T, @objectiveFunTime, lb, ub, d, w, c1, c2);
%     [solutions3(:,:,k), f_values3(:,k), c_values3(:,k), a_values3(:,k)] = DETime(starter, Np, T, @objectiveFunTime, lb, ub, d, pc, F);
%     [solutions4(:,:,k), f_values4(:,k), ~, c_values4(:,k), a_values4(:,k)] = ABCTime(starter, Np, T, @objectiveFunTime, lb, ub, d, limit);
%     [solutions5(:,:,k), f_values5(:,k), c_values5(:,k), a_values5(:,k)] = RCGATime(starter, Np, T, @objectiveFunTime, lb, ub, etac, etam, Pc, Pm,d);
% end
% 
% % save timeComparisons.mat solutions solutions2 solutions3 solutions4 solutions5 f_values f_values2...
% %     f_values3 f_values4 f_values5 c_values c_values2 c_values3 c_values4...
% %     c_values5 a_values a_values2 a_values3 a_values4 a_values5 nRuns;

load timeComparisons.mat;

T = 50;
% TLBO
f_values = mean(f_values, 2);
c_values = mean(c_values, 2);
a_values = mean(a_values, 2);

% PSO
f_values2 = mean(f_values2, 2);
c_values2 = mean(c_values2, 2);
a_values2 = mean(a_values2, 2);

% DE
f_values3 = mean(f_values3, 2);
c_values3 = mean(c_values3, 2);
a_values3 = mean(a_values3, 2);

% ABC
f_values4 = mean(f_values4, 2);
c_values4 = mean(c_values4, 2);
a_values4 = mean(a_values4, 2);

% RCGA
f_values5 = mean(f_values5, 2);
c_values5 = mean(c_values5, 2);
a_values5 = mean(a_values5, 2);


% Plotting starts here.....
h(1) = figure;
hold on;
plot(0:T, f_values, 'DisplayName', "TLBO");
plot(0:T, f_values2, 'DisplayName', "PSO");
plot(0:T, f_values3, 'DisplayName', "DE/rand/1");
plot(0:T, f_values4, 'DisplayName', 'ABC');
plot(0:T, f_values5, 'DisplayName', "RCGA");
xlabel("Generation \rightarrow");
ylabel("FITNESS Function \rightarrow");
legend('Interpreter', 'latex');

h(2) = figure;
hold on;
plot(0:T, a_values, 'DisplayName', "TLBO");
plot(0:T, a_values2, 'DisplayName', "PSO");
plot(0:T, a_values3, 'DisplayName', "DE/rand/1");
plot(0:T, a_values4, 'DisplayName', 'ABC');
plot(0:T, a_values5, 'DisplayName', "RCGA");
xlabel("Generation \rightarrow");
ylabel("Objective Function \rightarrow");
legend('Interpreter', 'latex');

h(3) = figure;
hold on;
plot(0:T, c_values, 'DisplayName', "TLBO");
plot(0:T, c_values2, 'DisplayName', "PSO");
plot(0:T, c_values3, 'DisplayName', "DE/rand/1");
plot(0:T, c_values4, 'DisplayName', 'ABC');
plot(0:T, c_values5, 'DisplayName', "RCGA");
xlabel("Generation \rightarrow");
ylabel("# time-steps \rightarrow");
legend('Interpreter','latex');

savefig(h, "timeComparisons.fig");
% close(h);

% load finish_music.mat
% sound(z);