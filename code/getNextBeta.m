function beta = getNextBeta(i,n,varargin)
    % We add our inverse temperature update schedule here
    beta = 0.2+3*i/n;
end