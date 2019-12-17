function [t,y] = rk_4orden(function_ref,lower_limit,upper_limit,initial_value,number_of_hs,mu,Ap,Cr,Area,mass,checkPertSolar,checkPertRandom)
%rubben_kutten_4orden metodo de rubben_kutten order 4

%h the step size,; tamaño del paso
h = (upper_limit - lower_limit) / number_of_hs;

%initialize memory space
t = lower_limit:h:upper_limit;
n = length(t);
%se cambia el tamaño de la matrix y pues nos pueden 
%enviar mas de un valor por ejemplo [0 2]
%para este caso tenemos una matrix de 2 filas y number_of_hs como columnas
y = zeros(length(initial_value),number_of_hs);

y(:,1) = initial_value;

for i=1:n-1
    theta = 2*pi*rand;
    k1 = h*feval(function_ref,t(i),y(:,i),mu,Ap,theta,Cr,Area,mass,checkPertSolar,checkPertRandom);
    k2 = h.*feval(function_ref, t(i)+(h/2), y(:,i)+(k1/2),mu,Ap,theta,Cr,Area,mass,checkPertSolar,checkPertRandom );
    k3 = h.*feval(function_ref, t(i)+(h/2), y(:,i)+(k2/2),mu,Ap,theta,Cr,Area,mass,checkPertSolar,checkPertRandom );
    k4 = h.*feval(function_ref, t(i) + h, y(:,i) + k3,mu,Ap,theta,Cr,Area,mass,checkPertSolar,checkPertRandom );
    y(:,i+1) = y(:,i) + (k1+ 2*k2 + 2*k3 + k4)/6;
end



