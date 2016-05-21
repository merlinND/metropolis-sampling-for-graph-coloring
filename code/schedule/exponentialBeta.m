function beta = exponentialBeta( i, n ,varargin )
%LINEAR Linear increase of beta 
%
%   \beta(t) = \beta_0 * \alpha ^ {- \delta * t), 0 < \alpha < 1 
%
%   varargin{1}: Coefficient \beta_0
%   varargin{2}: Base \alpha
%   varargin{3}: Exponent coefficient \delta

    beta_0 = varargin{1};
    c = varargin{2};
    alpha = varargin{3};
    delta = varargin{4};
    tau = varargin{5};
    beta = beta_0 + c * alpha ^ (- delta * (i - tau));

end

