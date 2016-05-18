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