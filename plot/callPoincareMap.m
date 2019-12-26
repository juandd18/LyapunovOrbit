function [U2_unstable_positive,U2_stable_positive] = callPoincareMap(X_mainfold_unstable,X_mainfold_stable,mu,k,C,tLimit_stable,tLimit_unstable)
%UNTITLED Summary of this function goes here
%   passIterates: cuantos intersecciones en el poincare map


[U2_unstable_positive] = poincareMap(@CRTBPForward,X_mainfold_unstable,k,tLimit_unstable,mu,C);

size(U2_unstable_positive)

[U2_stable_positive] = poincareMap(@CRTBPBackward,X_mainfold_stable,k,tLimit_stable,mu,C);

size(U2_stable_positive)

%% plot poincare

%plot(U2_unstable_positive((2:end),2), U2_unstable_positive((2:end),1),'b.')
line(U2_unstable_positive((2:end),2), U2_unstable_positive((2:end),1),'Color','b')
hold on
%plot(U2_stable_positive((2:end),2), U2_stable_positive((2:end),1),'r.')
line(U2_stable_positive((2:end),2), U2_stable_positive((2:end),1),'Color','r')
grid on;

%unstable_size = size(U2_unstable_positive((2:end),2))
%stable_size = size(U2_stable_positive((2:unstable_size(1,1)+1),2))

pgon1 = polyshape(U2_unstable_positive((2:end),2),U2_unstable_positive((2:end),1));
pgon2 = polyshape(U2_stable_positive((2:end),2),U2_stable_positive((2:end),1));

plot(intersect(pgon1,pgon2),'EdgeColor','none')

title('Aplicaciones de Poincare entre campos invariantes de L1 y L2 ');
grid on;
xlabel('Vy')
ylabel('y')


figure
plot(U2_unstable_positive((2:end),2), U2_unstable_positive((2:end),1),'b.')
hold on
plot(U2_stable_positive((2:end),2), U2_stable_positive((2:end),1),'r.')
title('Aplicaciones de Poincare entre campos invariantes de L1 y L2 ');
grid on;
xlabel('Vy')
ylabel('y')

end

