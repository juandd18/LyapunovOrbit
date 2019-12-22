%clear

mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);


tLimit = 4

u1 = 1-mu;
u2=mu;

x= 1-mu
y= -0.148298
Vy = 0.141804

Vx_i = 0.08545284
r1_i = sqrt((x+u2)^2 + y^2);
r2_i = sqrt((x-u1)^2 + y^2);

%U 
%U= -(x^2 + y^2)/2 - ((1-mu))/r1_i - (mu)/r2_i - (mu*(1-mu))/2;
U= -(x^2 + y^2)/2 - (u1)/r1_i - (u2)/r2_i - (u1*u2)/2;
C = 3.094618 %NIVEL DE ENERGIA
% Vx
Vx_it = sqrt( -(Vy)^2 - 2*U  - C )

        
X = [x y Vx_i Vy];
%X = [0.987849886237367 -0.147193198313387 0.0433317948808526 -0.129650344384800]
C = jacobiConstant( X(1,1:2),X(1,3:4),mu)
ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-22);
numSteps=500;
tspan=linspace(0, 10,numSteps);
[t,X_forward]=ode113(@CRTBPForward,[0,4.7],X,ode__opt,mu);

y= -0.148298042463896
Vy= 0.14180
Vx_i2 = 0.08545284  %0,085478408543951
X = [x y Vx_i2 Vy];
C2 = jacobiConstant( X(1,1:2),X(1,3:4),mu)

[t,X_backward]=ode113(@CRTBPBackward,[0 4.27],X,ode__opt,mu);

%% plot all
figure
hold on

line(X_forward(:,1), X_forward(:,2),'Color','b')

line(X_backward(:,1), X_backward(:,2),'Color','r')
