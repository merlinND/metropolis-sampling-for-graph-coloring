function [ ] = plotSchedules( schedules )
%PLOTSCHEDULESF Summary of this function goes here
%   Detailed explanation goes here

figure; hold on;
x = linspace(0, 1, 1000);
legends = {};
for k = 1:length(schedules)
    schedule_id = schedules{k, 1};
    schedule = getSchedule(schedule_id);
    scheduleArgs = schedules{k, 2};
    plot(x, schedule(x, scheduleArgs{:}));
    legends{end+1} = sprintf('%s', schedules{k, 1});
end;
title('Schedules for \beta(t)', 'FontSize', 16); xlim([0 1]);
xlabel('Relative time (t)', 'FontSize', 16); ylabel('Inverse temperature (\beta)', 'FontSize', 16);
legend(legends, 'Location', 'NorthWest', 'FontSize', 16);
set(gcf,'color','w');
savefig('schedules_shape.fig');
export_fig('/tmp/schedules_shape.pdf');


end
