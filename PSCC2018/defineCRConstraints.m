for r=1:NRegs3Phi
     defineCommonWPrimeConstraints; %checked
 U3Phi(:,:,r)=[Uaa3Phi(:,:,r), Uab3Phi(:,:,r), Uac3Phi(:,:,r);
  conj(Uab3Phi(:,:,r).'), Ubb3Phi(:,:,r), Ubc3Phi(:,:,r);
  conj(Uac3Phi(:,:,r).'), conj(Ubc3Phi(:,:,r).'), Ucc3Phi(:,:,r)];
  
UPsi3Phi(:,:,r)=[Uaa3Phi(:,:,r), Uab3Phi(:,:,r), Uac3Phi(:,:,r), Psia3Phi(:,:,r);
  conj(Uab3Phi(:,:,r).'), Ubb3Phi(:,:,r), Ubc3Phi(:,:,r), Psib3Phi(:,:,r); 
  conj(Uac3Phi(:,:,r).'), conj(Ubc3Phi(:,:,r).'), Ucc3Phi(:,:,r), Psic3Phi(:,:,r); 
    conj(Psia3Phi(:,:,r).'), conj(Psib3Phi(:,:,r).'), conj(Psic3Phi(:,:,r).'), Wnn3Phi(:,:,mm)];


UPsi3Phi(:,:,r)>=0;

% 

WnnPrime3Phi(:,:,r)==Uaa3Phi(:,:,r)+Uab3Phi(:,:,r)+Uac3Phi(:,:,r)+...
    conj(Uab3Phi(:,:,r).')+Ubb3Phi(:,:,r)+Ubc3Phi(:,:,r)+...
    conj(Uac3Phi(:,:,r).')+conj(Ubc3Phi(:,:,r).')+Ucc3Phi(:,:,r);



switch char(RegulatorType)
    
    case 'Wye'

  

          D=eye(3);
          F=zeros(3);
   
          
          


case 'OpenDelta'
      
    D=[1 -1 0; 0 1 0; 0 -1 1];
    F=[0 1 0; 0 0 0; 0 1 0];
    
    
case 'ClosedDelta'

    D=[1 -1 0; 0 1 -1; -1 0 1];
    F=[0 1 0; 0 0 1; 1 0 0];
        
        
end



DTilde(:,:,r)=blkdiag(D,D,D); 
FTilde(:,:,r)=blkdiag(F,F,F); 




AlphaNM=DTilde(:,:,r)*U3Phi(:,:,r)*DTilde(:,:,r)';
BetaNM=real(DTilde(:,:,r)*U3Phi(:,:,r)*FTilde(:,:,r)');
KappaNM=FTilde(:,:,r)*U3Phi(:,:,r)*FTilde(:,:,r)';


WTilde=cvx(zeros(9,9));
WTilde(1,1)=Wnn3Phi(1,1,nn);
WTilde(1,5)=Wnn3Phi(1,2,nn);
WTilde(1,9)=Wnn3Phi(1,3,nn);
WTilde(5,1)=Wnn3Phi(2,1,nn);
WTilde(5,5)=Wnn3Phi(2,2,nn);
WTilde(5,9)=Wnn3Phi(2,3,nn);
WTilde(9,1)=Wnn3Phi(3,1,nn);
WTilde(9,5)=Wnn3Phi(3,2,nn);
WTilde(9,9)=Wnn3Phi(3,3,nn);



switch RegulatorType
    case 'Wye'
        



AlphaNM(1,1)*(RMIN.^2)<=WTilde(1,1)<=AlphaNM(1,1)*(RMAX.^2);
AlphaNM(5,5)*(RMIN.^2)<=WTilde(5,5)<=AlphaNM(5,5)*(RMAX.^2);
AlphaNM(9,9)*(RMIN.^2)<=WTilde(9,9)<=AlphaNM(9,9)*(RMAX.^2);


        
        
                      
AlphaNM(2,2)==0;
AlphaNM(3,3)==0;
AlphaNM(4,4)==0;
AlphaNM(6,6)==0;
AlphaNM(7,7)==0;
AlphaNM(8,8)==0;

BetaNM(1,1)==0;
BetaNM(2,2)==0;
BetaNM(3,3)==0;
BetaNM(4,4)==0;
BetaNM(5,5)==0;
BetaNM(6,6)==0;
BetaNM(7,7)==0;
BetaNM(8,8)==0;
BetaNM(9,9)==0;

KappaNM(1,1)==0;
KappaNM(2,2)==0;
KappaNM(3,3)==0;
KappaNM(4,4)==0;
KappaNM(5,5)==0;
KappaNM(6,6)==0;
KappaNM(7,7)==0;
KappaNM(8,8)==0;
KappaNM(9,9)==0;




    case 'OpenDelta'
        
AlphaNM(1,1)*(RMIN.^2)<=WTilde(1,1)<=AlphaNM(1,1)*(RMAX.^2);
AlphaNM(9,9)*(RMIN.^2)<=WTilde(9,9)<=AlphaNM(9,9)*(RMAX.^2);


% 
AlphaNM(4,4)*RMIN+BetaNM(4,4)<=0;
AlphaNM(4,4)*RMAX+BetaNM(4,4)>=0;
AlphaNM(6,6)*RMIN+BetaNM(6,6)<=0;
AlphaNM(6,6)*RMAX+BetaNM(6,6)>=0;

% 
BetaNM(4,4)*RMIN+KappaNM(4,4)>=0;
BetaNM(4,4)*RMAX+KappaNM(4,4)<=0;
BetaNM(6,6)*RMIN+KappaNM(6,6)>=0;
BetaNM(6,6)*RMAX+KappaNM(6,6)<=0;


AlphaNM(2,2)==0;
AlphaNM(3,3)==0;
AlphaNM(5,5)==WTilde(5,5);
AlphaNM(7,7)==0;
AlphaNM(8,8)==0;
% 
BetaNM(1,1)==0;
BetaNM(2,2)==0;
BetaNM(3,3)==0;
BetaNM(5,5)==0;
BetaNM(7,7)==0;
BetaNM(8,8)==0;
BetaNM(9,9)==0;
% 
KappaNM(1,1)==0;
KappaNM(2,2)==0;
KappaNM(3,3)==0;
KappaNM(5,5)==0;
KappaNM(7,7)==0;
KappaNM(8,8)==0;
KappaNM(9,9)==0;
% 


    
    case 'ClosedDelta'
        

  AlphaNM(1,1)*RMIN+BetaNM(1,1)>=0;  
    AlphaNM(5,5)*RMIN+BetaNM(5,5)>=0;      
  AlphaNM(9,9)*RMIN+BetaNM(9,9)>=0;    
  
  AlphaNM(1,1)*(RMIN.^2)+2*BetaNM(1,1)*RMIN+KappaNM(1,1)<=WTilde(1,1);
  AlphaNM(1,1)*(RMAX.^2)+2*BetaNM(1,1)*RMAX+KappaNM(1,1)>=WTilde(1,1);

    AlphaNM(5,5)*(RMIN.^2)+2*BetaNM(5,5)*RMIN+KappaNM(5,5)<=WTilde(5,5);
  AlphaNM(5,5)*(RMAX.^2)+2*BetaNM(5,5)*RMAX+KappaNM(5,5)>=WTilde(5,5);
  
    AlphaNM(9,9)*(RMIN.^2)+2*BetaNM(9,9)*RMIN+KappaNM(9,9)<=WTilde(9,9);
  AlphaNM(9,9)*(RMAX.^2)+2*BetaNM(9,9)*RMAX+KappaNM(9,9)>=WTilde(9,9);
    
        
%         



              
              
AlphaNM(2,2)*RMIN+BetaNM(2,2)<=0;
AlphaNM(2,2)*RMAX+BetaNM(2,2)>=0;
AlphaNM(3,3)*RMIN+BetaNM(3,3)<=0;
AlphaNM(3,3)*RMAX+BetaNM(3,3)>=0;
AlphaNM(4,4)*RMIN+BetaNM(4,4)<=0;
AlphaNM(4,4)*RMAX+BetaNM(4,4)>=0;
AlphaNM(6,6)*RMIN+BetaNM(6,6)<=0;
AlphaNM(6,6)*RMAX+BetaNM(6,6)>=0;
AlphaNM(7,7)*RMIN+BetaNM(7,7)<=0;
AlphaNM(7,7)*RMAX+BetaNM(7,7)>=0;
AlphaNM(8,8)*RMIN+BetaNM(8,8)<=0;
AlphaNM(8,8)*RMAX+BetaNM(8,8)>=0;






BetaNM(2,2)*RMIN+KappaNM(2,2)>=0;
BetaNM(2,2)*RMAX+KappaNM(2,2)<=0;
BetaNM(3,3)*RMIN+KappaNM(3,3)>=0;
BetaNM(3,3)*RMAX+KappaNM(3,3)<=0;
BetaNM(4,4)*RMIN+KappaNM(4,4)>=0;
BetaNM(4,4)*RMAX+KappaNM(4,4)<=0;
BetaNM(6,6)*RMIN+KappaNM(6,6)>=0;
BetaNM(6,6)*RMAX+KappaNM(6,6)<=0;
BetaNM(7,7)*RMIN+KappaNM(7,7)>=0;
BetaNM(7,7)*RMAX+KappaNM(7,7)<=0;
BetaNM(8,8)*RMIN+KappaNM(8,8)>=0;
BetaNM(8,8)*RMAX+KappaNM(8,8)<=0;

    

end










 end




