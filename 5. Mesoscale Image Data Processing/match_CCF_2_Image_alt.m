function [imagepad,BWimtran,szdiff] = match_CCF_2_Image_alt(BW,imageData,transform)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

    BW = imrotate(BW,transform(1,3));

    % pad image boundaries to contain even number of rows and columns
    if mod(size(imageData,1),2) == 1
        imageData = padarray(imageData,[1,0],0,'post');
    end
    if mod(size(imageData,2),2) == 1
        imageData = padarray(imageData,[0,1],0,'post');
    end

    %% note on anatomical landmark locations in CCF
    % bregma = [570,528] (X,Y or row,col)  
    % lambda = [570,938] (X,Y or row,col)


    %% image scale
    ccfscale = 100;     % pixels/mm
    imscale = 2056/7;   % pixels/mm

    % rescale ccf boundaries
    BWim = imresize(BW,round(imscale/ccfscale),'nearest'); 
    % pad CCF boundaries to contain even number of rows and columns
    if mod(size(BWim,1),2) == 1
        BWim = padarray(BWim,[1,0],0,'post');
    end
    if mod(size(BWim,2),2) == 1
        BWim = padarray(BWim,[0,1],0,'post');
    end

    %% zeropad and overlay
%     clear BWimtran
%     % move image relative to boundaries
%     transform = [-280, -60];     % [up/down, left/right] 

    if transform(1,1) < 0
        BWimtran = padarray(BWim,[abs(transform(1,1)),0],0,'post');
    elseif transform(1,1) > 0
        BWimtran = padarray(BWim,[abs(transform(1,1)),0],0,'pre');
    else
        BWimtran = BWim;
    end

    if transform(1,2) < 0
        BWimtran = padarray(BWimtran,[0,abs(transform(1,2))],0,'post');
    elseif transform(1,2) > 0
        BWimtran = padarray(BWimtran,[0,abs(transform(1,2))],0,'pre');
    else
        BWimtran = BWimtran;  
    end

    szdiff = size(BWimtran) - size(imageData);
    szdiff = szdiff./2;
    imagepad = padarray(imageData,[szdiff],0,'both');





end

