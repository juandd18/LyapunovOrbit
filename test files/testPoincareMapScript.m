%% Parameters
clear
mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);

%% Unstable Manifold L1

k = 80
epsilon=1e-4;

X0 = [0.797417447531649 0 0 0.373677867988008];
C1 = jacobiConstant([0.797417447531649 0],[0 0.373677867988008],mu)
STM = reshape(eye(4),16,[])';
Xunstable = [X0 STM]';

periodoUnstable = 3.41527940737424;
X_mainfold_unstable = calculateUnStableMainfold(periodoUnstable,Xunstable,mu,k,epsilon,false);

%% stable manifold L2

X0 = [1.20378035065113 0 0 -0.349555111713584];
C1 = jacobiConstant([1.20378035065113 0],[0 -0.349555111713584],mu)
STM = reshape(eye(4),16,[])';
Xstable = [X0 STM]';
periodoStable = 3.78224404468083;
X_mainfold_stable = calculateStableMainfold(periodoStable,Xstable,mu,k,epsilon,false);

%% test manifolds
hold on 
%plotStableMainfold(X_mainfold_stable,periodoStable,k,mu)
%plotUnStableMainfold(X_mainfold_unstable,periodoUnstable,k,mu)
%hold off

%% call poincare map
[U2,U3] = callPoincareMap(X_mainfold_unstable,X_mainfold_stable,mu,k,periodoStable*3,periodoUnstable*3);


