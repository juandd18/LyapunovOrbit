function [vectOutput] = CRTBPBackwardPerturbation(time,vect,mu,Ap,theta,Cr,Area,mass,checkPertSolar,checkPertRandom)
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

%% Accelerations with Random Perturbation 
if(checkPertRandom)
AccRandom = randomPerturbation(Ap,theta);
xAce  = xAce + AccRandom(1,1) ;
yAce  = yAce + AccRandom(1,2) ;
end
%% Accelarations with Solar Radiation Perturbation
if(checkPertSolar)
AccSolar =SolarPresion([x y],time,Cr,Area,mass);
xAce  = xAce +  AccSolar(1,1);
yAce  = yAce + AccSolar(1,2);
end

vectOutput = [-xVel -yVel -xAce -yAce]';

end



