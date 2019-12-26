%clear

%% parameters
mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);

tLimit = 4

u1 = 1-mu;
u2=mu;

%% parameters perturbation
Ap = 1e-5
theta_rand = (2*pi-1).*rand(20,1) + 1;
theta_idx = 1:20;

checkPertSolar = false
checkPertRandom = true

%% forward integration NO PERTUBATION

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-22);
numSteps=500;
tspan=linspace(0, 5,numSteps);

X_1 = [0.815753936548411 -0.0472132107157492 -0.0466936951888057 0.236953184369842]
C = jacobiConstant( X_1(1,1:2),X_1(1,3:4),mu)
[t,X_forward_NoPerturbed]=ode113(@CRTBPForwardPerturbation,tspan,X_1,ode__opt,mu,0,0,0,0,0,0,false,false);

X_2 = [0.987849886237367 -0.106580488271987 0.217368543940649 0.0669452650823326]
[t,X_forward_NoPerturbed2]=ode113(@CRTBPForwardPerturbation,tspan,X_2,ode__opt,mu,0,0,0,0,0,0,false,false);

X_forward_NoPerturbed_final = [X_forward_NoPerturbed; X_forward_NoPerturbed2];

%% forward integration Perturbed
%generar 10 valores aleatorios 1-> 2pi
% utilizar la funcion s = spline(x,y,xq) xq time

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-14);
n = 10000;

[concat_lastPoint,concat_numPoints,X_forward_perturbed] = iterateRandomPerturbation(n,Ap,X_1,mu,X_forward_NoPerturbed(end,:),numSteps);

%% analysis
numOrbitsOK = sum(concat_numPoints)

mean_concat = mean(concat_lastPoint)
std_concat = std(concat_lastPoint)
var_concat = var(concat_lastPoint)

%% plot all
figure
hold on

plot(X_1(1),X_1(2),'r*')
line(X_forward_perturbed(:,1), X_forward_perturbed(:,2),'Color','b')
line(X_forward_NoPerturbed_final(:,1), X_forward_NoPerturbed_final(:,2),'Color','r')
title('Trayectoria de baja energía con Perturbación aleatoria Ap 1e-5');
grid on;
xlabel('x')
ylabel('y')
