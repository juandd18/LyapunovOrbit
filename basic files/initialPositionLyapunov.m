function [Xf,Vy] = initialPositionLyapunov(u,Xe,Ax)
%initialPositionLyapunov get the initial conditions for 
%   a periodic orbit using (2.9.1) Dynamical Systems, the three body
%   problem

%t=lambda1=lambda2 = 0

% equation (2.6.2)
u_tilda = u*(abs(Xe-1+u))^(-3) + (1-u)*(abs(Xe+u))^(-3);

% equation pag. 46 section 2.7
alpha2 = (1/2)*(u_tilda - 2 - sqrt(9*(u_tilda^2) - 8*u_tilda)); 
v = alpha2;

% equation (2.7.2) or pag. 109
tau = -(v^2 + 2*u_tilda + 1)/(2*v);

% equation pag. 109
Vy = -Ax*v*tau;

Xf = Xe-Ax;
%Xf = Xe;

end

