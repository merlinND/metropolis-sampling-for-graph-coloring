%% Combines results for competition submission

q3 = load('../results/color-3-46.mat');
q4 = load('../results/color-4-6.mat');
q5 = load('../results/color-5-2.mat');

E = zeros(3, 1);
X = q3.X;
E(1) = q3.E;
Y = q4.best_coloring;
E(2) = q4.minimum_cost;
Z = q5.best_coloring;
E(3) = q5.minimum_cost;

save(sprintf('../results/submission_total_%d.mat', sum(E)), ...
     'X', 'Y', 'Z', 'E');