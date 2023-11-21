function [dataset] = load_ephys_data(path)
 % Author: Travis Beckerle , Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


% Load ephys data 

    % User input
    [file,path2file] = uigetfile(strcat(path,'*.bin'));
    file_decomp = strsplit(file,'_');
    location = find(strcmp(file_decomp, 'chan'));
    chan = str2double(cell2mat(file_decomp(location+1)));
    
    % Import spike data to workspace
    fprintf(1, 'Opening ephys datafile...\n');
    fid = fopen([path2file,'\',file]);
    data_spike = fread(fid,[chan, inf],'int16');
    fclose('all');
    
    % Import time and digital signal to workspace
    fprintf(1, 'Opening time/digin datafile...\n');
    file = cell2mat([file_decomp(1),'_',file_decomp(2),'_',file_decomp(3),'_',...
        file_decomp(4),'_',file_decomp(5),'_DigIn.dat']);
    fid = fopen([path2file,'\',file]);
    data_dig = fread(fid,[2, inf],'double');
    fclose('all');
    
    % Cobine information into one workspace variable named 'dataset'
    dataset = [data_dig(1,:)', data_spike', data_dig(2,:)'];
    fprintf(1, 'Done\n');
    
    % Clean up workspace
    clear file path2file chan fid ans file_decomp location count freq ...
        data_dig data_spike;


end