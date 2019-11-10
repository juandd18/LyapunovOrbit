%clear

%% parameters
mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);

tLimit = 4

u1 = 1-mu;
u2=mu;
C = 3.094618

%% parameters perturbation
e = 0.4
Cr= 1 + e
Area= 110.5
mass= 8000.0

Ap = 1e-4%rand(1)
theta = 2*pi*1e-4% rand(1)

checkPertSolar = false
checkPertRandom = true

%% parameter orbit unstable

x= 1-mu
y= -0.148281363388881 %-0.00915951502265754 
Vy = 0.141839359931402 %0.084007456142864 

Vx_i = 0.0855013717112753
r1_i = sqrt((x+u2)^2 + y^2);
r2_i = sqrt((x-u1)^2 + y^2);

%U 
%U= -(x^2 + y^2)/2 - ((1-mu))/r1_i - (mu)/r2_i - (mu*(1-mu))/2;
U= -(x^2 + y^2)/2 - (u1)/r1_i - (u2)/r2_i - (u1*u2)/2;

% Vx
Vx_it = sqrt( -(Vy)^2 - 2*U  - C )

        
X = [x y Vx_i Vy]
%X = [0.987849886237367 -0.147193198313387 0.0433317948808526 -0.129650344384800]

%% forward integration

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-22);
numSteps=500;
tspan=linspace(0, 4.7,numSteps);
[t,X_forward]=ode113(@CRTBPForwardPerturbation,tspan,X,ode__opt,mu,Ap,theta,Cr,Area,mass,checkPertSolar,checkPertRandom);
save('lowEnergyForward_Perturbed.mat','X_forward');
%save('lowEnergyForward.mat','X_forward');

%% back perturbation

y= -0.148280832631322 %-0.148281363388881  
Vy= 0.141841295804242
Vx_i2 = 0.0854973171257835
X = [x y Vx_i2 Vy]

[t,X_backward]=ode113(@CRTBPBackwardPerturbation,tspan,X,ode__opt,mu,Ap,theta,Cr,Area,mass,checkPertSolar,checkPertRandom);
save('lowEnergyBackward_Perturbed.mat','X_backward');
%save('lowEnergyBackward.mat','X_backward');

%% plot all
figure
hold on

line(X_forward(:,1), X_forward(:,2),'Color','b')

line(X_backward(:,1), X_backward(:,2),'Color','r')
