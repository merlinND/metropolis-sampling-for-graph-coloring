%% Random Walks cours project - Simulated annealing
% You will have to experiment to find a suitable schedule for lowering T 
% (resp., increasing ?). If you lower T too slowly, you might not reach the
% minimizers of (1) in a decent amount of time. If you lower T too quickly,
% you lose the advantage of the Metropolis step and might end up in a local
% minimum with strictly positive cost.

clear; close all;

% TODO: tweak these values
max_iterations = 5000;
N = 100;
q = 3;
cValues = linspace(0, N, 20);
% Since we're working with random graphs, we make several random draws
% to make sure that we obtain relevant data points.
nDraws = 5;

% Define the schedules to evaluate
% Constant
beta_0 = 100;
constantArgs = {beta_0};
% Linear
beta_0 = 100;
alpha = 0.01;
linearArgs = {beta_0, alpha};
% Exponential
beta_0 = 0;
c = 1000;
alpha = 1;
delta = 1;
tau = 50;
exponentialArgs = {beta_0, c, alpha, delta, tau};
% Logarithmic
beta_0 = 10;
tau = 1;
logarithmicArgs = {beta_0, tau};
% Polynomial 
beta_0 = 10;
alpha = 2;
polynomialArgs = {beta_0, alpha};
% Adaptive exponential
beta_0 = 0;
c = 1000;
alpha = 1;
delta = 1;
tau = 50;
adaptiveArgs = {beta_0, c, alpha, delta, tau};

schedules = {'constant', constantArgs;
             'linear', linearArgs;
             'exponential', exponentialArgs;
             'logarithmic', logarithmicArgs;
             'polynomial', polynomialArgs;
             'adaptive', adaptiveArgs};

minimum_energies = zeros(nDraws, length(cValues), length(q));
% For each curve
for k = 1:length(schedules)
    schedule_id = schedules{k, 1};
    schedule = getSchedule(schedule_id);
    scheduleArgs = schedules{k, 2};
    fprintf('Schedule %s: ', schedule_id);
    
    for j = 1:length(cValues)
        c = cValues(j);
        
        for i = 1:nDraws
            G = randomGraph(N, c);
            [~, minimum_energies(i, j, k)] = findColoring(G, q, max_iterations, schedule, scheduleArgs);
        end;
    fprintf('#');
    end;
    fprintf('\n');
end;

%% Plot resulting energies
figure; hold on;
legends = {};
for k = 1:length(schedules)
    m = mean(minimum_energies(:, :, k)); 
    u = std(minimum_energies(:, :, k), 1);
    errorbar(cValues, m, u, '-+');
    legends{end+1} = sprintf('%s', schedules{k, 1});
end;
title_string = sprintf('Hmin(q, c) with N=%d edges (max iterations: %d)', ...
                       N, max_iterations);
title(title_string); xlim([0 N]);
xlabel('Graph density (c)'); ylabel('Minimum energy achieved');
legend(legends, 'Location', 'NorthWest');