%%
%%
load('FinalRun'); 
Wye3Phi=CvxNetworkYSolved;
ClosedDelta=CvxNetworkCSolved;
OpenDelta=CvxNetworkOSolved;
%%

x0=2;
y0=2;
width=8;
height=5;
figure1=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(figure1, 'Name', 'EigenValues');


NBuses=length(Wye3Phi.Bus.Names);
NBranches=length(Wye3Phi.Branch.BusToNumbers);
NewBusIndices=[38,1:37];
NewBranchNumbers=zeros(37,1);
for j=2:NBuses
    NewBranchNumbers(j-1)=find(Wye3Phi.Branch.BusToNumbers==NewBusIndices(j));
end



    h1=plot(1:NBranches, Wye3Phi.Optimization.Constraints.BranchConstraints.W3PhiLambdas(end-1,NewBranchNumbers)./...
        Wye3Phi.Optimization.Constraints.BranchConstraints.W3PhiLambdas(end-1,NewBranchNumbers)...
        , 'ks-','MarkerSize',10,'MarkerFaceColor','r'); 
    hold on

  h2=plot(1:NBranches, ClosedDelta.Optimization.Constraints.BranchConstraints.W3PhiLambdas(end-1,NewBranchNumbers)./...
        ClosedDelta.Optimization.Constraints.BranchConstraints.W3PhiLambdas(end-1,NewBranchNumbers), 'kd-','MarkerSize',10,'MarkerFaceColor','b');   
    hold on
h3=plot(1:NBranches, OpenDelta.Optimization.Constraints.BranchConstraints.W3PhiLambdas(end-1,NewBranchNumbers)./...
        OpenDelta.Optimization.Constraints.BranchConstraints.W3PhiLambdas(end-1,NewBranchNumbers), 'k^-','MarkerSize',10,'MarkerFaceColor','c'); 
     
    
      h4=plot(2, Wye3Phi.Optimization.Constraints.BranchConstraints.UPsi3PhiLambdas(end-1,NewBranchNumbers)./...
        Wye3Phi.Optimization.Constraints.BranchConstraints.UPsi3PhiLambdas(end-1,NewBranchNumbers), 's','MarkerSize',10,'MarkerFaceColor','r','LineWidth',4); 
    hold on

  h5=plot(2, ClosedDelta.Optimization.Constraints.BranchConstraints.UPsi3PhiLambdas(end-1,NewBranchNumbers)./...
        ClosedDelta.Optimization.Constraints.BranchConstraints.UPsi3PhiLambdas(end-1,NewBranchNumbers), 'd','MarkerSize',10,'MarkerFaceColor','b','LineWidth',4);   
    hold on
h6=plot(2, OpenDelta.Optimization.Constraints.BranchConstraints.UPsi3PhiLambdas(end-1,NewBranchNumbers)./...
        OpenDelta.Optimization.Constraints.BranchConstraints.UPsi3PhiLambdas(end-1,NewBranchNumbers), '^','MarkerSize',10,'MarkerFaceColor','c','LineWidth',4); 
     
    


    xlim([0 NBuses+2]);
    ylim([0 0.5]);
    grid on;
    grid minor;
		set(gca,'XTick', ([1,2:2:NBranches]).','YTick', [0:0.05:1] );
    set(gca,'XTickLabel',[2,3:2:NBranches+1].');
     ax = gca;
     ax.XAxis.MinorTick = 'on';
     ax.XAxis.MinorTickValues =[1:NBranches].';
	legendTEXT=legend('Wye (15e)', ' Closed-delta (15e)','Open-delta (15e)',...
    'Wye (15f)', ' Closed-delta (15f)','Open-delta (15f)');
    set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','Vertical'); 
set(legend,'location','East');
set(gca,'box','on');
    set(gca,'fontSize',14); 
set(0,'defaulttextinterpreter','latex')
ylabel('$\frac{\lambda^{2}}{\lambda^{1}}$','FontSize',28);
xlabel('Edges');


% 
% if exist('Figures')~=7
%     mkdir Figures;
% end
% 
% cd('Figures');
% print('EigenValues1','-dpdf','-fillpage');
% print('EigenValues1','-depsc2')
% cd('..');
