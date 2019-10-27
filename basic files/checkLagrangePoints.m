function [xLagrange,yLagrange] = checkLagrangePoints(x,y,mu)
%checkLagrangePoints Comprueba que los puntos x,y sean de 
%   Lagrange

r1 = sqrt((x+mu)^2 + y^2 ); 
r2 = sqrt((x-1+mu)^2 + y^2 ); 

%% Accelerations 
%xAce - 2*yVel =  + x - ((1-mu)*(x+mu))/(r1^3) - (mu*(x-1+mu))/r2^3;
%yAce + 2*xVel = + y - ((1-mu)*y)/r1^3  - (mu*y)/r2^3;

xLagrange = x - ((1-mu)*(x+mu))/(r1^3) - (mu*(x-1+mu))/r2^3;
yLagrange = y - ((1-mu)*y)/r1^3  - (mu*y)/r2^3;

end

