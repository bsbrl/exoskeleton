function [Resultslog,Blog] = reduce_torque_range(Results,Bstore,torquelim,plott)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


Bscope = prctile(max(Results(:,:,1)')',torquelim); 
Blog = Bstore.*(max(Results(:,:,1)')'<Bscope)'; 
Blog(Blog==0) = [];
Blog = reshape(Blog,size(Bstore,1),[]);
% 
Resultslog = Results.*(max(Results(:,:,1)')'<Bscope); 
Resultslog(Resultslog==0) = [];
Resultslog = reshape(Resultslog,[], size(Results,2),size(Results,3));

if plott == 1
    yyaxis left
    semilogy(max(Resultslog(:,:,1)')','x-')
    hold on
    semilogy(max(Resultslog(:,:,6)')','o-')
    hold on
    semilogy(max(Resultslog(:,:,2)')','.--')
    hold on
    semilogy(min(Resultslog(:,:,3)')','*--')
    title('Reduced parameter set: max motor torque and sing. val. range')
    ylabel('torque (Nm), velocity (rad/s), or singular value (a.u.)')
    xlabel('design iteration')
    yyaxis right
    plot(Blog(1,:),'-','color',[0.8500 0.3250 0.0980])
    hold on
    plot(Blog(3,:),'-','color',[0.9290 0.6940 0.1250])
    hold on
    plot(Blog(4,:),'-','color',[0.4660 0.6740 0.1880])
    ylabel('dimension (m) of Rf, Lp, Ld')
    legend('Torque (minimise)','Motor velocity (minimise)', 'max {\sigma}J (minimise)','min {\sigma}J (maximise)','Rf','Lp','Ld')
end


end

