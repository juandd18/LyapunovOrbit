function [value,isterminal,direction] = limitCriteriaPoincare(times,x,mu)   
    value = (x(1)==(1-mu))-0.5;      % x(1) is 1-mu, 
    isterminal = 1;   
    direction = 0;     
end