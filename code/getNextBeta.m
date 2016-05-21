function beta = getNextBeta(i, n, varargin)
    % We add our inverse temperature update schedule here
    % i: Current time
    % n: Number of iterations
    beta = 0.2+i/n;
end