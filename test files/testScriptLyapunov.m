clear
%el primer parametro es el limite de iteraciones para el
%singleShottingLyapunov.m 
%el segundo parametro es el limite de iteraciones para el
%metodo de periodicLyapunov.m

mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth)

[L1,L2,L3,L4x,L4y,L5x,L5y] = LibrationPoints(mu);
L1 = -L1
L2 = -L2 

L = L1;
Ax=1e-4;

%limit values for periodicLyapunov
%[tFinalL1, XFinalL1,newAx] = periodicLyapunov(25,32,mu,L,Ax,1e-3,false);
%[tFinalL1, XFinalL1,newAxL1] = periodicLyapunov(25,52,mu,L,Ax,1e-3,false);

list_C_Ax_posicion_L1 = zeros(1,7);
for i = 60:105
    [tPeriodoL1, XFinalL1,newAx] = periodicLyapunov(25,i,mu,L,Ax,5e-4,false);
    C = jacobiConstant( XFinalL1(1,1:2),XFinalL1(1,3:4),mu);
    row = [newAx C tPeriodoL1 XFinalL1];
    list_C_Ax_posicion_L1 = [list_C_Ax_posicion_L1; row];
    fprintf('Iteration i: %d\n', i);
end

 
Ax=1e-4;
%[tFinalL2, XFinalL2,newAxL2] = periodicLyapunovL2(25,70,mu,L,Ax,1e-3,false);
%[tFinalL2, XFinalL2] = periodicLyapunovL2(25,156,mu,L,Ax,1e-3,false);
list_C_Ax_posicion_L2 = zeros(1,7);
for i = 70:156
    %[tPeriodoL2, XFinalL2,newAxL2] = periodicLyapunovL2(25,i,mu,L2,Ax,1e-3,false);
    %C = jacobiConstant( XFinalL2(1,1:2),XFinalL2(1,3:4),mu);
    %row = [newAxL2 C tPeriodoL2 XFinalL2];
    %list_C_Ax_posicion_L2 = [list_C_Ax_posicion_L2; row];
    %fprintf('Iteration i: %d\n', i);
end

%save('savelist_C_Ax_posicion_L2.mat','list_C_Ax_posicion_L2');
%save('savelist_C_Ax_posicion_L1.mat','list_C_Ax_posicion_L1');