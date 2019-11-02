%% Parameters
clear
mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);

%% Unstable Manifold L1

k = 2000
epsilon=1e-6;

X0 = [0.803317447531650 0 0 0.333418984453424];
%[3.094618]
C1 = jacobiConstant(X0(1,1:2),X0(1,3:4),mu)
STM = reshape(eye(4),16,[])';
Xunstable = [X0 STM]';

periodoUnstable = 3.20588400919465;
[X_mainfold_unstable,UnstableVector] = calculateUnStableMainfold(periodoUnstable,Xunstable,mu,k,epsilon,-1,false);

%% stable manifold L2

X0 = [1.19878035065113 0 0 -0.308573433311396];
C2 = jacobiConstant(X0(1,1:2),X0(1,3:4),mu)
%[3.094618]
STM = reshape(eye(4),16,[])';
Xstable = [X0 STM]';
periodoStable = 3.63716374726546;
[X_mainfold_stable,stableVector] = calculateStableMainfold(periodoStable,Xstable,mu,k,epsilon,-1,false);

%% test manifolds
hold on 
plotStableMainfold(X_mainfold_stable,periodoStable*2,k,mu,'r')
plotUnStableMainfold(X_mainfold_unstable,periodoUnstable*2,k,mu,'b')
title('Conexion heteroclinica entre campos invariantes');
xlabel('X ');
ylabel('Y ');
grid on;
hold off
figure
%% call poincare map
[U2,U3] = callPoincareMap(X_mainfold_unstable,X_mainfold_stable,mu,k,C1,periodoStable*100,periodoUnstable*150);

% [lo , ii] = ismembertol(U2(:,1),U3(:,1),1e-6);
% y_eq_stable = U2(lo,:);
% y_eq_unstable = U3(ii(lo),:);
[lo , ii] = ismembertol(abs(U2(:,2)),abs(U3(:,2)),0.000001);
Vy_eq_stable = U2(lo,:);
Vy_eq_unstable = U3(ii(lo),:);

