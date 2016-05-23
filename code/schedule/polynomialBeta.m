function beta = polynomialBeta( i ,varargin )
%LINEAR Polynomial increase of beta 
%
%   \beta(t) = \beta_0 * t ^ \alpha
%
%   varargin{1}: Coefficient \beta_0
%   varargin{2}: Exponent \alpha
%   varargin{3}: Time delay \tau

    beta_0 = varargin{1};
    alpha = varargin{2};
    tau = varargin{3};
    beta = real((beta_0 * (i - tau)) .^ alpha);

end

