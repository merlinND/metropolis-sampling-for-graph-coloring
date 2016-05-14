function [ G ] = randomGraph( N, c )
%RANDOMGRAPH Generates an Erdos-Renyi random graph
%   N: number of edges
%   c: edge density
% Returns a adjacency matrix (NxN, symmetric, binary).

    % Erdos-Renyi graph
    G = rand(N) < c/N;  % Assign edges
    G = triu(G,1);      % Ensure symmetric
    G = G | G';

end

