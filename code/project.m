%% Random Walks SS2016 - Simmulated Annealing for Graph Coloring
clear vars
close all
%rng(26);
addpath(genpath('lib'));

competition_path = 'RW2016.mat';


%% Setup

% Generate test adjacency matrix
N = 100;             % Number of edges
q = 5;              % Number of colors
beta = 0.2;         % Inverse temperature
c = 3;              % Density

% Erdos-Renyi graph
G = randomGraph(N, c);

%% Initial coloring
x = randsample(q, N, true);

visualizeGraph(G, x, 'Original graph');
export_fig('/tmp/original.pdf');  % High-quality figure for report
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
    beta = getNextBeta(i,n);
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

% TODO: export properly colored graph and energy plot
figure;
plot(energies(1:i));
title('Energy'); xlabel('Iterations'); ylabel('Cost');
    