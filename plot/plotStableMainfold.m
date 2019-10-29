function plotStableMainfold(X_mainfold,periodo,k,mu,color)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


hold on
for n=1:k
    x0=X_mainfold(n,1:4)';
    options=odeset('Events',@limitCriteriaPoincare,'RelTol',1e-12,'AbsTol',1e-13);
    [t,X]=ode113(@CRTBPBackward,[0 periodo],x0,options,mu);
    plot(X(:,1), X(:,2),color)
    %contour(X(:,1), X(:,2), X(:,3))
end

end

