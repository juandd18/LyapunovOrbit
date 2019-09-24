function [t_halfPeriod,X_newVy] = singleShootingLyapunov(mu,maxIter,Xguess,Vy_guess)
%singleShooting applied the method of single shooting
%   to find a periodic trajectory (Lyapunov orbit)

STM = reshape(eye(4),16,[])';
Xguess = [Xguess 0 0 Vy_guess];
X0 = [Xguess STM]';


% Stop integrating when y=0 
ode_options = odeset('Events',@limitCriteria,'RelTol',1e-11,'AbsTol',1e-11);

limit_criteria = 100;
counter = 0;

while abs(limit_criteria) > 1e-11
    counter = counter+1;
    [t,X_halfOrbit] = ode113(@CRTBPLyapunov, [0 Inf], X0, ode_options, mu);
    
    % Get stm matrix from input and reshape 4x4
    stm = reshape(X_halfOrbit(end,5:end),4,[]);
        
    updateTerm = stm(3,4) - (1/X_halfOrbit(end,4))*stm(2,4);

    deltaVec = (1/updateTerm)*X_halfOrbit(end,3);
    
    
    deltaVy = [0, 0, 0, deltaVec];
    
    limit_criteria = X_halfOrbit(end,3);
    
    X0(1:4) = X0(1:4) - deltaVy';
    
    X_newVy = X0(4);
    t_halfPeriod = X_halfOrbit(end);
    if counter > maxIter
        X_newVy = X0(4);
        t_halfPeriod = X_halfOrbit(end);
        break
    end 
        
end

end
