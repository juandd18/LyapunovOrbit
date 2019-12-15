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
e = 0.90
Cr= 1 + e
Area= 110.5
mass= 8000.0

Ap = 2%rand(1)

checkPertSolar = false
checkPertRandom = true

%% forward integration NO PERTUBATION

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-22);
numSteps=500;
tspan=linspace(0, 8,numSteps);
[t,X_forward_NoPerturbed]=ode113(@CRTBPForwardPerturbation,tspan,X,ode__opt,mu,Ap,theta,Cr,Area,mass,false,false);


%% forward integration Perturbed

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-14);
numSteps=300;
tspan=linspace(0, 9,numSteps);
[t,X_forward_perturbed]=ode113(@CRTBPForwardPerturbation,tspan,X,ode__opt,mu,Ap,theta,Cr,Area,mass,checkPertSolar,checkPertRandom);

%% difference between no pertubed orbit and perturbed orbit
diff_orbit = abs(X_forward_NoPerturbed - X_forward_perturbed);
mean_diff = mean(diff_orbit)

%% plot all
figure
hold on

plot(X(1),X(2),'r*')
line(X_forward_perturbed(:,1), X_forward_perturbed(:,2),'Color','b')
title('Trayectoria de baja energía con Presión de Radiación solar Cr 1.90');
%title('Trayectoria de baja energía con Perturbación aleatoria 1e-4');
grid on;
xlabel('x')
ylabel('y')
