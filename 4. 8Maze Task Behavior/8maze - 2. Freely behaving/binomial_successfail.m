function [phat,pci] = binomial_successfail(datas,dataf)
% Author: James Hope, Biosensing and Biorobotics Lab, 
% Department of Mechanical Engineering, University of Minnesota
% Contact: suhasabk@umn.edu


for n = 1:size(datas,1)
    ts = ones(datas(n,5),1);
    tf = zeros(dataf(n,5),1);
    tc = [ts;tf];
    [phat_n,pci_n] = binofit(sum(tc),length(tc));
    clear tc gc
    phat(n,:) = phat_n;
    pci(n,:) = pci_n';
end

figure
hold on
for n = 1:size(datas,1)
    plot([n n],[pci(n,:)].*100,'k')
    scatter(n,phat(n,1).*100,100,'o','filled','MarkerEdgeColor','k','MarkerFaceColor','k')
end
xlim([0 9])
ylim([0 100])
xlabel('session')
ylabel('success (%)')
title('Clopper-Pearson binomial')

end

