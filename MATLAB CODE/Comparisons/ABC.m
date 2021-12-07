function [solutions, f_values, f2_values] = ABC(starter, Np, T, objective, lb, ub, d, limit)

    % Generate random population P within lb, ub
    % d = dimension of search space

%     P = random(lb, ub, Np, d, 'real');
	P = starter;
    
    solutions = zeros(T+1,d);
    f_values = zeros(T+1,1); 
    f2_values = zeros(T+1, 1);
    
    f = zeros(Np,1);
    f2 = zeros(Np, 1);
    trial = zeros(Np, 1);

    %f = fitness(P);
    for i = 1:Np
        f(i) = objective(P(i,:));
        f2(i) = fitness(f(i));
    end
        
    [f2_values(1), j_best] = max(f2);
    f_values(1) = f(j_best);
    solutions(1,:) = P(j_best,:);

    for t = 1:T

        % Employed Bee Phase (EBP)
        for i = 1:Np
            p = i;
            while p == i
                p = random(1,Np,1,1,'int');
            end
            phi = random(-1, 1, 1, 1, 'real');
            j = random(1,d,1,1,'int');

            X_new = P(i,:);
            X_new(j) = P(i,j) + phi*(P(i,j) - P(p,j));
            X_new = bound_it(X_new, lb, ub);

            f_new = objective(X_new);
            f2_new = fitness(f_new);

            if f2_new > f2(i)
                P(i,:) = X_new;
                f(i,:) = f_new;
                f2(i,:) = f2_new;
                trial(i) = 0;
            else
                trial(i) = trial(i) + 1;
            end
        end

        % Determine Probability Vector
        proby = 0.9*f2/max(f2) + 0.1;

        % Onlooker Bee Phase (OBP)
        m = 0;  n = 1;

        while m <= Np
            r = random(0, 1, 1, 1, 'real');
            if r < proby(n)
                p = n;
                while p == n
                    p = random(1,Np,1,1,'int');
                end
                phi = random(-1, 1, 1, 1, 'real');
                j = random(1,d,1,1,'int');
    
                X_new = P(n,:);
                X_new(j) = P(n,j) + phi*(P(n,j) - P(p,j));
                X_new = bound_it(X_new, lb, ub);
    
                f_new = objective(X_new);
                f2_new = fitness(f_new);  

                if f2_new > f2(n)
                    P(n,:) = X_new;
                    f(n,:) = f_new;
                    f2(n,:) = f2_new;
                    trial(n) = 0;
                else
                    trial(n) = trial(n) + 1;
                end                
                m = m + 1;
            end    
            n = n + 1;
            if n > Np
                n = 1;
            end
        end

        % Memorize the best solution
        [f_values(t+1), j_best] = min([f; f_values(t)]);
        temp = [P; solutions(t,:)];
        solutions(t+1,:) = temp(j_best,:);
        f2_values(t+1) = fitness(f_values(t+1));

        % Scout Bee Phase (SBP)
        [val, ind] = max(trial);

        if val > limit
            trial(ind) = 0;
            P(ind,:) = random(lb, ub, 1, d, 'real');
            f(ind) = objective(P(ind,:));
            f2(ind) = fitness(f(ind));
        end

        [f_values(t+1), j_best] = min([f; f_values(t)]);
        temp = [P; solutions(t,:)];
        solutions(t+1,:) = temp(j_best,:);
        f2_values(t+1) = fitness(f_values(t+1));

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

function f2 = fitness(f1)
    if f1 >= 0
        f2 = 1/(1+f1);
    else
        f2 = 1-f1;
    end
end