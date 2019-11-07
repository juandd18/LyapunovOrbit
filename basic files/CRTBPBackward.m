function [vectOutput] = CRTBPBackward(time,vect,mu)
%CRTBPBackward equation of motion for PCRTBP runining 
%   backward

%% Positions
x = vect(1);
y = vect(2);


%% Velocities
xVel = vect(3);
yVel = vect(4);

r1 = sqrt((x+mu)^2 + y^2 ); 
r2 = sqrt((x-1+mu)^2 + y^2 ); 

%% Accelerations 
xAce = 2*yVel + x - ((1-mu)*(x+mu))/(r1^3) - (mu*(x-1+mu))/r2^3;
yAce = -2*xVel + y - ((1-mu)*y)/r1^3  - (mu*y)/r2^3;


vectOutput = [-xVel -yVel -xAce -yAce]';

end



