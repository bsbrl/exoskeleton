function [data] = mean_std(M1,M2,M3,M4,M5)

for n = 1:40
    if n < size(M1,1)+1
        temp(1,n) = M1(n,1);
    end
    if n < size(M2,1)+1
        temp(2,n) = M2(n,1);
    end
    if n < size(M3,1)+1
        temp(3,n) = M3(n,1);
    end
    if n < size(M4,1)+1
        temp(4,n) = M4(n,1);
    end
    if nargin > 4
        if n < size(M5,1)+1
           temp(5,n) = M5(n,1);
        end
    end
end

for n = 1:size(temp,2)
    temp2 = temp(:,n);
    temp2(temp2 == 0) = [];
    data(n,1) = mean(temp2);
    data(n,2) = std(temp2);
    data(n,3) = max(temp2);
    data(n,4) = min(temp2);
    data(n,5) = sum(temp2); % total number of trials in session
    data(n,6) = size(find(temp(:,n)),1); % number of mice in session
end


end

