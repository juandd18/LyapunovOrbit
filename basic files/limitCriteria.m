function [value,isterminal,direction] = limitCriteria(times,x,mu)   
    value = x(2);      % x(2) is y, 
    isterminal = 1;    % when y = 0 stop the ode
    direction = 0;     % all zeros, not just increasing or decreasing
end