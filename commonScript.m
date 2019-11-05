mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth)

[L1,L2,L3,L4x,L4y,L5x,L5y] = LibrationPoints(mu);
L1 = -L1
L2 = -L2 

L = L1;
Ax=1e-4;

%[tFinalL1, XFinalL1,newAxL1] = periodicLyapunov(95,400,mu,L1,Ax,3e-5,true);
%3.151036695917785; 220
%3.131831565212392; 260
%[tFinalL1, XFinalL1,newAxL1] = periodicLyapunov(70,150,mu,L1,Ax,2e-4,true);
%3.159515661065999; 100
%3.141729364052174; 120
%3.111503737067811; 150
%[tFinalL1, XFinalL1,newAx] = periodicLyapunov(25,45,mu,L1,Ax,5e-4,true);
%C = jacobiConstant( XFinalL1(1,1:2),XFinalL1(1,3:4),mu)


L = L2; 
Ax=1e-5;
%[tFinalL2, XFinalL2,newAxL2] = periodicLyapunovL2(50,1000,mu,L,Ax,1e-5,true);
%3.147043491098097 ; 300
%3.168931875775025 ; 302
%3.168862112221666; 301
%33.171179766161216 800
% 3.177788445486213 109

%Ax=1e-4;
%[tFinalL2, XFinalL2,newAxL2] = periodicLyapunovL2(95,151,mu,L,Ax,1e-4,true);
%3.172155835148665 150
%3.172066658851451
%[tFinalL2, XFinalL2,newAxL2] = periodicLyapunovL2(80,200,mu,L,Ax,3e-4,true);
%C2 = jacobiConstant( XFinalL2(1,1:2),XFinalL2(1,3:4),mu)

% plot(L1_list((2:end),1),L1_list((2:end),2),'r')
% hold on
% plot(L2_list((2:end),1),L2_list((2:end),2),'b')
% title('Constante de Jacobi vs Amplitud');
% xlabel('Amplitud ');
% ylabel('Constante de Jacobi ');
% grid on;
% 
% figure
% 
% plot(L1_list((2:end),3),L1_list((2:end),2),'r')
% hold on
% plot(L2_list((2:end),3),L2_list((2:end),2),'b')
% title('Constante de Jacobi vs Periodo');
% xlabel('Periodo ');
% ylabel('Constante de Jacobi ');
% grid on;



%result = U2((2:end),:) == U3((2:end),:);


list_load = matfile('savelist_C_Ax_posicion_L1_small.mat');
L1_list_450 = list_load.list_C_Ax_posicion_L1;


list_load = matfile('savelist_C_Ax_posicion_L2_small2.mat');
L2_list_450 = list_load.list_C_Ax_posicion_L2;



