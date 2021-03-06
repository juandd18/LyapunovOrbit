function [U2_positive,U2_negative] = poincareMapOld(function_name,X_mainfold,k,tLimit,mu,C)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% poincare map
%U2 poincare section with y,Vy
U2_positive = zeros(1,3);
U2_counter = 1;
%U3 poincare section with y,Vy
U2_negative = zeros(1,3);
U3_counter = 1;

for n=1:k
    
    x0=X_mainfold(n,1:4)';
    options=odeset('Events',@limitCriteriaPoincare,'RelTol',1e-12,'AbsTol',1e-13);
    % a�adir para parar cuando x = 1-mu  
    [t,X]=ode113(function_name,[0 tLimit],x0,options,mu);
    %get size of X
    temp=size(X);
    
    % iterar hasta 4
    for i=2:temp(1,1)
        %poincare section U2 pag 114 Koon
        %  y < 0; Vx > 0
        % if( (X(i-1,1) < (1-mu) & (X(i,1) > (1-mu))) & (X(i,2) < 0) & (X(i,3) > 0))
        %  y < 0; Vy > 0
        % +- section
        
        r1_i = sqrt((X(i,1)+mu)^2 + X(i,2)^2);
        r2_i = sqrt((X(i,1)+mu-1)^2 + X(i,2)^2);
        
        % Vx
        Vx_i = sqrt( -X(i,3)^2 + X(i,1)^2 + X(i,2)^2 + (2*(1-mu))./r1_i + (2*mu)./r2_i + 2*C );
        
        if(  (X(i,2) < 0) )
            %fprintf('toco surface: %d\n', 1)
            row = [X(i,2) X(i,4) Vx_i ];
            U2_positive = [U2_positive;row];
            U2_counter = U2_counter + 1;
        end

        %poincare section U3 pag 114 Koon
        % x = 1-mu; y < 0; Vx < 0
        %if(  (X(i-1,1) < (1-mu) & (X(i,1) > (1-mu))) & (X(i,2) < 0)  & (X(i,4) < 0))
            %fprintf('toco surface: %d\n', 2)
        %    row = [X(i,2) X(i,4)];
        %    U2_negative = [U2_negative;row];
        %    U3_counter = U3_counter + 1;
        %end
    end

end


end

