function [x,y,x1,y1,datapD,dataps,datapf] = plot_successfail_Dec_FB_finalday(FB_8maze,n)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu

% total number of wrong way trials 

M1w = [FB_8maze.M1D8D.wrongway];

M2w = [FB_8maze.M2D8D.wrongway];
  
M3w = [FB_8maze.M3D8D.wrongway];

M4w = [FB_8maze.M4D8D.wrongway]; 
  
M5w = [FB_8maze.M5D3D.wrongway];
  
M6w = [FB_8maze.M6D4D.wrongway];
  
M7w = [FB_8maze.M7D5D.wrongway];
  
M8w = [FB_8maze.M8D4D.wrongway];
  
  
% total incorrect trials
M1i = [FB_8maze.M1D8D.incorrect];

M2i = [FB_8maze.M2D8D.incorrect];
  
M3i = [FB_8maze.M3D8D.incorrect];

M4i = [FB_8maze.M4D8D.incorrect]; 
  
M5i = [FB_8maze.M5D3D.incorrect];
  
M6i = [FB_8maze.M6D4D.incorrect];
  
M7i = [FB_8maze.M7D5D.incorrect];
  
M8i = [FB_8maze.M8D4D.incorrect];
  
% total number of correct trials 
M1s = [FB_8maze.M1D8D.correct];

M2s = [FB_8maze.M2D8D.correct];
  
M3s = [FB_8maze.M3D8D.correct];

M4s = [FB_8maze.M4D8D.correct]; 
  
M5s = [FB_8maze.M5D3D.correct];
  
M6s = [FB_8maze.M6D4D.correct];
  
M7s = [FB_8maze.M7D5D.correct];
  
M8s = [FB_8maze.M8D4D.correct];

  M1p = M1s./(M1s+M1w+M1i).*100;
  M2p = M2s./(M2s+M2w+M2i).*100;
  M3p = M3s./(M3s+M3w+M3i).*100;
  M4p = M4s./(M4s+M4w+M4i).*100;
  M5p = M5s./(M5s+M5w+M5i).*100;
  M6p = M6s./(M6s+M6w+M6i).*100;
  M7p = M7s./(M7s+M7w+M7i).*100;
  M8p = M8s./(M8s+M8w+M8i).*100;
  
      % find trend
    x = [[1:length(M1p)],[1:length(M2p)],[1:length(M3p)],[1:length(M4p)],...
        [1:length(M5p)],[1:length(M6p)],[1:length(M7p)],[1:length(M8p)]];
    y = [M1p;M2p;M3p;M4p;M5p;M6p;M7p;M8p]';
    p = polyfit(x,y,n);
    x1 = 1:8;
    y1 = polyval(p,x1);
    [datapD] = mean_std(M1p,M2p,M3p,M4p,M5p,M6p,M7p,M8p);
    
%         figure
%         hold on
%         plot(M1p,'-','Color',[0.9290 0.6940 0.1250])
%         plot(M2p,'-','Color',[0.9290 0.6940 0.1250])
%         plot(M3p,'-','Color',[0.9290 0.6940 0.1250])
%         plot(M4p,'-','Color',[0.9290 0.6940 0.1250])
%         plot(M5p,'-','Color',[0.9290 0.6940 0.1250])
%         plot(M6p,'-','Color',[0.9290 0.6940 0.1250])
%         plot(M7p,'-','Color',[0.9290 0.6940 0.1250])
%         plot(M8p,'-','Color',[0.9290 0.6940 0.1250])
%         plot(x1,y1,'-','Color',[0.9290 0.6940 0.1250],'LineWidth',4)
%         ylim([0 100])
%         title('Decision making')
%         xlabel('session')
%         ylabel('success rate (%)')
%         hold on
%         plot(x1,datapD(:,1),'-','Color',[0.9290 0.6940 0.1250],'LineWidth',4)    
 
  
    [dataps] = mean_std(M1s,M2s,M3s,M4s,M5s,M6s,M7s,M8s);
    [datapf] = mean_std([M1w+M1i],[M2w+M2i],[M3w+M3i],[M4w+M4i],[M5w+M5i],[M6w+M6i],[M7w+M7i],[M8w+M8i]);   
    
    
end

