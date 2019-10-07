function C = jacobiConstant(x,v,mu)
%jacobiConstant calcula la constante de jacobi

r1 = sqrt((x(1)+mu)^2 + x(2)^2);
r2 = sqrt((x(1)+mu-1)^2 + x(2)^2);

%Calcular Jacobi Constant
C = -(v(1)^2 + v(2)^2) + x(1)^2 + x(2)^2 + (2*(1-mu))./r1 + (2*mu)./r2;
end

