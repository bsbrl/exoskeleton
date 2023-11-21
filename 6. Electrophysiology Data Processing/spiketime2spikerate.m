function [spike_rate,spike_rate_t] = spiketime2spikerate(spike_matrix,freq,win_s,winstep)

% sweep window through spike_matrix and calculate spike_rate
% NB this is a crude method, with low temporal and frequency resolution

tic

% win_s = 0.5;     % window length in seconds (determines lower freq limit)
win = win_s*freq; % (s*(S/s) = samples)
winstep = winstep*freq; % (s*(S/s) = samples)
zeropad = zeros(win,size(spike_matrix,2));
temp = [zeropad(1:win/2,:);spike_matrix;zeropad(win/2+1:end,:)];
m = 1;
for n = 1:winstep:length(temp)-win-1
    X = temp(n:n+win-1,:);  % slide window along spike matrix
    sumX = sum(X,1);                % sum spikes in window
    if sum(sumX) == 0
        spike_rate(m,:) = [zeros(1,size(spike_matrix,2))];
        spike_rate_t(m,1) = n;
        m = m+1;
    else                            % save time and spike rate
        spike_rate(m,:) = [sumX]./win_s;
        spike_rate_t(m,1) = n;
        m = m+1;
    end
end

% convert sum of spikes in spike rate
% spike_rate(isinf(spike_rate)|isnan(spike_rate)) = 0;
spike_rate_t = spike_rate_t./freq;

toc

end