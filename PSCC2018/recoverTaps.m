%% 3. Solving for taps:
Wnn3Phi=full(Wnn3Phi);
WnnPrime3Phi=full(WnnPrime3Phi);




for r=1:NRegs3Phi
     RegBranchNumber=Branch.Regs3PhiBranchNumbers(r);
     
         
     rr=find(Branch.RegulatorBranchNumbers==RegBranchNumber);% which regulator number it is
   RegulatorType=Branch.RegulatorTypes{rr};
   clear rr
   
     m=Branch.BusToNumbers(RegBranchNumber); % secondary
     n=Branch.BusFromNumbers(RegBranchNumber); % primary
    nn=find(Bus.ThreePhaseBusNumbers==n);
    mm=find(Bus.ThreePhaseBusNumbers==m);
    

   
   switch RegulatorType
       case 'Wye'
% % 

ArA=sqrt(Wnn3Phi(1,1,nn)./WnnPrime3Phi(1,1,r));
ArB=sqrt(Wnn3Phi(2,2,nn)./WnnPrime3Phi(2,2,r));
ArC=sqrt(Wnn3Phi(3,3,nn)./WnnPrime3Phi(3,3,r));

Av=diag([ArA; ArB; ArC]);

TapA=floor((-ArA+1)./(0.00625));
TapB=floor((-ArB+1)./(0.00625));
TapC=floor((-ArC+1)./(0.00625));
% 
ArA=1-0.00625*TapA;
ArB=1-0.00625*TapB;
ArC=1-0.00625*TapC;
Av=diag([ArA; ArB; ArC]);

     rr=find(Branch.Wye3PhiBranchNumbers==RegBranchNumber); % which 3Phi regulator number it is
Branch.Wye3PhiTaps(:,rr)=[TapA;TapB;TapC];
Branch.Wye3PhiAvs{:,rr}=Av;
 
       case 'OpenDelta'
           
           ArAB=sqrt(Wnn3Phi(1,1,nn)./AlphaNM(1,1,r));
           ArCB=sqrt(Wnn3Phi(3,3,nn)./AlphaNM(9,9,r));

           
            TapAB=floor((-ArAB+1)./(0.00625));
TapCB=floor((-ArCB+1)./(0.00625));
 ArAB=1-0.00625*TapAB;
     ArCB=1-0.00625*TapCB;
  
Av=[ArAB 1-ArAB 0; 0 1 0; 0 1-ArCB ArCB];

 rr=find(Branch.OpenDeltaBranchNumbers==RegBranchNumber); % which 3Phi regulator number it is
Branch.OpenDeltaTaps(:,rr)=[TapAB;TapCB];
 Branch.OpenDeltaAvs{:,rr}=Av;
           
           
       case 'ClosedDelta'
           
           DeltaAB=BetaNM(1,1,r).^2-AlphaNM(1,1,r)*(KappaNM(1,1,r)-Wnn3Phi(1,1,nn));
rAB1=(-BetaNM(1,1,r)+sqrt(DeltaAB))./(AlphaNM(1,1,r));
ArAB=rAB1;
 DeltaBC=BetaNM(5,5,r).^2-AlphaNM(5,5,r)*(KappaNM(5,5,r)-Wnn3Phi(2,2,nn));
rBC=(-BetaNM(5,5,r)+sqrt(DeltaBC))./(AlphaNM(5,5,r));
ArBC=rBC;
 DeltaCA=BetaNM(9,9,r).^2-AlphaNM(9,9,r)*(KappaNM(9,9,r)-Wnn3Phi(3,3,nn));
rCA=(-BetaNM(9,9,r)+sqrt(DeltaCA))./(AlphaNM(9,9,r));
ArCA=rCA;


 TapAB=round((-ArAB+1)./(0.00625));
TapBC=round((-ArBC+1)./(0.00625));
TapCA=round((-ArCA+1)./(0.00625));

    ArAB=1-0.00625*TapAB;
ArBC=1-0.00625*TapBC;
 ArCA=1-0.00625*TapCA;
                        
 Av=[ArAB 1-ArAB 0; 0 ArBC 1-ArBC; 1-ArCA 0 ArCA];



            rr=find(Branch.ClosedDeltaBranchNumbers==RegBranchNumber); % which 3Phi regulator number it is
Branch.ClosedDeltaTaps(:,rr)=[TapAB;TapBC;TapCA];
Branch.ClosedDeltaAvs{:,rr}=Av;

   end
end

Bus.Sg=Sg; 
Network.Bus=Bus;
Network.Branch=Branch;