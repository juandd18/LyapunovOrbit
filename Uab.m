function matrix = Uab(mu,x,y,z)
%Uab returns matrix 
%   Uab is the symmetric matrix composed of second partial derivatives of U with 
%   respect to the third body’s position evaluated along the orbit

matrix(1,1) = (mu-1)/((mu+x)^2 + y^2 + z^2)^(3/2) - mu/((mu+x-1)^2 + y^2 + z^2)^(3/2) + (3*mu*(2*mu+2*x-2)*(mu+x-1))/(2*((mu+x-1)^2 + y^2 + z^2)^(5/2)) - (3*(2*mu+2*x)*(mu+x)*(mu-1))/(2*((mu+x)^2 + y^2 + z^2)^(5/2)) + 1;
matrix(1,2) = (3*mu*y*(mu+x-1))/((mu+x-1)^2 + y^2 + z^2)^(5/2) - (3*y*(mu+x)*(mu-1))/((mu+x)^2 + y^2 + z^2)^(5/2);
%matrix(1,3) = (3*mu*z*(mu+x-1))/((mu+x-1)^2 + y^2 + z^2)^(5/2) - (3*z*(mu+x)*(mu-1))/((mu+x)^2 + y^2 + z^2)^(5/2);

matrix(2,1) = (3*mu*y*(2*mu+2*x-2))/(2*((mu+x-1)^2 + y^2 + z^2)^(5/2)) - (3*y*(2*mu+2*x)*(mu-1))/(2*((mu+x)^2 + y^2 + z^2)^(5/2));
matrix(2,2) = (mu-1)/((mu+x)^2 + y^2 + z^2)^(3/2) - mu/((mu+x-1)^2 + y^2 + z^2)^(3/2) - (3*y^2*(mu-1))/((mu+x)^2 + y^2 + z^2)^(5/2) + (3*mu*y^2)/((mu+x-1)^2 + y^2 + z^2)^(5/2) + 1;
%matrix(2,3) = (3*mu*y*z)/((mu+x-1)^2 + y^2 + z^2)^(5/2) - (3*y*z*(mu-1))/((mu+x)^2 + y^2 + z^2)^(5/2);

%matrix(3,1) = (3*mu*z*(2*mu + 2*x - 2))/(2*((mu + x - 1)^2 + y^2 + z^2)^(5/2)) - (3*z*(2*mu + 2*x)*(mu - 1))/(2*((mu + x)^2 + y^2 + z^2)^(5/2));
%matrix(3,2) = (3*mu*y*z)/((mu + x - 1)^2 + y^2 + z^2)^(5/2) - (3*y*z*(mu - 1))/((mu + x)^2 + y^2 + z^2)^(5/2);
%matrix(3,3) = (mu - 1)/((mu + x)^2 + y^2 + z^2)^(3/2) - mu/((mu + x - 1)^2 + y^2 + z^2)^(3/2) - (3*z^2*(mu - 1))/((mu + x)^2 + y^2 + z^2)^(5/2) + (3*mu*z^2)/((mu + x - 1)^2 + y^2 + z^2)^(5/2);

end


