function [X,E] = competition(competitionDataPath, competitionOutputPath, maxIterations)
% COMPETITION Find colorings with low energy for the Random Walks competition
%   run from commandline as 
%       matlab -nodisplay -r "competition('../data/RW2016.mat','../data',1000);"

    discretized = 1;

    if nargin<3
        maxIterations = 10000;
    end
    if nargin<2
        competitionOutputPath = '../data';
    end
    if nargin<1
        competitionDataPath = '../data/RW2016.mat';
    end
        
    warning('off','MATLAB:DELETE:FileNotFound');
    
    % Logarithmic
    beta_0 = 10;
    alpha = 1;
    tau = 0;
    scheduleArgs = {beta_0, alpha, tau};
    schedule = getSchedule('logarithmic');
    
    competitionData = load(competitionDataPath);
    i=1;
    minEnergy = Inf;
    while true
        fprintf('Attempt %d... ', i);
        % TODO: allow a *very large* number of iterations and save results
        % even before that max number of iterations is reached (requires
        % putting all the loops in one file though).
        [X, E] = findColoring(competitionData.A, competitionData.q, ...
                              maxIterations, discretized, ...
                              schedule, scheduleArgs, competitionOutputPath);
        if E < minEnergy
            save(sprintf('%s/ThunderDucks_E=%d.mat',competitionOutputPath,E), 'X', 'E');
            % Don't delete anything, just in case anything goes wrong
            %try
            %    delete(sprintf('%s/ThunderDucks_E=%d.mat',competitionOutputPath,minEnergy));
            %catch                
            %end
            minEnergy = E;
        end
        fprintf('Energy: %d', E);
        if minEnergy==E
            fprintf(' !!!');
        end
        fprintf('\n');
        i=i+1;
    end
end