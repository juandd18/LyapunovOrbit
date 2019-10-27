%% Parameters
clear
mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);

%% Unstable Manifold L1

k = 200
epsilon=1e-4;

X0 = [0.813517447531650 0 0 0.234489489311834];
%3.1451
C1 = jacobiConstant([0.813517447531650 0],[0 0.234489489311834],mu)
STM = reshape(eye(4),16,[])';
Xunstable = [X0 STM]';

periodoUnstable = 2.89665723647887;
X_mainfold_unstable = calculateUnStableMainfold(periodoUnstable,Xunstable,mu,k,epsilon,false);

%% stable manifold L2

X0 = [1.18638035065113 0 0 -0.198068281472250];
C1 = jacobiConstant([1.18638035065113 0],[0 -0.198068281472250],mu)
STM = reshape(eye(4),16,[])';
Xstable = [X0 STM]';
periodoStable = 3.44846874965892;
X_mainfold_stable = calculateStableMainfold(periodoStable,Xstable,mu,k,epsilon,-1,false);

%% test manifolds
hold on 
plotStableMainfold(X_mainfold_stable,periodoStable,k,mu,'r')
plotUnStableMainfold(X_mainfold_unstable,periodoUnstable,k,mu,'b')
title('Conexion heteroclinica entre campos invariantes');
xlabel('X ');
ylabel('Y ');
grid on;
hold off
figure
%% call poincare map
[U2,U3] = callPoincareMap(X_mainfold_unstable,X_mainfold_stable,mu,k,15,10);


