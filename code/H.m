function value = H(G, x)
    % q-coloring energy function
    
    colored_graph = G*diag(x);              % Row i contains colors of vertices connected to i
    colored_reverse_graph = colored_graph';

    value = sum(colored_graph(G) == colored_reverse_graph(G))/2;
end