variable Uaa3Phi(3,3,NRegs3Phi)  hermitian semidefinite
variable Ubb3Phi(3,3,NRegs3Phi) hermitian semidefinite
variable Ucc3Phi(3,3,NRegs3Phi) hermitian semidefinite
variable Uab3Phi(3,3,NRegs3Phi) complex
variable Uac3Phi(3,3,NRegs3Phi) complex
variable Ubc3Phi(3,3,NRegs3Phi) complex
variable Psia3Phi(3,3,NRegs3Phi) complex
variable Psib3Phi(3,3,NRegs3Phi) complex
variable Psic3Phi(3,3,NRegs3Phi) complex
variable PsiaPrime3Phi(3,3,NRegs3Phi) complex
variable PsibPrime3Phi(3,3,NRegs3Phi) complex
variable PsicPrime3Phi(3,3,NRegs3Phi) complex


% create a placeholder 
expression UPhiPhiPrime3Phi(3,3,NRegs3Phi,3,3);
expression PsiPhi3Phi(3,3,NRegs3Phi,3);

expression UPsi3Phi(12,12,NRegs3Phi);
expression U3Phi(9,9,NRegs3Phi);



UPhiPhiPrime3Phi(:,:,:,1,1)=Uaa3Phi;
UPhiPhiPrime3Phi(:,:,:,1,2)=Uab3Phi;
UPhiPhiPrime3Phi(:,:,:,2,1)=conj(Uab3Phi).';
UPhiPhiPrime3Phi(:,:,:,2,2)=Ubb3Phi;
UPhiPhiPrime3Phi(:,:,:,1,3)=Uac3Phi;
UPhiPhiPrime3Phi(:,:,:,3,1)=conj(Uac3Phi).';
UPhiPhiPrime3Phi(:,:,:,2,3)=Ubc3Phi;
UPhiPhiPrime3Phi(:,:,:,3,2)=conj(Ubc3Phi).';
UPhiPhiPrime3Phi(:,:,:,3,3)=Ucc3Phi;
PsiPhi3Phi(:,:,:,1)=Psia3Phi;
PsiPhi3Phi(:,:,:,2)=Psib3Phi;
PsiPhi3Phi(:,:,:,3)=Psic3Phi;