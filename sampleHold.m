
% Sarah Thompson 
% 04-20-2017

% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

            % sample and hold simulation %

% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

                      % Inputs %

%  ** samplePeriod is an integer multiple of your original 
%  sample period. 

%  (If you sampled your original analog data
%  at 20us intervals and your samplePeriod input is 50, 
%  plot(sampled) will show you what you could expect to
%  see if you were to sample your analog data at 1000us
%  intervals.)

% ** data should be a 1-D array of voltages

                     % Returns %
                     
% ** "sampled" is a 1-D array of voltages with same
%     shape and datatypes as original "data" input
% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

function sampled = sampleHold(data, samplePeriod)
    stop = length(data);
    current_index = 1;
    while current_index < stop
        hold_indices = (current_index:samplePeriod + current_index);
        hold_value = data(current_index);
        data(hold_indices) = hold_value;
        current_index = current_index + samplePeriod + 1;
    end
    sampled = data;
    end
    