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
e = 0.9
Cr= 1 + e
Area= 110.5
mass= 8000.0

theta = 0
Ap = 1e-5
theta_rand = (2*pi-1).*rand(20,1) + 1;
theta_idx = 1:20;

checkPertSolar = false
checkPertRandom = true

%% forward integration NO PERTUBATION

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-22);
numSteps=500;
tspan=linspace(0, 8.5,numSteps);
[t,X_forward_NoPerturbed]=ode113(@CRTBPForwardPerturbation,tspan,X,ode__opt,mu,0,0,0,Cr,Area,mass,false,false);


%% forward integration Perturbed
%generar 10 valores aleatorios 1-> 2pi
% utilizar la funcion s = spline(x,y,xq) xq time

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-14);

tspan=linspace(0, 8,numSteps);
[t,X_forward_perturbed]=ode113(@CRTBPForwardPerturbation,tspan,X,ode__opt,mu,Ap,theta_rand,theta_idx,Cr,Area,mass,checkPertSolar,checkPertRandom);
%numSteps=499;
%[t,X_forward_perturbed]=rk_4orden(@CRTBPForwardPerturbation,0,9,X,numSteps,mu,Ap,Cr,Area,mass,checkPertSolar,checkPertRandom);
%X_forward_perturbed = X_forward_perturbed'

%% difference all orbit between no pertubed orbit and perturbed orbit
diff_orbit = abs(X_forward_NoPerturbed - X_forward_perturbed);
mean_diff = mean(diff_orbit)

%% difference last point between no pertubed orbit and perturbed orbit
last_point_diff_orbit = abs(X_forward_NoPerturbed(end,:) - X_forward_perturbed(end,:))

%% plot all
figure
hold on

plot(X(1),X(2),'r*')
line(X_forward_perturbed(:,1), X_forward_perturbed(:,2),'Color','b')
line(X_forward_NoPerturbed(:,1), X_forward_NoPerturbed(:,2),'Color','r')
title('Trayectoria de baja energía con Perturbación aleatoria Ap 1e-4');
grid on;
xlabel('x')
ylabel('y')
