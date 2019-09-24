function [t_halfPeriod,X_newVy] = periodicLyapunov(maxIter,maxIter2)
%periodicLyapunov calculate the periodic lyapunov orbit

mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth)

[L1,L2,L3,L4x,L4y,L5x,L5y] = LibrationPoints(mu);
Ax=0.00001;
%get an aprox. of the initial points lyapunov orbit
[Xguess, Vy_guess ] = initialPositionLyapunov(mu,-1*L1,Ax);
counter = 0;
while Ax < 0.1
    
[t_halfPeriod,X_newVy] = singleShootingLyapunov(mu,maxIter,Xguess, Vy_guess);
Vy_guess = X_newVy;
Ax = Ax + 0.001
Xguess = -1*L1 - Ax;

counter=counter+1;
fprintf('Iteration counter: %d\n', counter)

    
if counter > maxIter2
    break
end

end

 Xtemp = [Xguess,0,0,Vy_guess]
       ode_options = odeset('RelTol',1e-9,'AbsTol',1e-9);
        [tFinal, XFinal] = ode113(@CRTBPLyapunov, [0 t_halfPeriod*2], Xtemp, ode_options, mu); 


        L =  384400; %Moon-Earth Distance, km

        hold on
        plot(-L1,0,'r*')
        plot((XFinal(:,1))+2*Ax, XFinal(:,2))
        title('Periodic Lyapunov Orbit (Close Up)');
        xlabel('X [km]');
        ylabel('Y [km]');
        grid on;


end

