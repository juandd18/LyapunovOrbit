function plotStableMainfold(X_mainfold,periodo,k,mu)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

figure
hold on
for n=1:k
    x0=X_mainfold(n,1:4)';
    options=odeset('RelTol',2.5e-13,'AbsTol',1e-22);
    [t,X]=ode113(@CRTBPBackward,[0 periodo*4],x0,options,mu);
    plot(X(:,1), X(:,2),'r')
end

end

