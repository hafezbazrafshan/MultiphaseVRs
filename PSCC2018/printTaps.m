CurrentDirectory=pwd;
cd('/Users/hafez/Documents/MATLAB/ThreePhaseVRs/three-phase-vr/Journal submission/IEEE 37-bus branch flow model/Results/');
IEEE37=load('FinalRun'); 
BYI=IEEE37.CvxNetworkBYISolved.Branch.Wye3PhiTaps;
BYG=IEEE37.CvxNetworkBYGSolved.Branch.Wye3PhiTaps;
CYG=IEEE37.CvxNetworkCYGSolved.Branch.Wye3PhiTaps; 
BYM=IEEE37.CvxNetworkBYMIESolved.Branch.Wye3PhiTaps; 
BCM=IEEE37.CvxNetworkBCMIESolved.Branch.ClosedDeltaTaps;
BOM=IEEE37.CvxNetworkBOMIESolved.Branch.OpenDeltaTaps;

cd(CurrentDirectory); 

FileName=['TapsPrinted','.txt'];
FileID=fopen(FileName,'w');
fprintf(FileID,' %-20s & %-20s  & %-20s & %-20s  %-20s  & %-20s  & %-20s\n',...
 'Method', 'YIB', 'YGB','YGC','YIMB','YIMC','YIMO');
fprintf(FileID,' %-20s & %-20s  & %-20s & %-20s  %-20s  & %-20s  & %-20s\n', ...
    '37-1', [num2str(BYI(1,1)), ',',num2str(BYI(2,1)),',',num2str(BYI(3,1))],...
    [num2str(BYG(1,1)), ',',num2str(BYG(2,1)),',',num2str(BYG(3,1))],...
   [num2str(CYG(1,1)), ',',num2str(CYG(2,1)),',',num2str(CYG(3,1))],...
  [num2str(BYM(1,1)), ',',num2str(BYM(2,1)),',',num2str(BYM(3,1))],...
  [num2str(BCM(1,1)), ',',num2str(BCM(2,1)),',',num2str(BCM(3,1))],...
  [num2str(BOM(1,1)), ',',num2str(0),',',num2str(BOM(2,1))]);
fclose(FileID);