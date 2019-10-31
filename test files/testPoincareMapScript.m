%% Parameters
clear
mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);

%% Unstable Manifold L1

k = 500
epsilon=1e-4;

X0 = [0.803317447531650 0 0 0.333418984453424];
%3.0946
C1 = jacobiConstant([0.803317447531650 0],[0 0.333418984453424],mu)
STM = reshape(eye(4),16,[])';
Xunstable = [X0 STM]';

periodoUnstable = 3.20588400919465;
X_mainfold_unstable = calculateUnStableMainfold(periodoUnstable,Xunstable,mu,k,epsilon,-1,false);

%% stable manifold L2

X0 = [1.19878035065113 0 0 -0.308573433311396];
C2 = jacobiConstant([1.19878035065113 0],[0 -0.308573433311396],mu)
%3.0946
STM = reshape(eye(4),16,[])';
Xstable = [X0 STM]';
periodoStable = 3.63716374726546;
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
[U2,U3] = callPoincareMap(X_mainfold_unstable,X_mainfold_stable,mu,k,C1,periodoStable*40,periodoUnstable*40);


