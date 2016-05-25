function [ ] = plotSchedules( schedules )
%PLOTSCHEDULESF Summary of this function goes here
%   Detailed explanation goes here
discSch = @(x) log(7*x+1) / log(8);

figure; hold on;
x = linspace(0, 1, 1000);
legends = {};
for k = 1:length(schedules)
    schedule_id = schedules{k, 1};
    schedule = getSchedule(schedule_id);
    scheduleArgs = schedules{k, 2};

    newx = discSch(x);
    binBounds = linspace(0,1,10);
    newx = discretize(newx, binBounds, binBounds(2:end));
    betas = schedule(newx, scheduleArgs{:});

    plot(x, betas);
    legends{end+1} = sprintf('%s', schedules{k, 1});
end;
title('Schedules for \beta(t)', 'FontSize', 16); xlim([0 1]);
xlabel('Relative time (t)', 'FontSize', 16); ylabel('Inverse temperature (\beta)', 'FontSize', 16);
legend(legends, 'Location', 'NorthWest', 'FontSize', 16);
set(gcf,'color','w');
savefig('schedules_shape.fig');
export_fig('/tmp/schedules_shape.pdf');


end
