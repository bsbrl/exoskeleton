function [exo_data] = scale_exo_time(ephys_data,exo_data,fitorder)

% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% Find the long reference pulse(s) in exo and ephys data sets and use these
% to temporally align the two

    % Sweep through digital input finding rises and falls
    dig_in_ephys = ephys_data(:,[1,66]);
    % input: data_dig = [time, digital pulse], numerical value = greater than small pulse width
    [~,pulse_t_ephys,logic_ephys] = find_ref_pulse(dig_in_ephys,0.15);
    
    % Create time vector from loop time
    loop_time = exo_data(:,13)./1000;  % units = seconds
    time(1,1) = 0;
    for n = 2:length(loop_time)
        time(n,1) = loop_time(n,1) + time(n-1,1);  % units = seconds
    end
    % need to invert digital pulse in exo data
    dig_inv_exo = abs(exo_data(:,31)-1);
    dig_in_exo = [time, dig_inv_exo];
    
    [~,pulse_t_exo,logic_exo] = find_ref_pulse(dig_in_exo,0.15);
    
    % Check timing of pulses
    
    figure
    subplot(2,2,1)
    plot(pulse_t_ephys(:,2) - pulse_t_ephys(:,1))
    hold on
    plot(pulse_t_exo(:,2) - pulse_t_exo(:,1))
    xlabel('pulse number')
    ylabel('pulse width')
    legend('ephys','exo')
    title('pulse trains')
    
    % align pulse trains
    % find big pulse number in ephys pulse train
    bigpulseID_ephys = logic_ephys.*[1:1:length(logic_ephys)]';
    bigpulseID_ephys(bigpulseID_ephys==0)=[];
    % find big pulse number in exo pulse train
    bigpulseID_exo = logic_exo.*[1:1:length(logic_exo)]';
    bigpulseID_exo(bigpulseID_exo==0)=[];
    
    % determine how may pulses to remove from longer pulse train
    if bigpulseID_exo(1) > bigpulseID_ephys(1) % then more pulses at the start in exo pulse train
        diffID_exo = bigpulseID_exo(1) - bigpulseID_ephys(1) + 1;
        diffID_ephys = 1;
    else % more pulses at the start in ephys pulse train
        diffID_exo = 1;
        diffID_ephys = bigpulseID_ephys(1) - bigpulseID_exo(1) + 1;
    end
    
    pulse_t_ephys_clip = pulse_t_ephys(diffID_ephys:end,:);
    pulse_t_exo_clip = pulse_t_exo(diffID_exo:end,:);
    
    % plot aligned pulse trains
    subplot(2,2,2)
    plot(pulse_t_ephys_clip(:,2) - pulse_t_ephys_clip(:,1))
    hold on
    plot(pulse_t_exo_clip(:,2) - pulse_t_exo_clip(:,1))
    xlabel('pulse number')
    ylabel('pulse width')
    legend('ephys','exo')
    title('aligned pulse trains')
    
    % compare timing of all pulses
    % need to find the length of the shorter vector so that their times can be
    % subtracted from one another 
    if length(pulse_t_ephys_clip) > length(pulse_t_exo_clip)
        endID = length(pulse_t_exo_clip);
    else
        endID = length(pulse_t_ephys_clip);
    end
    
    pulse_t_diff = pulse_t_ephys_clip(1:endID,1) - pulse_t_exo_clip(1:endID,1);
    
    subplot(2,2,3)
    plot(pulse_t_diff)
    xlabel('pulse number')
    ylabel('pulse timing difference (seconds)')
    title('pulse timing drift')
    % subplot(2,2,4)
    % plot(pulse_t_exo_clip(1:endID,1),pulse_t_ephys_clip(1:endID,1))
    % xlabel('pulse times exo')
    % ylabel('pulse times ephys')
    
    % fit line to pule timing drift and create a scaled time vector for exo data 
    y = pulse_t_ephys_clip(1:endID,1);
    x = pulse_t_exo_clip(1:endID,1);
%      c = polyfit(x,y,2);
%      exo_time = (c(1)).*time.^2 + c(2).*time + c(3); 
%     c = polyfit(x,y,3);
%     exo_time = c(1).*time.^3 + c(2).*time.^2 + c(3)*time + c(4);


    c = polyfit(x,y,fitorder);
    for n = 1:fitorder
        temp(:,n) = c(n).*time.^(fitorder-n+1);
    end
    exo_time = sum(temp,2) + c(fitorder+1);
    

    % figure
    % plot(exo_time,dig_inv_exo)
    % hold on
    % plot(dig_in_ephys(:,1),dig_in_ephys(:,2))
    % ylim([-0.1 1.1])
    
    %
    [~,pulse_t_exo_scaled,~] = find_ref_pulse([exo_time,dig_inv_exo],0.15);
    
    pulse_t_exo_scaled_clip = pulse_t_exo_scaled(diffID_exo:end,:);
    
    pulse_t_diff = pulse_t_ephys_clip(1:endID,1) - pulse_t_exo_scaled_clip(1:endID,1);
    
    subplot(2,2,4)
    plot(pulse_t_diff)
    xlabel('pulse number')
    ylabel('pulse timing difference (seconds)')
    title('pulse timing drift after correction')
    
    %
     exo_data(:,32) = exo_time;



end