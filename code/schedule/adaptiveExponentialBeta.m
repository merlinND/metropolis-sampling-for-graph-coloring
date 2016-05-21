function beta = adaptiveExponentialBeta( i, n, varargin)
%ADAPTIVEEXPONENTIALBETA Same as exponentialBeta, except that the base
% \alpha depends on the time as well.
    
    c = 2;
    varargin{3} = c / i; % \alpha(t) = c / t
    beta = exponentialBeta(i, n, varargin{:});

end

