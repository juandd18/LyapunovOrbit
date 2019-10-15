function [L1,L2,L3,L4x,L4y,L5x,L5y] = LibrationPoints(u)
%LibrationPoints Calculate the libration points

x0 = (u/3)^(1/3);
quintic2 = @(x) x.^5 - (3-u)*x.^4 + (3-2*u)*x.^3 -u*x.^2 +2*u*x -u;
Dx_quintic2 = @(x) 5*x.^4 - 4*(3-u)*x.^3 + 3*(3-2*u)*x.^2 -2*u*x +2*u;
x2 = newtonMethod(quintic2,Dx_quintic2,x0,300,1e-28);
L1 = (u-1) + x2;

x0 = 0.16786;
quintic = @(x) x.^5 + (3-u)*x.^4 + (3-2*u)*x.^3 -u*x.^2 -2*u*x -u;
Dx_quintic = @(x) 5*x.^4 + 4*(3-u)*x.^3 + 3*(3-2*u)*x.^2 -2*u*x -2*u;

x1 = newtonMethod(quintic,Dx_quintic,x0,300,1e-25);
L2 = (u-1) - x1;


quintic3 = @(x) x^5 + (2+u)*x^4 + (1+2*u)*x^3 - (1-u)*x^2 - 2*(1-u)*x - (1-u);
Dx_quintic3 = @(x) 5*x^4 + 4*(2+u)*x^3 + 3*(1+2*u)*x^2 - 2*(1-u) - 2*(1-u);
x0 = 1 - (7/12)*u;
x3 = newtonMethod(quintic3,Dx_quintic3,x0,3000,1e-15);
L3 = vpa(u) + vpa(x3);

%cal L4
L4x = vpa(1/2 - u);
L4y = 3^(1/2)/2;

%cal L5
L5x = L4x;
L5y = -3^(1/2)/2;


end

