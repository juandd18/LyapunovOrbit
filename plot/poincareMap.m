function [U2_positive] = poincareMap(function_name,X_mainfold,k,tLimit,mu,C)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% poincare map
%U2 poincare section with y,Vy
U2_positive = zeros(1,3);
U2_counter = 1;

for n=1:k
    
    x0=X_mainfold(n,1:4)';
    options=odeset('Events',@limitCriteriaPoincare,'RelTol',1e-13,'AbsTol',1e-22);
    % añadir para parar cuando x = 1-mu  
    [t,X]=ode113(function_name,[0 tLimit],x0,options,mu);
    %get size of X
    temp=size(X);
    
   
        %poincare section U2 pag 114 Koon
        %  y < 0; Vx > 0
        % if( (X(i-1,1) < (1-mu) & (X(i,1) > (1-mu))) & (X(i,2) < 0) & (X(i,3) > 0))
        %  y < 0; Vy > 0
        % +- section
        
        u1 = 1-mu;
        u2=mu;
        x = 1-mu;
        y = X(end,2);
        Vy = X(end,4);
        r1_i = sqrt((x+u2)^2 + y^2);
        r2_i = sqrt((x-u1)^2 + y^2);

        U= -(x^2 + y^2)/2 - (u1)/r1_i - (u2)/r2_i - (u1*u2)/2;
        % Vx
        Vx_i = sqrt( -(Vy^2) - 2*U  - C );
        
        if(  (X(end,2) < 0) & (Vx_i > 0) )
            %fprintf('toco surface: %d\n', 1)
            row = [X(end,2) X(end,4) X(end,3)];
            U2_positive = [U2_positive;row];
            U2_counter = U2_counter + 1;
        end

end


end

