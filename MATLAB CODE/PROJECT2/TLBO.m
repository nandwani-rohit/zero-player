function [solution, f_values] = TLBO(Np, T, fitness, lb, ub, d)
    % Generate random population P within lb, ub
    % d = dimension of search space
    f_values = zeros(1,T+1);
    
    P = random(lb, ub, Np, d, 'real');
    % function x = fitness(v)
    %     x = (1 + v(:,2))/v(:,1)
    % end
    
    f = zeros(Np,1);
    for i = 1:Np
        f(i) = fitness(P(i,:));
    end
        
    %f = fitness(P);
    f_values(1) = min(f);
    for i = 1:T
        for j = 1:Np
        % Teacher Phase T_j
        % --------------------------------------------------------------
            r = random(0,1,1,d,'real');
            T_f = random(1, 2, 1, 1, 'int');
            
            % Choose X_best
            [~, j_best] = min(f);
            
            % Generate new solution, X_new and f_new
            X_new = bound_it(P(j,:) + r.*(P(j_best,:) - T_f*mean(P)), lb, ub);
            f_new = fitness(X_new);
            
            % Greedy Selection
            if f_new < f(j)
                f(j) = f_new;
                P(j,:) = X_new;
            end
            
        % Learner Phase L_j
        % --------------------------------------------------------------
            r = random(0,1,1,d,'real');
            j_partner = random(1,Np,1,1,'int');
            
            % To make sure the partner solution isn't the same as P(j,:)
            % itself.
            while j_partner == j
                j_partner = random(1,Np,1,1,'int');
            end
            f_partner = fitness(P(j_partner,:));
            
            % Comparing partner fitness value with current student
            if f(j) < f_partner
                X_new = P(j,:) + r.*(P(j,:) - P(j_partner,:));
            else
                X_new = P(j,:) + r.*(P(j_partner,:) - P(j,:));
            end
            % Bounding
            X_new = bound_it(X_new, lb, ub);
            f_new = fitness(X_new);
            
            % Greedy Selection
            if f_new < f(j)
                f(j) = f_new;
                P(j,:) = X_new;
            end
        end
        
        f_values(i+1) = min(f);
    end
    
    [~,j_best] = min(f);
    solution = P(j_best, :);
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