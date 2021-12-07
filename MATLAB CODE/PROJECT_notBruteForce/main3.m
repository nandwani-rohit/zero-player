cleanIt;

data;
initialize();

Np = 10;
T = 20;
fitness = @objectiveFun;
lb = [0 -5];
ub = [5 5];
d = 2;
w = 0.7298;
c1 = 1.496;
c2 = 1.496;

[solutions, f_values, populace] = PSO_swarm_plot(Np, T, fitness, lb, ub, d, w, c1, c2);


xmin = min(populace(:,1,:), [], 'all');
xmax = max(populace(:,1,:), [], 'all');
ymin = min(populace(:,2,:), [], 'all');
ymax = max(populace(:,2,:), [], 'all');

for i = 1:T+1
    P = populace(:,:,i);
    h(i) = figure;
    xlim([xmin-1 xmax+1]);
    ylim ([ymin-1 ymax+1]);
    hold on;
    scatter(P(:,1), P(:,2), 40, 'filled');
    scatter(solutions(i,1), solutions(i,2), 40, "filled");
    saveas(h(i), "PICS/pikachu" + i + ".png");
end
savefig(h, "swarmypeeky.fig");
close(h);
disp("job done!!");