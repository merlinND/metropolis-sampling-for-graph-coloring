%% Random Walks SS2016 - Simmulated Annealing for Graph Coloring
clear vars
close all
%rng(26);
addpath(genpath('lib'));

%% Setup

% Generate test adjacency matrix
N = 1000;             % Number of edges
q = 50;              % Number of colors
beta = 0.2;         % Inverse temperature
c = 30;              % Density

% Erd\"os-R\'enyi graph
G = rand(N) < c/N;  % Assign edges
G = triu(G,1);      % Ensure symmetric
G = G | G';

%% Initial coloring
x = randsample(q,N,true);

visualizeGraph(G,x,'Original graph');
export_fig('/tmp/original.pdf');  % High-quality figure for report
%return;

%% Metropolis

n = 5000;  % Number of iterations
current_energy = H(G, x);

% Initialize optimization visualization
energies = zeros(n, 1);
figure; h = animatedline; xlim([1, n]); ylim([0, current_energy]);
title('Energy'); xlabel('Iterations'); ylabel('Cost');

% Metropolis iteration
tic;
for i=1:n
    v = randsample(N,1);              % Selected vertex
    v_c = randsample(q-1,1);          % New color
    if v_c >= x(v), v_c = v_c+1; end  % Assign color different from current
    x_new = x; x_new(v) = v_c;
    
    new_energy = H(G, x_new);
    delta_E = new_energy - current_energy;      % Energy difference
    beta = getNextBeta(i,n);
    % Accept if lower energy or with acceptance probability:
    accept = rand(1)<=min(1,exp(-beta*delta_E));

    if accept
        x = x_new;
        current_energy = new_energy;
    end
    
    % Update plot
    %addpoints(h, i, current_energy); drawnow;
    energies(i) = current_energy;
    
%     if current_energy==0
%         fprintf('Proper coloring found! ');
%         disp(x');
%         visualizeGraph(G,x,sprintf('Proper coloring %i',i));
    %else
    %    visualizeGraph(G,x,sprintf('Non proper coloring %i',i));
    %end
end
toc;
plot(energies);

    