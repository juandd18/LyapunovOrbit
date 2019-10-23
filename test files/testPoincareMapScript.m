%% Parameters

mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);

%% Unstable Manifold L1

k = 80
epsilon=1e-6;

X0 = [0.811317447531650 0 0 0.258435942460320];
C1 = jacobiConstant([0.811317447531650 0],[0 0.258435942460320],mu)
STM = reshape(eye(4),16,[])';
Xunstable = [X0 STM]';

periodoUnstable = 2.95189015906488;
X_mainfold_unstable = calculateUnStableMainfold(periodoUnstable,Xunstable,mu,k,epsilon,false);

%% stable manifold L2

X0 = [1.18978035065113 0 0 -0.226624617139616];
C1 = jacobiConstant([1.18978035065113 0],[0 -0.226624617139616],mu)
STM = reshape(eye(4),16,[])';
Xstable = [X0 STM]';
periodoStable = 3.47969586271619;
X_mainfold_stable = calculateStableMainfold(periodoStable,Xstable,mu,k,epsilon,false);

%% call poincare map
[U2,U3] = callPoincareMap(X_mainfold_unstable,X_mainfold_stable,mu,k,periodoStable*2,periodoUnstable*2);
