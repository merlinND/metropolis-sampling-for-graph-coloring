%% Random Walks cours project - Question 4
% For given values of q and c, let Hmin(q, c) denote the cost of the 
% coloring found by your algorithm, which is supposedly close to optimal.
% Plot Hmin as a function of c for three different values of q (say q = 3, 5, 7).
% What do you observe?

%% Parameters & chedule
% Sublinear
beta_0 = 10;
alpha = 0.5;
tau = 0;
varargin = {beta_0, alpha, tau};
schedule = getSchedule('sublinear');

max_iterations = 5000;
N = 100;
qValues = [3 5 7 10];
cValues = linspace(0, N, 20);
% Since we're working with random graphs, we make several random draws
% to make sure that we obtain relevant data points.
nDraws = 5;

%% Run many searches

minimum_energies = zeros(nDraws, length(cValues), length(qValues));
% For each curve
for k = 1:length(qValues)
    q = qValues(k);
    fprintf('Number of colors %d: ', q);
    
    for j = 1:length(cValues)
        fprintf('#')
        c = cValues(j);
        
        for i = 1:nDraws
            G = randomGraph(N, c);
            [~, minimum_energies(i, j, k)] = ...
                findColoring(G, q, max_iterations, schedule, varargin);
        end;
    end;
    fprintf('\n');
end;

%% Plot resulting energies
figure; hold on;
legends = {};
for k = 1:length(qValues)
    m = mean(minimum_energies(:, :, k)); 
    u = std(minimum_energies(:, :, k), 1);
    errorbar(cValues, m, u, '-+');
    legends{end+1} = sprintf('q = %d colors', qValues(k));
end;
title_string = sprintf('Hmin(q, c) with N=%d nodes (max iterations: %d)', ...
                       N, max_iterations);
title(title_string); xlim([0 N]);
xlabel('Graph density (c)'); ylabel('Minimum energy achieved');
legend(legends, 'Location', 'NorthWest');