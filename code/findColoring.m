function [ best_coloring, minimum_cost ] = findColoring( G, q, max_iterations, discretized, schedule, scheduleArgs )
%FINDCOLORING Find a proper coloring for graph G using q colors
%    Uses the Metropolis-Hastings sampling method, starting from a random
%    initial coloring, to find a proper coloring of G.
% Returns x (Nx1 vector), the coloring at with minimum cost found,
% as well as the associated cost.
    discSch = @(x) log(7*x+1) / log(8);

    if nargin < 3
        max_iterations = 5000;
    end;

    % Size of the graph
    N = size(G, 1);
    
    % Random initial coloring
    x = randsample(q, N, true);
    current_cost = H(G, x);
    minimum_cost = current_cost;
    best_coloring = x;

    % Metropolis iterations
    for i = 1:max_iterations
        v = randsample(N,1);              % Selected vertex
        v_c = randsample(q-1,1);          % New color
        if v_c >= x(v), v_c = v_c+1; end  % Assign color different from current
        x_new = x;
        x_new(v) = v_c;
        
        t = i / max_iterations;
        if discretized
            % Discretize the time to have steps
            t = discSch(t);
            binBounds = linspace(0,1,7);
            t = discretize(t, binBounds, binBounds(2:end));
        end
        
        new_cost = H(G, x_new);
        delta_E = new_cost - current_cost;      % Energy difference
        beta = schedule(t, scheduleArgs{:});
        % Accept if lower energy or with acceptance probability:
        accept = rand(1) <= min(1, exp(-beta * delta_E));

        if accept
            x = x_new;
            current_cost = new_cost;
        end
        
        if current_cost < minimum_cost
            minimum_cost = current_cost;
            best_coloring = x;
        end
        
        if current_cost == 0
            break;
        end
    end

end

