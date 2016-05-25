function value = H(adjI, adjJ, x)
    % q-coloring energy function
    
%     colored_graph = G*diag(x);              % Row i contains colors of vertices connected to i
%     colored_reverse_graph = colored_graph';
% 
%     slow_value = sum(colored_graph(G) == colored_reverse_graph(G))/2;
    
    value = 0;
    for i = 1:length(adjI)
        value = value + (x(adjI(i)) == x(adjJ(i)));
    end;
    value = value / 2;
    
    %assert(slow_value == value);
end