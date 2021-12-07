cleanIt;
load impyimp.mat;
data;
initialize();
[points, counter, distance] = pathFinder(sol_imp(7,:));
save impy7.mat points counter distance;

fprintf("DONE\n");

% =====================================

cleanIt;
load impy7.mat

s = "";
for i = 1:counter
    s = s + sprintf("{%f, %f},\n ", points(i, 1), points(i, 2));
end
% 
fileID = fopen('impy7.txt', 'w');
fprintf(fileID, s);
fclose(fileID);

fprintf("DONE\n");