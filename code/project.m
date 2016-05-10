%% Random Walks SS2016 - Simmulated Annealing for Graph Coloring
clear all
%%

% Generate test adjacency matrix
N = 20;             % Number of edges
q = 6;              % Number of colors
beta = 0.2;         % Inverse temperature
c = 5;             % Density

% Erd\"os-R\'enyi graph
G = rand(N) < c/N;  % Assign edges
G = triu(G,1);      % Ensure symmetric
G = G | G';
%disp(G)

% Check if number of edges is concentrated on c*N/2
fprintf('%d should be close to %d\n', sum(sum(G)), N*c);

%% Initial state
x = randsample(q,N,true);
%hist(x, q);  % Visualize distribution (uniform for large N)

%% Metropolis

n=2000;  % Number of iterations

% Visualization
figure;
h = animatedline;
xlim([1,n]);

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
        accept = rand(1)<=exp(-beta*delta);
        if accept
            x = x_new;
        end
    end
    
    current_energy = H(G,x);
    % Update plot
    addpoints(h, i, current_energy);
    drawnow;
    
    if current_energy==0
        fprintf('Proper coloring found \n');
        disp(x');
    end
end