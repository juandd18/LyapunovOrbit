function [U2_unstable_positive,U2_stable_negative] = callPoincareMap(X_mainfold_unstable,X_mainfold_stable,mu,k,C,tLimit_stable,tLimit_unstable)
%UNTITLED Summary of this function goes here
%   passIterates: cuantos intersecciones en el poincare map


[U2_unstable_positive,U2_unstable_negative] = poincareMap(@CRTBPForward,X_mainfold_unstable,k,tLimit_unstable,mu,C);

size(U2_unstable_positive)
size(U2_unstable_negative)

[U2_stable_positive,U2_stable_negative] = poincareMap(@CRTBPBackward,X_mainfold_stable,k,tLimit_stable,mu,C);

size(U2_stable_positive)
size(U2_stable_negative)

%% plot poincare

plot(U2_unstable_positive((2:end),2), U2_unstable_positive((2:end),1),'b.')
hold on
plot(U2_stable_positive((2:end),2), U2_stable_positive((2:end),1),'r.')
%plot(U2_stable_negative((2:end),2), U2_stable_negative((2:end),1),'r.')
title('Mapa de Poincare entre campos invariantes');
grid on;
xlabel('Vy')
ylabel('y')


end

