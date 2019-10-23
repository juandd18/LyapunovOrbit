function [tPeriodo,Xtemp,new_Ax] = periodicLyapunov(maxIter,maxIter2,mu,L,Ax,IncreasMag,printControl)
%periodicLyapunov calculate the periodic lyapunov orbit


%get an aprox. of the initial points lyapunov orbit
[Xguess, Vy_guess ] = initialPositionLyapunov(mu,L,Ax);
counter_1 = 0;
while Ax <= 0.4
    
[t_halfPeriod,X_outVy,X_outX] = singleShootingLyapunov(mu,maxIter,Xguess, Vy_guess,printControl);
Vy_guess = X_outVy;
Ax = Ax + IncreasMag; %0.001
%cambio
Xguess = L - Ax;

counter_1=counter_1+1;

if printControl
    fprintf('Iteration counter_1: %d\n', counter_1);
end
    
if counter_1 > maxIter2
    new_Ax = Ax;
    break
end

end


Xtemp = [X_outX,0,0,Vy_guess];
tPeriodo = plotPeriodicOrbit(Xtemp,t_halfPeriod(end)*2,mu,L);


end

