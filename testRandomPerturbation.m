%clear

%% parameters
mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);

tLimit = 4

u1 = 1-mu;
u2=mu;
C = 3.094618

X = [0.907161597118030 0.0841789206619423 -0.0324212073604759 -0.298181675795112]

%% parameters perturbation
Ap = 1e-4
theta_rand = (2*pi-1).*rand(20,1) + 1;
theta_idx = 1:20;

checkPertSolar = false
checkPertRandom = true

%% forward integration NO PERTUBATION

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-22);
numSteps=500;
tspan=linspace(0, 9,numSteps);
[t,X_forward_NoPerturbed]=ode113(@CRTBPForwardPerturbation,tspan,X,ode__opt,mu,0,0,0,0,0,0,false,false);


%% forward integration Perturbed
%generar 10 valores aleatorios 1-> 2pi
% utilizar la funcion s = spline(x,y,xq) xq time

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-14);
n = 10000;

[concat_lastPoint,concat_numPoints,X_forward_perturbed] = iterateRandomPerturbation(n,Ap,X,mu,X_forward_NoPerturbed(end,:),numSteps);

%% analysis
numOrbitsOK = sum(concat_numPoints)

mean_concat = mean(concat_lastPoint)
std_concat = std(concat_lastPoint)
var_concat = var(concat_lastPoint)

%% plot all
figure
hold on

plot(X(1),X(2),'r*')
line(X_forward_perturbed(:,1), X_forward_perturbed(:,2),'Color','b')
line(X_forward_NoPerturbed(:,1), X_forward_NoPerturbed(:,2),'Color','r')
title('Trayectoria de baja energ�a con Perturbaci�n aleatoria Ap 1e-5');
grid on;
xlabel('x')
ylabel('y')
