function beta = adaptiveExponentialBeta( i, n, varargin)
%ADAPTIVEEXPONENTIALBETA Same as exponentialBeta, except that the base
% \alpha depends on the time as well.
    
    tau = varargin{3};
    varargin{2} = 1 ./ (i - tau); % \alpha(t) = 1 / t
    beta = exponentialBeta(i, n, varargin{:});

end

