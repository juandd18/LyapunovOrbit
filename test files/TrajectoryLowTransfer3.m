%clear

mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);


tLimit = 4

u1 = 1-mu;
u2=mu;


%unstable

x= 1-mu
Vy= 0.0532145932672004;
y = -0.106352319445407;
Vx_i = 0.216085748756728;
        
X = [x y Vx_i Vy]
%constance 3.1367
C1 = jacobiConstant( X(1,1:2),X(1,3:4),mu)

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-22);
numSteps=500;
tspan=linspace(0, 10,numSteps);
[t,X_forward]=ode113(@CRTBPForward,[0,6],X,ode__opt,mu);

%stable
Vy= -0.0532140800567747;
y = -0.106651281862645;
Vx_i2 = 0.214617587830013;

X = [x y Vx_i2 Vy]
C2 = jacobiConstant( X(1,1:2),X(1,3:4),mu)
[t,X_backward]=ode113(@CRTBPBackward,[0 5],X,ode__opt,mu);

%% plot all
figure
hold on

line(X_forward(:,1), X_forward(:,2),'Color','b')
line(X_backward(:,1), X_backward(:,2),'Color','r')
title('Trayectoria de baja energia entre orbitas periódicas Lyapunov C = 13.67');
grid on;
xlabel('x')
ylabel('y')
