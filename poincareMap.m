function [U2,U3] = poincareMap(Xunstable,mu,k,periodo,tLimit)
%UNTITLED Summary of this function goes here
%   passIterates: cuantos intersecciones en el poincare map

%% parameters
poincare_x = 1-mu;

%% unstable manifold
X_mainfold = calculateUnStableMainfold(periodo,Xunstable,mu,k,100,false);

%% poincare map
%U2 poincare section with y,Vy
U2 = zeros(500,2);
U2_counter = 1;
%U3 poincare section with y,Vy
U3 = zeros(500,2);
U3_counter = 1;
for n=1:k
    
    x0=X_mainfold(n,1:4)';
    options=odeset('RelTol',1e-13,'AbsTol',1e-13);
    [t,X]=ode113(@CRTBPForward,[0 tLimit],x0,options,mu);
    %get size of X
    temp=size(X);
    
    for i=2:temp(1,1)
        %poincare section U2 pag 114 Koon
        % x = 1-mu; y < 0; Vx > 0
        if( (X(i-1,1) < (1-mu) & (X(i,1) > (1-mu))) & (X(i,2) < 0) & (X(i,3) > 0))
            %fprintf('toco surface: %d\n', 1)
            U2(U2_counter,1) = X(i,2);
            U2(U2_counter,2) = X(i,4);
            U2_counter = U2_counter + 1;
        end

        %poincare section U3 pag 114 Koon
        % x = 1-mu; y > 0; Vx < 0
        if(  (X(i-1,1) < (1-mu) & (X(i,1) > (1-mu))) & (X(i,2) > 0) & (X(i,3) < 0))
            %fprintf('toco surface: %d\n', 2)
            U3(U3_counter,1) = X(i,2);
            U3(U3_counter,2) = X(i,4);
            U3_counter = U3_counter + 1;
        end
    end

end

%% plot poincare
hold on
plot(U2(:,1), U2(:,2),'.')
xlabel('y')
ylabel('Vy')
%plot(U3(:,1), U3(:,2),'*')

end

