function [ value ] = H_slow( G, x )
%H_SLOW Summary of this function goes here
%   Detailed explanation goes here
        
    colored_graph = G*diag(x);              % Row i contains colors of vertices connected to i
    colored_reverse_graph = colored_graph';

    value = sum(colored_graph(G) == colored_reverse_graph(G))/2;

end

