function [iscell] = Remove_noisy_cells(dff_Data,iscell,genplot,stat)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% apply exclusion criteria to remove noisy cells

cperp = 100;

m = 1;
n = 1;
for i = 1:size(iscell,1)
    if iscell(i,1) == 1
        if m > cperp
            if genplot == 1
                figure
            end
            m = 1;
            n = n+1;
        else 
            m = m+1;
        end
        if(iscell(i,1)) == 1 
            maxdff = max(dff_Data(i,:));
            noisedff = std(dff_Data(i,:));
            meandff = mean(dff_Data(i,:));
            dat_npix = double(stat{1,i}.npix);
            dat_aspect = double(stat{1,i}.aspect_ratio); 
            
            if 3*double(noisedff) > double(maxdff)
                iscell(i,1) = 0;
            elseif double(noisedff) > 0.5
                iscell(i,1) = 0;          
            elseif double(maxdff) < 0.2
                iscell(i,1) = 0;
            elseif double(maxdff) > 5
                iscell(i,1) = 0;
            elseif dat_npix < 20
                iscell(i,1) = 0;
%                 'dat_npix < 20'
            elseif dat_npix > 400
                iscell(i,1) = 0;
%                 'dat_npix > 400'
            elseif dat_aspect > 1.4
                iscell(i,1) = 0;
%                 'dat_aspect > 1.4'
            elseif dat_aspect < 0.7
                iscell(i,1) = 0;
%                 'dat_aspect < 0.7'
            elseif genplot == 1
                plot(dff_Data(i,:)+1*m);
                hold on;
                % label the electrode
                electrode_label = strcat('Cell ', num2str(i));
                text(size(dff_Data,2),1*m,electrode_label)
            end
        end

    end
end

end

