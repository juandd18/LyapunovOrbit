function [t_halfPeriod,Xtemp] = periodicLyapunovL2(maxIter,maxIter2)
%periodicLyapunov calculate the periodic lyapunov orbit

mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth)

[L1,L2,L3,L4x,L4y,L5x,L5y] = LibrationPoints(mu);
L1 = -L1
lresult =-L2
L2 =  1.1556821603
L = L2 
Ax=0.0002;
%get an aprox. of the initial points lyapunov orbit

[Xguess, Vy_guess ] = initialPositionLyapunov(mu,L,Ax)
counter_1 = 0;
while Ax <= 0.1
    
[t_halfPeriod,X_outVy,X_outX] = singleShootingLyapunovV1(mu,maxIter,Xguess, Vy_guess,0,0);
Vy_guess = X_outVy
Ax = Ax + 2e-3 % 3e-4 4e-3 1e-3
Xguess = L2 + Ax;

counter_1=counter_1+1;
fprintf('Iteration counter_1: %d\n', counter_1)

    
if counter_1 >= maxIter2
    break
end

end

tiempo = t_halfPeriod(end)*2
Xtemp = [X_outX,0,0,Vy_guess]
ode__opt = odeset('RelTol',1e-12,'AbsTol',1e-12);
[tFinal, XFinal] = ode113(@CRTBPForward, [0 t_halfPeriod(end)*2],Xtemp , ode__opt, mu); 


hold on
plot(L2,0,'r*')
plot(XFinal(:,1), XFinal(:,2))
title('Periodic Lyapunov Orbit (Close Up)');
xlabel('X ');
ylabel('Y ');
grid on;


end

