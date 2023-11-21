function [bipulsetiming,steps,bigpulse] = find_ref_pulse(data_dig,bigpw)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Find the long reference pulse(s) in exo and ephys data sets and use these
% to temporally align the two

% OUTPUTS
% bipulsetiming = [start time, end time] of each big pulse
% steps = [start time, end time] of each pulse
% bigpulse = logic array of big pulses vs small pulses

% Sweep through digital input finding rises and falls
% format of input: data_dig = [time, digital pulse]

m = 1;  % initialize pulse number to 1
sweepsize = 1;
for n = sweepsize:sweepsize:length(data_dig)-2*sweepsize
    if data_dig(n+sweepsize,2) < data_dig(n,2) % falls
        steps(m,1) = data_dig(n,1);  % store time of fall
    end
    if data_dig(n+sweepsize,2) > data_dig(n,2) % rises
        steps(m,2) = data_dig(n,1);  % store time of rise
        m = m+1;   % next pulse
    end
end

% calc pulse width
pulsewidth = steps(:,2) - steps(:,1); 

% figure
% plot(pulsewidth)
% xlabel('pulse number')
% ylabel('pulse width')

% find small pulses (typically 0.1 second width)
bigpulse = pulsewidth>bigpw;  % generate logic array of big pulses
bipulsetiming = bigpulse.*steps;  % element multiply data and logic array 
% remove small pulses
for n = length(bipulsetiming):-1:1
    if bipulsetiming(n,:) == [0 0]
        bipulsetiming(n,:) = [];
    end
end

end