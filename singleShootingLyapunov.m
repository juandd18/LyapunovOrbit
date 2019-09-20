function [tFinal, XFinal] = singleShootingLyapunov(mu,maxIter,Ax)
%singleShooting applied the method of single shooting
%   to find a periodic trajectory (Lyapunov orbit)

[L1,L2,L3,L4x,L4y,L5x,L5y] = LibrationPoints(mu);


%get an aprox. of the initial points lyapunov orbit
[Xguess, Vy_guess ] = initialPositionLyapunov(mu,L1,Ax);


STM = reshape(eye(4),16,[])';
Xguess = [Xguess 0 0 Vy_guess]
X0 = [Xguess STM]';


% Stop integrating when y=0 (NO SE SI ESTA BIEN pues no se como hacerlo para 
%   cuando cambio de signo y)
ode_options = odeset('Events',@limitCriteria,'RelTol',1e-15,'AbsTol',1e-15);

deltaVec = [100; 100];
counter = 0;
while abs(norm(deltaVec)) > 1e-14
    counter = counter+1;
    [t,X_halfOrbit] = ode113(@CRTBPLyapunov, [0 Inf], X0, ode_options, mu);
    
    % Get stm matrix from input and reshape 4x4
    stm = reshape(X_halfOrbit(end,5:end),4,[]);
        
    updateTerm = stm(4,3) - (X_halfOrbit(end,3)/X_halfOrbit(end,4))*stm(2,4);

    deltaVec = inv(updateTerm)*X_halfOrbit(end,3);
    
    deltaVx = [0, 0, deltaVec, 0];
    
    fprintf('Iteration counter: %d\n', counter)
    abs(norm(deltaVec))

    X0(1:4) = X0(1:4) - deltaVx';
    if counter > maxIter
        break
    end 
        
end

ode_options = odeset('RelTol',1e-9,'AbsTol',1e-9);
[tFinal, XFinal] = ode113(@CRTBPLyapunov, [0 X_halfOrbit(end)*3], X0, ode_options, mu); 


L =  384400; %Moon-Earth Distance, km

hold on
plot(L1,0,'r*')
plot((XFinal(:,1)), XFinal(:,2))
title('Periodic Lyapunov Orbit (Close Up)');
xlabel('X [km]');
ylabel('Y [km]');
grid on;


end