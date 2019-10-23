function [U2_unstable,U3_stable] = callPoincareMap(X_mainfold_unstable,X_mainfold_stable,mu,k,tLimit_stable,tLimit_unstable)
%UNTITLED Summary of this function goes here
%   passIterates: cuantos intersecciones en el poincare map


[U2_unstable,U3_unstable] = poincareMap(@CRTBPForward,X_mainfold_unstable,k,tLimit_unstable,mu);

size(U2_unstable)
size(U3_unstable)

[U2_stable,U3_stable] = poincareMap(@CRTBPBackward,X_mainfold_stable,k,tLimit_stable,mu);

size(U2_stable)
size(U3_stable)
%% plot poincare
hold on
plot(U2_unstable((2:end),1), U2_unstable((2:end),2),'b.')
plot(U3_stable((2:end),1), U3_stable((2:end),2),'r*')
xlabel('y')
ylabel('Vy')


end

