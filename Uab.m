function matrix = Uab(mu,x,y,z)
%Uab returns matrix 
%   Uab is the symmetric matrix composed of second partial derivatives of U with 
%   respect to the third body’s position evaluated along the orbit

d = sqrt((x+mu)^2+y^2+z^2);
r = sqrt((x - 1 + mu)^2+y^2+z^2);

Uxx = 1 - (1-mu)/d^3 - mu/r^3 + (3*(1-mu)*(x+mu)^2)/d^5 + (3*mu*(x-1+mu)^2)/r^5;
Uxy = (3*(1-mu)*(x+mu)*y)/d^5 + (3*mu*(x-1+mu)*y)/r^5;
Uyy = 1 - (1-mu)/d^3 - mu/r^3 + (3*(1-mu)*y^2)/d^5 + (3*mu*y^2)/r^5;

matrix(1,1) = Uxx; 
matrix(1,2) = Uxy;

matrix(2,1) = Uxy;
matrix(2,2) = Uyy;

end


