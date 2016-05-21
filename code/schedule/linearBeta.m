function beta = linearBeta( i, n ,varargin )
%LINEAR Linear increase of beta 
%
%   \beta(t) = \beta_0 + \alpha * t, \alpha > 0 
%
%   varargin{1}: Offset \beta_0
%   varargin{2}: Slope \alpha

    beta_0 = varargin{1};
    alpha = varargin{2};
    beta = beta_0 + alpha * i;

end

