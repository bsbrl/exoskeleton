function [] = colormaps_of_dff(iscell_dff,stat)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

    % cell activity 
    cells_activity = zeros(2056,2464);

    normscale = max(max(iscell_dff(:,4:7)));

    for n = 1:length(iscell_dff)
        if(iscell_dff(n,1)) == 1 
            pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]'];       
            for m = 1:length(pixels)

                cells_activity(pixels(m,2),pixels(m,1)) = iscell_dff(n,4)./normscale;
            end
            clear pixels
        end
    end

    cells_activity = imrotate(cells_activity,-90);

    figure
    subplot(2,2,1)
    imagesc(cells_activity)
    % colormap(colscale)
    colormap(hot)
    title('Dzone normalized activity')
    axis off

    %
    cells_activity = zeros(2056,2464);
    for n = 1:length(iscell_dff)
        if(iscell_dff(n,1)) == 1 
            pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]'];       
            for m = 1:length(pixels)

                cells_activity(pixels(m,2),pixels(m,1)) = iscell_dff(n,5)./normscale;
            end
            clear pixels
        end
    end

    cells_activity = imrotate(cells_activity,-90);

    subplot(2,2,2)
    imagesc(cells_activity)
    % colormap(colscale)
    colormap(hot)
    title('Loop normalized activity')
    axis off

    %
    cells_activity = zeros(2056,2464);
    for n = 1:length(iscell_dff)
        if(iscell_dff(n,1)) == 1 
            pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]'];       
            for m = 1:length(pixels)

                cells_activity(pixels(m,2),pixels(m,1)) = iscell_dff(n,6)./normscale;
            end
            clear pixels
        end
    end

    cells_activity = imrotate(cells_activity,-90);

    subplot(2,2,3)
    imagesc(cells_activity)
    % colormap(colscale)
    colormap(hot)
    title('Still normalized activity')
    axis off

    %
    cells_activity = zeros(2056,2464);
    for n = 1:length(iscell_dff)
        if(iscell_dff(n,1)) == 1 
            pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]'];       
            for m = 1:length(pixels)

                cells_activity(pixels(m,2),pixels(m,1)) = iscell_dff(n,7)./normscale;
            end
            clear pixels
        end
    end

    cells_activity = imrotate(cells_activity,-90);

    subplot(2,2,4)
    imagesc(cells_activity)
    % colormap(colscale)
    colormap(hot)
    title('Moving normalized activity')
    axis off

    %
    cells_activity = zeros(2056,2464);
    for n = 1:length(iscell_dff)
        if(iscell_dff(n,1)) == 1 
            pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]'];       
            for m = 1:length(pixels)

                cells_activity(pixels(m,2),pixels(m,1)) = (iscell_dff(n,4) - iscell_dff(n,8))./normscale;
            end
            clear pixels
        end
    end

    cells_activity = imrotate(cells_activity,-90);
    cells_activity(cells_activity < 0) = 0;

    figure
    imagesc(cells_activity)
    % colormap(colscale)
    colormap(hot)
    title('Preferential firing in turning zone (normalized activity)')
    axis off

    % [cells_activity_col,~] = match_CCF_2_Image_alt(CCF,cells_activity,transform);

    % imcol = cells_activity_col + double(BWimtran)./3000;
    % imcol(imcol>1) = 1;
    % figure
    % imshow(imcol)
    % % colormap(colscale)
    % colormap(hot)
    % title('Preferential firing in turning zone (normalized activity)')
    % axis off

    %
    cells_activity = zeros(2056,2464);
    for n = 1:length(iscell_dff)
        if(iscell_dff(n,1)) == 1 
            pixels = [[stat{1,n}.xpix]',[stat{1,n}.ypix]'];       
            for m = 1:length(pixels)

                cells_activity(pixels(m,2),pixels(m,1)) = (iscell_dff(n,8) - iscell_dff(n,4))./normscale;
            end
            clear pixels
        end
    end

    cells_activity = imrotate(cells_activity,-90);
    cells_activity(cells_activity < 0) = 0;

    figure
    imagesc(cells_activity)
    % colormap(colscale)
    colormap(hot)
    title('Preferential firing in loop (normalized activity)')
    axis off

    % [cells_activity_col,~] = match_CCF_2_Image_alt(CCF,cells_activity,transform);
    % 
    % imcol = cells_activity_col + double(BWimtran)./3000;
    % imcol(imcol>1) = 1;
    % figure
    % imagesc(imcol)
    % % colormap(colscale)
    % colormap(hot)
    % title('Preferential firing in loop (normalized activity)')
    % axis off


end

