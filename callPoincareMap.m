function [U2_unstable,U3_stable] = callPoincareMap(X_mainfold_unstable,X_mainfold_stable,mu,k,tLimit)
%UNTITLED Summary of this function goes here
%   passIterates: cuantos intersecciones en el poincare map


[U2_unstable,U3_unstable] = poincareMap(@CRTBPForward,X_mainfold_unstable,k,tLimit,mu);

[U2_stable,U3_stable] = poincareMap(@CRTBPBackward,X_mainfold_stable,k,tLimit,mu);

%% plot poincare
hold on
plot(U2_unstable(:,1), U2_unstable(:,2),'.')
plot(U3_stable(:,1), U3_stable(:,2),'*')
xlabel('y')
ylabel('Vy')


end

