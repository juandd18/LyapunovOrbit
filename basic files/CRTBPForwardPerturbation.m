function [vectOutput] = CRTBPForwardPerturbation(time,vect,mu,Ap,theta,Cr,Area,mass)
%CRTBPForward equation of motion for a PCRTBP using 
%   

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
AccRandom = randomPerturbation(Ap,theta);

%% Accelarations with Solar Radiation Perturbation
AccSolar =SolarPresion([x y],time,Cr,Area,mass);

%% Add perturbation to current accelerations
xAce  = xAce + AccRandom(1,1) + AccSolar(1,1);
yAce  = yAce + AccRandom(1,2) + AccSolar(1,2);


vectOutput = [xVel yVel xAce yAce]';

end



