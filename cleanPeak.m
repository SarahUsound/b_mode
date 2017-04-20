% Sarah Thompson 
% 04-20-2017

% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

         % strip signal of large disturbance %

% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

                      % Inputs %

% ** data should be a 1-D array of voltages (works best
%     on absolute value data)

% ** T should be the duration of your target 
%     disturbace. For example, if the signal from 
%     your emitter pulse lasts for 5000 samples in 
%     this dataset, T should be 5000. 

                     % Returns %
                     
% ** "cleaned" is a 1-D array of voltages with same
%     shape/ length & datatypes as "data" input

% **  the section of cleaned identified to be the 
%      target disturbance based on your inputs will 
%      be set to constant amplitude 0. 
% -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 




function cleaned = cleanPeak(data, T)

x = data;
high_ind = (1:T);
low_ind = ((T+1):length(x));
x(low_ind) = 0;
x(high_ind) = 1;

r = xcorr(data, x);
[pk, im] = max(r);
im = im - length(x);
is = im - T;
ie = im + T;
strip = data;
stripIndices = (is:ie);
strip(stripIndices) = 1E-9;

cleaned = double(strip);

end





