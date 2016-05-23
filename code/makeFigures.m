% Scripts to generate figures to be used in the report
addpath(genpath('lib'));

%% Example random graphs with various densities

N = 50;             % Number of edges
q = 5;              % Number of colors
c = 20;              % Density

% Erdos-Renyi graph
G = randomGraph(N, c);
x = randsample(q, N, true);

str = sprintf('Random graph with random initial coloring (N = %d, c = %d, q = %d)', ...
              N, c, q);
visualizeGraph(G, x, str);
filename = sprintf('../figures/random-graph-%d-%d-%d.pdf', N, c, q);
export_fig(filename);  % High-quality figure for report
%return;

%% Initial (random) normalized cost w.r.t. graph density
nValues = [100, 500, 1000]; %linspace(1, 1000, 100);
q = 5;
cValues = 20;
costs = zeros(length(nValues), cValues);
for i = 1:length(nValues)
    N = nValues(i);
    cc = linspace(1, N, cValues);
    for j = 1:length(cc)
        c = cc(j);
        G = randomGraph(N, c);
        x = randsample(q, N, true);
        costs(i, j) = H(G, x) / N;
    end;
end;

figure;
plot(linspace(0, 1, cValues), costs, '+');

% Relationship:
% initialCost / N = c / (2 * q)

%% Max degree VS density

nValues = [500]; %linspace(1, 1000, 100);
cValues = 200;
maxDegrees = zeros(length(nValues), cValues);
for i = 1:length(nValues)
    N = nValues(i);
    cc = linspace(1, N, cValues);
    for j = 1:length(cc)
        c = cc(j);
        G = randomGraph(N, c);
        maxDegrees(i, j) = max(sum(G, 1));
    end;
end;

figure;
plot(linspace(0, 1, cValues), maxDegrees, '+');
