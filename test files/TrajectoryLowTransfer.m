clear

mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);

C = 3.1451
tLimit = 0.4

x=1-mu
y=-2.6e-3
Vy = -2.6e-3
r1_i = sqrt((x+mu)^2 + y^2);
r2_i = sqrt((x+mu-1)^2 + y^2);
        
% Vx
Vx_i = -sqrt( -Vy^2 + x^2 + y^2 + (2*(1-mu))./r1_i + (2*mu)./r2_i + 2*C );
        
X = [x y Vx_i Vy]

options=odeset('RelTol',1e-6,'AbsTol',1e-9);
numSteps=2000;
tspan=linspace(0, tLimit,numSteps);
[t,X_forward]=ode113(@CRTBPForward,tspan,X,options,mu);

tspan=linspace(-tLimit,0,numSteps);
options=odeset('RelTol',1e-6,'AbsTol',1e-9);
[t,X_backward]=ode113(@CRTBPBackward,tspan,X,options,mu);

%% generar orbita periodica L1
X_periodica_L1 = [0.803317447531650 0 0 0.333418984453424];
periodoUnstable = 3.20588400919465;

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-18);
[tFinal, Xperiodica_L1] = ode113(@CRTBPForward, [0 periodoUnstable],X_periodica_L1 , ode__opt, mu); 

%% generar orbita periodica L2
X_periodica_L2 = [1.19878035065113 0 0 -0.308573433311396];
periodoStable = 3.63716374726546;;
ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-16);
[tFinal, Xperiodica_L2] = ode113(@CRTBPBackward, [0 periodoStable],X_periodica_L2 , ode__opt, mu); 

%% plot all
figure
hold on
plot(Xperiodica_L2(:,1), Xperiodica_L2(:,2))
plot(Xperiodica_L1(:,1), Xperiodica_L1(:,2))

line(X_forward(:,1), X_forward(:,2),'Color','b')

line(X_backward(:,1), X_backward(:,2),'Color','r')
