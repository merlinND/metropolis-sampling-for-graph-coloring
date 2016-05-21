function beta = polynomialBeta( i, n ,varargin )
%LINEAR Linear increase of beta 
%
%   \beta(t) = \beta_0 * t ^ \alpha,
%
%   varargin{1}: Coefficient \beta_0
%   varargin{2}: Exponent \alpha

    beta_0 = varargin{1};
    alpha = varargin{2};
    beta = beta_0 * i ^ alpha;

end

