function beta = linearBeta( i, varargin )
%LINEAR Linear increase of beta 
%
%   \beta(t) = \beta_0 + \alpha * t, \alpha > 0 
%
%   varargin{1}: Offset \beta_0
%   varargin{2}: Slope \alpha
%   varargin{3}: Time delay \tau

    beta_0 = varargin{1};
    alpha = varargin{2};
    tau = varargin{3};
    beta = max(beta_0, beta_0 + alpha * (i - tau));

end

