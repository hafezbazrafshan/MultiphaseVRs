clear all;
clc;
%% Constants
v0Mags=[1;1;1];
v0Phases=degrees2radians([0;-120;120]); 
vS=v0Mags.*exp(sqrt(-1)*v0Phases); 
VMIN=0.9;
VMAX=1.1;
RMIN=0.9;
RMAX=1.1;

%% 1. Deciding on regulator types
RegulatorType='Wye';
%% 2. Setting up initial network with default taps for wye
% if other regulator types, default taps are zero 
InitialNetwork=setupIEEE37(RegulatorType);
% InitialNetwork=load('IEEE13','InitialNetwork'); 
% InitialNetwork=InitialNetwork.InitialNetwork;
InitialNetwork.vS=vS;
InitialNetwork.VMIN=VMIN;
InitialNetwork.VMAX=VMAX;
InitialNetwork.RMIN=RMIN;
InitialNetwork.RMAX=RMAX;


%% 2. Setting up initial network with default taps for wye
% if other regulator types, default taps are zero 
RegulatorType='ClosedDelta';
InitialNetworkClosedDelta=setupIEEE37(RegulatorType);
InitialNetworkClosedDelta.vS=vS;
InitialNetworkClosedDelta.VMIN=VMIN;
InitialNetworkClosedDelta.VMAX=VMAX;
InitialNetworkClosedDelta.RMIN=RMIN;
InitialNetworkClosedDelta.RMAX=RMAX;


RegulatorType='OpenDelta';
InitialNetworkOpenDelta=setupIEEE37(RegulatorType);
InitialNetworkOpenDelta.vS=vS;
InitialNetworkOpenDelta.VMIN=VMIN;
InitialNetworkOpenDelta.VMAX=VMAX;
InitialNetworkOpenDelta.RMIN=RMIN;
InitialNetworkOpenDelta.RMAX=RMAX;





%% 3. Initial z-bus solve
disp('Solving initial load-flow');
[InitialNetwork]=zBusSolve(InitialNetwork);



%% 4. Optimization
[CvxNetworkY]=optimizeTapsCR(InitialNetwork);
[CvxNetworkC]=optimizeTapsCR(InitialNetworkClosedDelta);
[CvxNetworkO]=optimizeTapsCR(InitialNetworkOpenDelta);



[CvxNetworkYSolved]=zBusSolve(CvxNetworkY);
[CvxNetworkCSolved]=zBusSolve(CvxNetworkC);
[CvxNetworkOSolved]=zBusSolve(CvxNetworkO);








%% Print results
FileName=['ComparePowerIn','Scale1','.txt'];
if exist('Results')~=7
    mkdir('Results');
end
cd('Results');
save('FinalRun'); 
FileID=fopen(FileName,'w');
fprintf(FileID,' %-20s & %-20s  & %-20s & %-20s & %-20s & %-20s & %-20s & %-20s &  %-20s \n',...
   'Network', 'Method','Opt. Val.','Feas. Obj.','Acc.','VMin', 'VMax','L2/L1','CompTime');
cd('..');



printResultsPerIteration(FileID,InitialNetwork,'Default');
printResultsPerIteration(FileID,CvxNetworkYSolved,'Y');
printResultsPerIteration(FileID,CvxNetworkCSolved,'C');
printResultsPerIteration(FileID,CvxNetworkOSolved,'O');

% 