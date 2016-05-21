function beta = logarithmicBeta( i, n ,varargin )
%LINEAR Linear increase of beta 
%
%   \beta(t) = \beta_0 * \log(t + \tau), \tau > 1 
%
%   varargin{1}: Coefficient \beta_0
%   varargin{2}: Base \alpha
%   varargin{3}: Exponent coefficient \delta

    beta_0 = varargin{1};
    tau = varargin{2};
    beta = beta_0 * log(i + tau);

end

