function [Pinc] = Minc2Pinc(temp)

if temp(1,1) == 0 && temp(1,2) == 0
    Pinc = [0 0];
else
    Pinc = temp./sum(temp).*100;
end


end

