function beta = logarithmicBeta( i ,varargin )
%LINEAR Linear increase of beta 
%
%   \beta(t) = \beta_0 * \log(t + \alpha), \tau > 1 
%
%   varargin{1}: Coefficient \beta_0
%   varargin{2}: Offset \alpha
%   varargin{3}: Time delay \tau

    beta_0 = varargin{1};
    alpha = varargin{2};
    tau = varargin{3};
    if i < tau
        beta = beta_0;
    else
        beta = beta_0 * log(i + alpha);
    end
end

