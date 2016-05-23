function beta = exponentialBeta( i ,varargin )
%LINEAR Exponential increase of beta 
%
%   \beta(t) = \beta_0 * \alpha ^ {-t}, 0 < \alpha < 1 
%
%   varargin{1}: Coefficient \beta_0
%   varargin{2}: Base \alpha
%   varargin{3}: Time delay \tau

    beta_0 = varargin{1};
    alpha = varargin{2};
    tau = varargin{3};
    beta = beta_0 * alpha .^ (-(i - tau));

end

