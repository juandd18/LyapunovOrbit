function [t_halfPeriod,X_newVy,X_newX] = singleShootingLyapunov(mu,maxIter,X_init,Vy_guess)
%singleShooting applied the method of single shooting
%   to find a periodic trajectory (Lyapunov orbit)

STM = reshape(eye(4),16,[])';
Xguess = [X_init 0 0 Vy_guess];
X0 = [Xguess STM]';


% Stop integrating when y=0 
ode_options = odeset('Events',@limitCriteria,'RelTol',1e-11,'AbsTol',1e-11);

limit_criteria = 100;
counter = 0;

while abs(limit_criteria) > 1e-14
    counter = counter+1;
    [t_halfOrbit,X_halfOrbit] = ode113(@CRTBPLyapunov, [0 Inf], X0, ode_options, mu);
    %[t,X_halfOrbit] = ode113(@cr3bpdiffV2, [0 Inf], X0, ode_options, mu);
    
    % Get stm matrix from input and reshape 4x4
    stm = reshape(X_halfOrbit(end,5:end),4,[]);
        
    updateTerm = stm(3,4) - (1/X_halfOrbit(end,4))*stm(2,4);

    deltaVec = (1/updateTerm)*X_halfOrbit(end,3);
    
    
    deltaVy = [0, 0, 0, deltaVec]';
    

    X0(1:4) = X0(1:4) - deltaVy;
    
    X_newX =  X0(1);
    X_newVy = X0(4);
    t_halfPeriod = t_halfOrbit(end);
    
    limit_criteria = X_halfOrbit(end,3);
    
    if counter > maxIter
        X_newX =  X0(1)
        X_newVy = X0(4)
        t_halfPeriod = t_halfOrbit(end)
        break
    end
        
end
fprintf('Iteration counter: %d\n', counter)
fprintf('Iteration criteria: %d\n', limit_criteria)

end
