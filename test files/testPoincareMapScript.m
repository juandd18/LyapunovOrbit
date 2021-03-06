%% Parameters
clear
mMoon =7.348e22;% kg
mEarth = 5.9742e24; %kg
mu = mMoon/(mMoon + mEarth);

%% Unstable Manifold L1

%k = 5000;
k = 800;
epsilon=1e-6;

%[0.803317447531650 0 0 0.333418984453424]  v1
%[3.094618]  v1
% 3.205884 periodo v1

%X0 = [0.811257447531650 0 0 0.259076017891584]; v2
%2.95350667318255; periodo v2

%X0 = [0.811257447531650 0 0 0.259076017891584]; v3
%2.93916351758083; periodo v3

X0 = [0.813387447531650 0 0 0.235925325028432];

C1 = jacobiConstant(X0(1,1:2),X0(1,3:4),mu)
STM = reshape(eye(4),16,[])';
Xunstable = [X0 STM]';

periodoUnstable = [2.89969708402775];
[X_mainfold_unstable,UnstableVector] = calculateUnStableMainfold(periodoUnstable,Xunstable,mu,k,epsilon,1,false);

%% stable manifold L2

%[1.19878035065113 0 0 -0.308573433311396] v1
%[3.094618]  v1
%3.63716374726546 periodo v1

%X0 = [1.18986035065113	0	0	-0.227318985869281]; v2
%3.48057698438254 periodo v2

%X0 = [1.18908035065113 0 0 -0.220586146027427]; v3
%3.47240464793725 periodo v3

X0 = [1.19458035065113 0 0 -0.269907447509653];
C2 = jacobiConstant(X0(1,1:2),X0(1,3:4),mu)

STM = reshape(eye(4),16,[])';
Xstable = [X0 STM]';

periodoStable = [3.54699198402649];
epsilon=1e-6;
[X_mainfold_stable,stableVector] = calculateStableMainfold(periodoStable,Xstable,mu,k,epsilon,-1,false);

%% test manifolds
hold on 
plotStableMainfold(X_mainfold_stable,periodoStable*3,k,mu,'r')
plotUnStableMainfold(X_mainfold_unstable,periodoUnstable*2,k,mu,'b')
plot([1-mu 1-mu],[-0.2 0.2],'k','LineWidth',3)
title('Variedades Invariantes sobre las Orbitas Lyapunov');
xlabel('X ');
ylabel('Y ');
grid on;
hold off
figure
%% call poincare map
[U2,U3] = callPoincareMap(X_mainfold_unstable,X_mainfold_stable,mu,k,C1,periodoStable*200,periodoUnstable*200);

[lo , ii] = ismembertol(U2(:,1),U3(:,1),0.00001);
y_eq_stable = U2(lo,:);
y_eq_unstable = U3(ii(lo),:);
[lo , ii] = ismembertol(abs(U2(:,2)),abs(U3(:,2)),0.0000001);
Vy_eq_stable = U2(lo,:);
Vy_eq_unstable = U3(ii(lo),:);

