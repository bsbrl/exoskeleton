function [data] = mean_std(M1,M2,M3,M4,M5,M6,M7,M8)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% calculate stats on vectors (num trials) of different length
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
    if n < size(M5,1)+1
        temp(5,n) = M5(n,1);
    end
    if n < size(M6,1)+1
        temp(6,n) = M6(n,1);
    end
    if n < size(M7,1)+1
        temp(7,n) = M7(n,1);
    end
    if n < size(M8,1)+1
        temp(8,n) = M8(n,1);
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

