clear
clc
close all

% load('fine_tenth.mat');
data
initialize()

Np = 10;
T = 30;
% lb = [3.2 -3.5];
% ub = [5 4.2];

lb = [0 -5];
ub = [5 5];
d = 2;

% global solutions f_values;
% [solutions, f_values] = TLBO(Np, T, @objectiveFun, lb, ub, d);

global U_X U_Y z_data j u_x u_y;

fine = .01;
u_x = lb(1):fine:ub(1);
u_y = lb(2):fine:ub(2);
[U_Y, U_X] = meshgrid(u_y, u_x);
z_data = zeros(size(U_X));

% j = 1;
% for i=1:length(u_x)
% %     for j=1:length(u_y)
%     z_data(i,j) = objectiveFun2(U_X(i,j), U_Y(i,j));
% %     end
% end    


% save everything.mat U_X U_Y z_data

% contourf(U_X,U_Y,z_data)





% subplot(1,1,1);
% plot(0:T, f_values);

% display(solution);

% u_x = 4.5908365;
% u_y = 3.8361359;

% u_x = 4;
% u_y = 3;

% [status, distance] = objectiveFun(u_x, u_y);
% 
% global ball;
% disp(ball.v_x);
% disp(ball.v_y);
% 
% disp(status);
% disp(distance);

