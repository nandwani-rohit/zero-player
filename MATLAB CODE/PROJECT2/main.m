data
initialize()

Np = 10;
T = 30;
lb = [-5 -5];
ub = [5 5];
d = 2;

[solution, f_values] = TLBO(Np, T, @objectiveFun, lb, ub, d);

subplot(1,1,1);
plot(0:T, f_values);

display(solution);

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

