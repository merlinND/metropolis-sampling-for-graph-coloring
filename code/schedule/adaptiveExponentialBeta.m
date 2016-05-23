function beta = adaptiveExponentialBeta( i, varargin)
%ADAPTIVEEXPONENTIALBETA Same as exponentialBeta, except that the base
% \alpha depends on the time as well.
    
    tau = varargin{3};
    varargin{2} = 1 ./ (i - tau); % \alpha(t) = 1 / t
    beta = exponentialBeta(i, varargin{:});

end

