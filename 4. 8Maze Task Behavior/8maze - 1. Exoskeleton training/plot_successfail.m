function [datas,dataf] = plot_successfail(Eightmaze,n)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% total number of turns
M1d = [length(Eightmaze.M1D1.d);...
      length(Eightmaze.M1D2.d);...
      length(Eightmaze.M1D3.d);...
      length(Eightmaze.M1D4.d);...
      length(Eightmaze.M1D5.d);...
      length(Eightmaze.M1D6.d);...
      length(Eightmaze.M1D7.d);...
      length(Eightmaze.M1D8.d)];
  
M2d = [length(Eightmaze.M2D1.d);...
      length(Eightmaze.M2D2.d);...
      length(Eightmaze.M2D3.d);...
      length(Eightmaze.M2D4.d);...
      length(Eightmaze.M2D5.d)]; 

M3d = [length(Eightmaze.M3D1.d);...
      length(Eightmaze.M3D2.d);...
      length(Eightmaze.M3D3.d);...
      length(Eightmaze.M3D4.d);...
      length(Eightmaze.M3D5.d);...
      length(Eightmaze.M3D6.d);...
      length(Eightmaze.M3D7.d);...
      length(Eightmaze.M3D8.d)];
  
M4d = [length(Eightmaze.M4D1.d);...
      length(Eightmaze.M4D2.d);...
      length(Eightmaze.M4D3.d);...
      length(Eightmaze.M4D4.d);...
      length(Eightmaze.M4D5.d)]; 
  
M5d = [length(Eightmaze.M5D1.d);...
      length(Eightmaze.M5D2.d);...
      length(Eightmaze.M5D3.d);...
      length(Eightmaze.M5D4.d);...
      length(Eightmaze.M5D5.d)]; 

  % number of successful turns
M1s = [sum(Eightmaze.M1D1.success);...
      sum(Eightmaze.M1D2.success);...
      sum(Eightmaze.M1D3.success);...
      sum(Eightmaze.M1D4.success);...
      sum(Eightmaze.M1D5.success);...
      sum(Eightmaze.M1D6.success);...
      sum(Eightmaze.M1D7.success);...
      sum(Eightmaze.M1D8.success)];
  
M2s = [sum(Eightmaze.M2D1.success);...
      sum(Eightmaze.M2D2.success);...
      sum(Eightmaze.M2D3.success);...
      sum(Eightmaze.M2D4.success);...
      sum(Eightmaze.M2D5.success)]; 

M3s = [sum(Eightmaze.M3D1.success);...
      sum(Eightmaze.M3D2.success);...
      sum(Eightmaze.M3D3.success);...
      sum(Eightmaze.M3D4.success);...
      sum(Eightmaze.M3D5.success);...
      sum(Eightmaze.M3D6.success);...
      sum(Eightmaze.M3D7.success);...
      sum(Eightmaze.M3D8.success)];
  
M4s = [sum(Eightmaze.M4D1.success);...
      sum(Eightmaze.M4D2.success);...
      sum(Eightmaze.M4D3.success);...
      sum(Eightmaze.M4D4.success);...
      sum(Eightmaze.M4D5.success)]; 
  
M5s = [sum(Eightmaze.M5D1.success);...
      sum(Eightmaze.M5D2.success);...
      sum(Eightmaze.M5D3.success);...
      sum(Eightmaze.M5D4.success);...
      sum(Eightmaze.M5D5.success)]; 

  % convert to % success
  
    M1p = M1s./M1d.*100;
    M2p = M2s./M2d.*100;
    M3p = M3s./M3d.*100;
    M4p = M4s./M4d.*100;
    M5p = M5s./M5d.*100;

    figure
    hold on
    plot(M1p,'-','Color',[0.4660 0.6740 0.1880])
    plot(M2p,'-','Color',[0.4660 0.6740 0.1880])
    plot(M3p,'-','Color',[0.4660 0.6740 0.1880])
    plot(M4p,'-','Color',[0.4660 0.6740 0.1880])
    plot(M5p,'-','Color',[0.4660 0.6740 0.1880])
  
    % find trend
    x = [[1:length(M1p)],[1:length(M2p)],[1:length(M3p)],[1:length(M4p)],[1:length(M5p)]];
    y = [M1p;M2p;M3p;M4p;M5p]';
    p = polyfit(x,y,n);
    x1 = 1:8;
    y1 = polyval(p,x1);
    plot(x1,y1,'-','Color',[0.4660 0.6740 0.1880],'LineWidth',4)
    
    [data] = mean_std(M1p,M2p,M3p,M4p,M5p);
    hold on
    plot(data(:,1),'-','Color',[0.4660 0.6740 0.1880],'LineWidth',4)
    
    [datas] = mean_std(M1s,M2s,M3s,M4s,M5s);
    [dataf] = mean_std([M1d-M1s],[M2d-M2s],[M3d-M3s],[M4d-M4s],[M5d-M5s]);
    
    
    xlabel('session')
    ylabel('success rate (%)')
    
end
