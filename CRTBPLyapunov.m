function [vectOutput] = CRTBPLyapunov(time,vect,mu)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

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

%% Matrix A
upperLeft = zeros(2);
upperRight = eye(2);
lowerRight = [0 2 ;-2 0];
lowerLeft = Uab(mu,x,y,0);
A = [upperLeft upperRight; lowerLeft lowerRight];

%% find STM + t matrix.
stm = reshape(vect(5:end), 4,[]);
stm_1 = A * stm;
% Reshape to vector. 
stm_1_vect = reshape(stm_1,1,[]);

vectOutput = [xVel yVel xAce yAce stm_1_vect]';

end

