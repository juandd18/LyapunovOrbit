function Acc = SolarPresion(x,t,Cr,Area,mass)
%SolarPresion Obtienen la aceleracion por la presion
%   solar basado en la formula 3.75 Monterbruck

P0=4.56e-6; % solar radiation pressure constant
A = 149.6e6; % km
AU = 149597871; %km
UD = 384400; %1UD = 384.400 km
wSun = 1.99102128e-7; % rad/seg

A_norm = A/UD;
AU_norm = AU/UD;
w_sun = 1.99102128e-7; %rad/seg   2pi/365.25

x_sun = A_norm*cos(w_sun*t);
y_sun = A_norm*sin(w_sun*t);

% Relative position vector of spacecraft w.r.t. Sun
d = x - [x_sun y_sun];

% Acceleration
Acc = Cr*P0*(Area/mass)*(d/(norm(d)^3))*(AU_norm^2);

end

