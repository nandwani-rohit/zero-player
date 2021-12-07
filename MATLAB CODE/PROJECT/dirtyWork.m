function dirtyWork(j_val)
    global j U_X U_Y z_data u_x;
    j = j_val;
    for i=1:length(u_x)
        z_data(i,j) = objectiveFun2(U_X(i,j), U_Y(i,j));
    end 
end

xlabel("u_{x}\rightarrow");ylabel("u_{y}\rightarrow");title("Contour Plot of Objective Function, $f(\mathbf{u})$", Interpreter="latex");
