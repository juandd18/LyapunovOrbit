function tPeriodo = plotPeriodicOrbit(Xtemp,period,mu,L)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

ode__opt = odeset('RelTol',1e-12,'AbsTol',1e-12);
[tFinal, XFinal] = ode113(@CRTBPForward, [0 period],Xtemp , ode__opt, mu); 
tPeriodo = tFinal(end);

hold on
plot(L,0,'r*')
plot(XFinal(:,1), XFinal(:,2))
title('Periodic Lyapunov Orbit (Close Up)');
xlabel('X ');
ylabel('Y ');
grid on;

end

