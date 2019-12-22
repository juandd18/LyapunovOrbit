
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
Ax=1e-3;

%limit values for periodicLyapunov
% [tFinalL1, XFinalL1,newAx] = periodicLyapunov(25,52,mu,L,Ax,1e-3,true);
% [tFinalL1, XFinalL1,newAxL1] = periodicLyapunov(30,52,mu,L,Ax,1e-3,true,'red');
% C = jacobiConstant( XFinalL1(1,1:2),XFinalL1(1,3:4),mu)

%762  iter  c=3.1473
%766  iter  c=3.1467
%769  iter  c=3.1461
%790        c=3.1432
%830        c=3.1373
%844        c=3.1354
%847        c=3.1348
list_C_Ax_posicion_L1 = zeros(1,7);
for i = 830:855 %75:80 % 95:110%280:285%41:51%100:105 %230,500
    %[tPeriodoL1, XFinalL1,newAx] = periodicLyapunov(70,i,mu,L1,Ax,2e-4,false);
    %[tPeriodoL1, XFinalL1,newAx] = periodicLyapunov(30,i,mu,L,Ax,1e-3,false,'red');
    %[tPeriodoL1, XFinalL1,newAx] = periodicLyapunov(55,i,mu,L1,1e-4,3e-5,false,'red');
    %[tPeriodoL1, XFinalL1,newAx] = periodicLyapunov(25,105,mu,L1,1e-4,5e-4,false,'red');
    %[tPeriodoL1, XFinalL1,newAx] = periodicLyapunov(55,i,mu,L1,1e-4,3e-5,false,'red');
    [tPeriodoL1, XFinalL1,newAx] = periodicLyapunov(65,i,mu,L1,1e-4,3e-5,true,'red');
    C = jacobiConstant( XFinalL1(1,1:2),XFinalL1(1,3:4),mu)
    row = [newAx C tPeriodoL1 XFinalL1];
    list_C_Ax_posicion_L1 = [list_C_Ax_posicion_L1; row];
    fprintf('Iteration i: %d\n', i);
    if ~(mod(i,10))
        save('version_4_L1.mat','list_C_Ax_posicion_L1');
    end
end
save('version_4_L1.mat','list_C_Ax_posicion_L1');
% figure
% plot(list_C_Ax_posicion_L1((2:end),1),list_C_Ax_posicion_L1((2:end),2),'b')

L = L2;
Ax=1e-5;
 
%[tFinalL2, XFinalL2,newAxL2] = periodicLyapunovL2(25,70,mu,L,Ax,1e-3,false);
% [tFinalL2, XFinalL2,newAxL2] = periodicLyapunovL2(60,380,mu,L,1e-4,1e-4,true,'b');
%[tFinalL2, XFinalL2] = periodicLyapunovL2(55,1100,mu,L,1e-5,1e-5,true);
%942 iter c:3.1515
%943 iter c:3.1515
%945 iter c:3.1513
%950 iter c:3.1510
%960 iter c:3.1500
%984 iter c:3.1484
%988 iter c:3.1481
%1001     c:3.1469
%1100     c:3.1381
%1109     c:3.1372
%1112     c:3.1369
list_C_Ax_posicion_L2 = zeros(1,7);
% for i =  1135:1200% 50:55 %380:390%1100:1800 %156
% %     [tPeriodoL2, XFinalL2,newAxL2] = periodicLyapunovL2(55,i,mu,L2,Ax,1e-5,false);
%     %[tPeriodoL2, XFinalL2,newAxL2] = periodicLyapunovL2(60,i,mu,L,1e-4,1e-4,false,'blue');
%     [tPeriodoL2, XFinalL2,newAxL2] = periodicLyapunovL2(65,i,mu,L,Ax,3e-5,true,'blue');
%     C = jacobiConstant( XFinalL2(1,1:2),XFinalL2(1,3:4),mu)
%     row = [newAxL2 C tPeriodoL2 XFinalL2];
%     list_C_Ax_posicion_L2 = [list_C_Ax_posicion_L2; row];
%     fprintf('Iteration i: %d\n', i);
%     if ~(mod(i,10))
%        save('version_3_L2_small2.mat','list_C_Ax_posicion_L2');
%     end
% end
% save('version_3_L2_small2.mat','list_C_Ax_posicion_L2');
% %figure
% plot(list_C_Ax_posicion_L2((2:end),1),list_C_Ax_posicion_L2((2:end),2),'b')

%save('savelist_C_Ax_posicion_L1_316.mat','list_C_Ax_posicion_L1');