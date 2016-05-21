%% Random Walks course competition

% Idea: run several independent walks (same graph, but different starting
% points) in order to max-out the CPU usage.
nThreads = 8;
maxIterations = 10000;
inputPath = '../data/RW2016.mat';

parfor threadId = 1:nThreads
    % TODO: double & triple-check that no data is ever lost
    outputPath = sprintf('../competition-data/%d/', threadId);
    mkdir(outputPath);
    
    competition(inputPath, outputPath, maxIterations);
end;
