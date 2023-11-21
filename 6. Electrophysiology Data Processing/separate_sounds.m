function [milksound,leftsound,rightsound] = separate_sounds(sound,XYpos_global)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Process digital data identifying sounds in the 8maze

milksound = 0.*sound;
leftsound = 0.*sound;
rightsound = 0.*sound;

for n = 2:length(sound)
    if sound(n,1) == 1 && sound(n-1,1) == 0
        if XYpos_global(n,2) > 0 && abs(XYpos_global(n,1)) > 0.14
            milksound(n:n+25,1) = sound(n:n+25,1);
        elseif XYpos_global(n,2) < 0.05 && (XYpos_global(n,1)) > 0
            leftsound(n:n+300,1) = sound(n:n+300,1);
        elseif XYpos_global(n,2) < 0.05 && (XYpos_global(n,1)) < 0
            rightsound(n:n+300,1) = sound(n:n+300,1);
        end
    end
end

            
        figure
        plot(sound)
        hold on
        plot(milksound+1)
        hold on
        plot(leftsound+2)
        hold on
        plot(rightsound+3)
        legend('sound','milk sound','turn left sound', 'turn right sound')
        xlabel('time (a.u.')
        

end

