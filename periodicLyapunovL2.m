function [t_halfPeriod,Xtemp] = periodicLyapunovL2(maxIter,maxIter2)
%periodicLyapunov calculate the periodic lyapunov orbit

mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth)

[L1,L2,L3,L4x,L4y,L5x,L5y] = LibrationPoints(mu);
L1 = -L1
L2 = -L2
L = L2;
Ax=1e-3;
%get an aprox. of the initial points lyapunov orbit

[Xguess, Vy_guess ] = initialPositionLyapunov(mu,L,Ax)
counter_1 = 0;
while Ax < 0.4
    
[t_halfPeriod,X_outVy,X_outX] = singleShootingLyapunov(mu,maxIter,Xguess, Vy_guess);
Vy_guess = X_outVy
Ax = Ax + 0.001
Xguess = L - Ax

counter_1=counter_1+1;
fprintf('Iteration counter_1: %d\n', counter_1)

    
if counter_1 > maxIter2
    break
end

end

tiempo = t_halfPeriod(end)*2
Xtemp = [X_outX,0,0,Vy_guess]
ode__opt = odeset('RelTol',1e-9,'AbsTol',1e-9);
[tFinal, XFinal] = ode113(@CRTBPForward, [0 t_halfPeriod(end)*2],Xtemp , ode__opt, mu); 


hold on
plot(L,0,'r*')
plot(XFinal(:,1), XFinal(:,2))
title('Periodic Lyapunov Orbit (Close Up)');
xlabel('X ');
ylabel('Y ');
grid on;


end

