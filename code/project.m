%% Random Walks SS2016 - Simmulated Annealing for Graph Coloring
clear;
close all;
%rng(26);
addpath(genpath('lib'));
addpath(genpath('schedule'));

%% Setup

% Generate test adjacency matrix
N = 250;            % Number of edges
q = 4;              % Number of colors
beta = 0.2;         % Inverse temperature
c = 3;              % Density

% Erdos-Renyi graph
G = randomGraph(N, c);

%% Schedule
% Sublinear
beta_0 = 10;
alpha = 0.5;
tau = 0;
varargin = {beta_0, alpha, tau};
schedule = getSchedule('sublinear');

%% Initial coloring
% x = randsample(q, N, true);

%visualizeGraph(G, x, 'Original graph');
%export_fig('/tmp/original.pdf');  % High-quality figure for report
%return;

%% Metropolis

n = 5000;  % Number of iterations
x = randsample(q, N, true);

current_energy = H(G, x);
energies = zeros(n, 1);

% Metropolis iteration
tic;
for i=1:n
    v = randsample(N,1);              % Selected vertex
    v_c = randsample(q-1,1);          % New color
    if v_c >= x(v), v_c = v_c+1; end  % Assign color different from current
    x_new = x;
    x_new(v) = v_c;
    
    new_energy = H(G, x_new);
    delta_E = new_energy - current_energy;      % Energy difference
    beta = schedule(i, n, varargin{:});
    % Accept if lower energy or with acceptance probability:
    accept = rand(1) <= min(1, exp(-beta * delta_E));

    if accept
        x = x_new;
        current_energy = new_energy;
    end
    
    energies(i) = current_energy;
    
    if current_energy == 0
        fprintf('Proper coloring found! ');
        break;
    end
end
toc;

%% Show results
% TODO: export properly colored graph and energy plot
figure('Color',[1.0 1.0 1.0]);
plot(energies(1:i), 'LineWidth', 2);
title(sprintf('Evolution of cost over time (N = %d nodes, c = %d, q = %d)', N, c, q), 'FontSize', 16);
xlabel('Iterations', 'FontSize', 16); ylabel('Cost', 'FontSize', 16);
export_fig('/tmp/random-walk-example.pdf')