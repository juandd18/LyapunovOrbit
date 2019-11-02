%clear

mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);


tLimit = 4

u1 = 1-mu;
u2=mu;
C = 3.094618


x= 1-mu
y= -0.0038192 %-0.00915951502265754 
Vy = 0.061175 %0.084007456142864 

Vx_i = 2.49433 %1.5808029430961
r1_i = sqrt((x+u2)^2 + y^2);
r2_i = sqrt((x-u1)^2 + y^2);

%U 
%U= -(x^2 + y^2)/2 - ((1-mu))/r1_i - (mu)/r2_i - (mu*(1-mu))/2;
U= -(x^2 + y^2)/2 - (u1)/r1_i - (u2)/r2_i - (u1*u2)/2;

% Vx
Vx_it = sqrt( -(Vy)^2 - 2*U  - C )

        
X = [x y Vx_i Vy]
%X = [0.987849886237367 -0.147193198313387 0.0433317948808526 -0.129650344384800]

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-22);
numSteps=500;
tspan=linspace(0, 10,numSteps);
[t,X_forward]=ode113(@CRTBPForward,[0,5],X,ode__opt,mu);

y= -0.0038  %-0.00915178440714022
Vy= -0.0611 %-0.084827489061836
Vx_i2 = 2.484 %1.58146279522574;
X = [x y Vx_i2 Vy]
%X = [0.987849886237375 -0.0140597942193365 1.25087982275888 -0.128938239713086]
[t,X_backward]=ode113(@CRTBPBackward,[0 4.4],X,ode__opt,mu);

%test 
figure
periodoStable = 3.44846874965892;
options=odeset('Events',@limitCriteriaPoincare,'RelTol',1e-12,'AbsTol',1e-13);
    [t,X_test]=ode113(@CRTBPBackward,[0 periodoStable*5],X_mainfold_stable(1,1:4),options,mu);
    plot(X_test(:,1), X_test(:,2),'r')
X_test(end,1:4)

figure 
X_test_n = [0.9878   -0.0007    5.1831   -2.5714];
hold on
[t,X_test1]=ode113(@CRTBPForward,[0 periodoStable],X_test(end,1:4),ode__opt,mu);
plot(X_test1(:,1), X_test1(:,2),'r')


[t,X_test2]=ode113(@CRTBPForward,[0 periodoStable*5],X_mainfold_unstable(1,1:4),options,mu);
plot(X_test2(:,1), X_test2(:,2),'b')

[t,X_test2]=ode113(@CRTBPBackward,[0 periodoStable],X_test2(end,1:4),ode__opt,mu);
plot(X_test2(:,1), X_test2(:,2),'b')

%test worked
%[t,X_backward]=ode113(@CRTBPBackward,[0,tLimit],X_forward(end,1:4),options,mu);

%% generar orbita periodica L1
X_periodica_L1 = [0.813517447531650 0 0 0.234489489311834];
periodoUnstable = 2.89665723647887;

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-18);
[tFinal, Xperiodica_L1] = ode113(@CRTBPForward, [0 periodoUnstable],X_periodica_L1 , ode__opt, mu); 

%% generar orbita periodica L2
X_periodica_L2 = [1.18638035065113 0 0 -0.198068281472250];
periodoStable = 3.44846874965892;
ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-16);
[tFinal, Xperiodica_L2] = ode113(@CRTBPBackward, [0 periodoStable],X_periodica_L2 , ode__opt, mu); 

%% plot all
figure
hold on
plot(Xperiodica_L2(:,1), Xperiodica_L2(:,2))
plot(Xperiodica_L1(:,1), Xperiodica_L1(:,2))

line(X_forward(:,1), X_forward(:,2),'Color','b')

line(X_backward(:,1), X_backward(:,2),'Color','r')
