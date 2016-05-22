function schedule = getSchedule( schedule_id)
%GETSCHEDULE Returns the function handle corresponding to schedule_id

switch schedule_id
    case 'constant'
        schedule = @constantBeta;
    case 'linear'
        schedule = @linearBeta;
    case 'exponential'
        schedule = @exponentialBeta;
    case 'logarithmic'
        schedule = @logarithmicBeta;
    case 'polynomial'
        schedule = @polynomialBeta;
    case 'adaptive'
        schedule = @adaptiveExponentialBeta;
    otherwise
        sprintf('Unrecognized schedule %s', schedule_id)


end

