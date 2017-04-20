
% Run this script to visualize a set of data corresponding 
%  to a single 2-D scan


f = @process;
pieFig('exampleData/', f, 2*pi, 25);

% Define any signal processing below
% at minimum, data should be converted to type double

% consider removing every other value to save time...
% ... applying median filter...
% ...finding virtual envelope...
% anything else you can think of

function x = process(x)
    x = double(x); % oscilloscope output is type single, pieFig requires double
    x = abs(x); % used here so that log10 returns real numbers
    x = log10(x); % used here to compress voltage scale so small peaks are visible
end
