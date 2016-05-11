%% Random Walks SS2016 - Simmulated Annealing for Graph Coloring
clear vars
close all
rng(26);

%% Setup

% Generate test adjacency matrix
N = 15;             % Number of edges
q = 5;              % Number of colors
beta = 0.2;         % Inverse temperature
c = 3;              % Density

% Erd\"os-R\'enyi graph
G = rand(N) < c/N;  % Assign edges
G = triu(G,1);      % Ensure symmetric -
G = G | G';

%% Initial coloring
x = randsample(q,N,true);

visualizeGraph(G,x,'Original graph');
%return;

%% Metropolis

n=35;  % Number of iterations

% Initialize optimization visualization
figure; h = animatedline; xlim([1,n]);
title('Energy'); xlabel('Iterations'); ylabel('Cost');

% Metropolis iteration
for i=1:n
    v = randsample(N,1);              % Selected vertex
    v_c = randsample(q-1,1);          % New color
    if v_c >= x(v), v_c = v_c+1; end  % Assign color different from current
    x_new = x;
    x_new(v) = v_c;
    
    delta = H(G,x_new) - H(G,x);      % Energy difference
    if delta <= 0                     % Accept if lower energy...
        x = x_new;
    else                              % ...or with acceptance probability
        beta = getNextBeta(i,n);
        accept = rand(1)<=exp(-beta*delta);
        if accept, x = x_new; end
    end
    
    current_energy = H(G,x);
    % Update plot
    addpoints(h, i, current_energy);
    drawnow;
    
    if current_energy==0
        fprintf('Proper coloring found! ');
        disp(x');
        visualizeGraph(G,x,sprintf('Proper coloring %i',i));
    %else
    %    visualizeGraph(G,x,sprintf('Non proper coloring %i',i));
    end
end