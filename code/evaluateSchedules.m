%% Random Walks cours project - Simulated annealing
% You will have to experiment to find a suitable schedule for lowering T 
% (resp., increasing ?). If you lower T too slowly, you might not reach the
% minimizers of (1) in a decent amount of time. If you lower T too quickly,
% you lose the advantage of the Metropolis step and might end up in a local
% minimum with strictly positive cost.

% clear; close all;

% TODO: tweak these values
max_iterations = 5000;
N = 250;
q = 10;
cValues = linspace(0, N/4, 10);
% Since we're working with random graphs, we make several random draws
% to make sure that we obtain relevant data points.
nDraws = 5;

% Define the schedules to evaluate
% Linear
beta_0 = 0.001;
alpha = 6;
tau = 0.05; 
linearArgs = {beta_0, alpha, tau};
% Sublinear
beta_0 = 10;
alpha = 0.5;
tau = 0;
sublinearArgs = {beta_0, alpha, tau};
% Polynomial 
beta_0 = 10;
alpha = 2.5;
tau = 0;
polynomialArgs = {beta_0, alpha, tau};
% Logarithmic
beta_0 = 10;
alpha = 1;
tau = 0;
logarithmicArgs = {beta_0, alpha, tau};
% Exponential
beta_0 = 0.01;
alpha = 0.0005;
tau = 0;
exponentialArgs = {beta_0, alpha, tau};

schedules = {'linear', linearArgs;
             'sublinear', sublinearArgs;
             'polynomial', polynomialArgs;
             'logarithmic', logarithmicArgs;
             'exponential', exponentialArgs;};
         
plotSchedules(schedules);

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
title_string = sprintf('Hmin(q=%d, c) with N=%d edges (max iterations: %d)', ...
                       q, N, max_iterations);
title(title_string, 'FontSize', 16); xlim([0 cValues(end)]);
xlabel('Graph density (c)', 'FontSize', 16); ylabel('Minimum energy achieved', 'FontSize', 16);
legend(legends, 'Location', 'NorthWest', 'FontSize', 16);
set(gcf,'color','w');
export_fig('/tmp/schedules_evaluation.pdf');
savefig('schedules_evaluation.fig')