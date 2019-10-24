mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth)

[L1,L2,L3,L4x,L4y,L5x,L5y] = LibrationPoints(mu);
L1 = -L1
L2 = -L2 

L = L1;
Ax=1e-4;

%[tFinalL1, XFinalL1,newAxL1] = periodicLyapunov(90,240,mu,L1,Ax,1e-4,true);
%[tFinalL1, XFinalL1,newAxL1] = periodicLyapunov(60,450,mu,L1,Ax,1e-4,true);
%[tFinalL1, XFinalL1,newAx] = periodicLyapunov(25,45,mu,L1,Ax,5e-4,true);
%C = jacobiConstant( XFinalL1(1,1:2),XFinalL1(1,3:4),mu)


L = L2; 
Ax=1e-4;
%[tFinalL2, XFinalL2,newAxL2] = periodicLyapunovL2(90,150,mu,L,Ax,2e-4,true);
%[tFinalL2, XFinalL2,newAxL2] = periodicLyapunovL2(95,121,mu,L,Ax,3e-4,true);
%[tFinalL2, XFinalL2,newAxL2] = periodicLyapunovL2(80,200,mu,L,Ax,3e-4,true);
%C2 = jacobiConstant( XFinalL2(1,1:2),XFinalL2(1,3:4),mu);

plot(L1_list((2:end),1),L1_list((2:end),2),'r')
hold on
plot(L2_list((2:end),1),L2_list((2:end),2),'b')


%result = U2((2:end),:) == U3((2:end),:);
