function [solutions, f_values, c_values, a_values] = RCGATime(starter, Np, T, fitness, lb, ub, etac, etam, Pc, Pm,d)
    
%     P = random(lb, ub, Np, d, 'real');
%     P = lb + (ub - lb).*rand(Np,d);
    P = starter;


    solutions = zeros(T+1,d); 
    f_values = zeros(T+1,1); 
    c_values = zeros(T+1, 1);
    a_values = zeros(T+1, 1);

    f = zeros(Np,1);
    counter = zeros(Np, 1);
    actual = zeros(Np, 1);
    
    off_f = zeros(Np,1);
    off_counter = zeros(Np, 1);
    off_actual = zeros(Np, 1);

    for i = 1:Np
        [f(i), counter(i), actual(i)] = fitness(P(i,:));
    end

    [f_values(1), ind] = min(f);
    solutions(1,:) = P(ind,:);
    c_values(1) = counter(ind);
    a_values(1) = actual(ind);

    for i = 1:T
        Mating = Tournament(f,Np);
        Parent = P(Mating,:);

        off = SBX(Parent,Pc,etac,lb,ub);

        off = Mutation(off, Pm, etam,lb, ub);

        for j=1:Np
            [off_f(j), off_counter(j), off_actual(j)] = fitness(off(j,:));
        end

        [f,ind] = sort([f;off_f]);
        f = f(1:Np);
        
        Mix = [P;off];
        P = Mix (ind(1:Np),:);
        
        Mix = [counter; off_counter];
        counter = Mix(ind(1:Np));
        
        Mix = [actual; off_actual];
        actual = Mix(ind(1:Np));

        [f_values(i+1), ind] = min(f);
        solutions(i+1,:) = P(ind,:);
        c_values(i+1) = counter(ind);
        a_values(i+1) = actual(ind);
    end
    
end




function Mating = Tournament(f, Np)
    Mating = NaN(Np,1);
    indx = randperm(Np);

    for i = 1 : Np-1
        People = [indx(i) indx(i+1)];
        People_f =f(People);
        [~, ind] = min(People_f);
        Mating(i)= People(ind);
    end

     People = [indx(Np) indx(1)];
     People_f =f(People);
     [~, ind] = min(People_f);
     Mating(Np)= People(ind);
end

function off = SBX(Parent,Pc,etac,lb,ub)
    [Np,d] = size(Parent);
    indx = randperm(Np);
    
    Parent = Parent(indx,:);
    off = NaN(Np,d);

    for i= 1:2:Np
        r= rand;
        if r<Pc
            for j=1:d
                r=rand;
                if r<=0.5
                    beta = (2*r)^(1/(etac+1));
                else
                    beta = (1/(2*(1-r)))^(1/(etac+1));
                end
                off(i,j) = 0.5*(((1+beta)*Parent(i,j))+(1-beta)*Parent(i+1,j));
                off(i+1,j) = 0.5*(((1-beta)*Parent(i,j))+(1+beta)*Parent(i+1,j));
            end
            off(i,: )=max(off(i,:),lb);
            off(i+1,: )=max(off(i+1,:),lb);
            off(i,:)= min(off(i,:),ub);
            off(i+1,:)= min(off(i+1,:),ub);
        else
            off(i,:)= Parent(i,:);
            off(i+1,:)= Parent(i+1,:);

        end
    end
end
 
function off = Mutation(off, Pm, etam,lb, ub)
    [Np,d] = size(off);
    for i=1:Np
        r = rand;
        if r < Pm
            for j = 1:d
                r = rand;
                if r< 0.5
                    delta = (2*r)^(1/(etam+1))-1;
                else
                    delta =(1-(2*(1-r)))^(1/(etam+1))-1;
                end
                off(i,j)= off(i,j)+(ub(j)-lb(j))*delta;
            end
            off(i,:)=max(off(i,:),lb);
            off(i,:)=min(off(i,:),ub);
        end
    end
end