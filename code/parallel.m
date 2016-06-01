%% Random Walks course competition
% Idea: run several independent walks (same graph, but different starting
% points) in order to max-out the CPU usage.

addpath(genpath('./lib'));
addpath(genpath('schedule'));

%%
nThreads = 4;
maxIterations = 1e6;
inputPath = '../data/RW2016.mat';

parfor threadId = 1:nThreads
    outputPath = sprintf('../competition-data/%d/', threadId);
    mkdir(outputPath);
    
    competition(inputPath, outputPath, maxIterations);
end;
