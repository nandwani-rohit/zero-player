function [solutions, f_values, c_values, a_values] = DETime(starter, Np, T, fitness, lb, ub, d, pc, F)

    % Generate random population P within lb, ub
    % d = dimension of search space
%     P = random(lb, ub, Np, d, 'real');
    P = starter;
    U = zeros(Np, d);
    
    solutions = zeros(T+1,d);
    f_values = zeros(T+1,1);
    c_values = zeros(T+1, 1);
    a_values = zeros(T+1, 1);
    
    f = zeros(Np,1);
    counter = zeros(Np,1);
    actual = zeros(Np, 1);

    %f = fitness(P);
    for i = 1:Np
        [f(i), counter(i), actual(i)] = fitness(P(i,:));
    end
        
    [f_values(1), j_best] = min(f);
    c_values(1) = counter(j_best);
    a_values(1) = actual(j_best);
    solutions(1,:) = P(j_best,:);

    for t = 1:T
        for i = 1:Np
        % Generate the donor vector V_i using mutation
            indices = [1:i-1 i+1:Np];
            r = indices(randperm(Np-1,3));
            V_i = P(r(1),:) + F*(P(r(2),:) - P(r(3),:));

        % Perform crossover to generate offspring U_i
            delta = zeros(1, d);
            delta(random(1,d,1,1,'int')) = 1;
            
            r = random(0,1,1,d,'real');

            cond1 = (r <= pc) | delta;
            cond2 = not(cond1);
            U(i,:) = cond1.*(V_i) + cond2.*(P(i,:));
        end

        for i = 1:Np
            U(i,:) = bound_it(U(i,:), lb, ub);
            [f_U_i, c_U_i, a_U_i] = fitness(U(i,:));

        % Greedy Selection
            if f_U_i < f(i)
                f(i) = f_U_i;
                counter(i) = c_U_i;
                actual(i) = a_U_i;
                P(i,:) = U(i,:);
            end
            
        end
        
        [f_values(t+1), j_best] = min(f);
        c_values(t+1) = counter(j_best);
        a_values(t+1) = actual(j_best);
        solutions(t+1,:) = P(j_best,:);
    end
end

function stuff = random(lb, ub, m, n, mode)
    % Generates a random matrix of size mxn containing
    % values in [lb, ub]
    % mode signifies integer or real
    if strcmp(mode,'real')
        stuff = lb + (ub - lb).*rand(m,n);
    elseif strcmp(mode,'int')
        stuff = randi([lb ub], m, n);
    end
end

function X_bound = bound_it(X, lb, ub)
    % bounds vector X to [lb, ub]
    X_bound = min(max(X,lb),ub);
end    