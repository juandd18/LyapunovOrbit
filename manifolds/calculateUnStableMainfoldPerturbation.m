function [X_mainfold,UnstableVector] = calculateUnStableMainfoldPerturbation(periodo,X,mu,k,epsilon,signo,plotGraph,Ap,theta,Cr,Area,mass)
%calculateStableMainfold calcula el stable mainfold de una orbita 
%periodioca en este case lyapunov pero podria ser otra, se toma k puntos
%para partir la orbita luego se calcula la matrix monodromy
%se obtiene los eigenvalues y el eigenvectors
%utilizando la formula 4.4.2 y 4.4.3 Koon
%2.62 - 2.65 LOW-ENERGY LUNAR TRAJECTORY DESIGN
%generamos los manifolds


%% generar la orbita periodica
ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-22);
tspan = linspace(0,periodo,k);
[t, X_periodica] = ode113(@CRTBPLyapunovPerturbation, tspan,X , ode__opt, mu,Ap,theta,Cr,Area,mass); 
num_steps = size(X_periodica,1);


%% obtener la monodromy matrix 
mono = reshape(X_periodica(end,5:end),4,[]);

%% calcular los eigenvalues y eigenvectors de la monodramy matrix 
[mono_eigVectors, mono_eigVal]=eigs(mono);
mono_eigValues=diag(mono_eigVal);
% en matlab organiza mono_eigVectors de acuerdo a la magnitud de los 
%eigenvalues por esto el unstable vector esta en la primera posicion
UnstableVector = signo*mono_eigVectors(1:4,1);

%% dividir la orbita periodica en k posiciones
% cambiar num_steps por numero filas de X_periodica
h=round((num_steps)/k)
for n=1:k
   if ((n-1)*h+1) > num_steps
       index = num_steps;
   else
       index = (n-1)*h+1;
   end
   orbitPoint(n,1:4)= X_periodica(index,1:4);
   orbitSTM(n,1:16) = X_periodica(index,5:end);
   orbitTimes(n)=t(index);
end

%% calcular stable mainfold orbit para cada intervalo
norm_perturbation =  UnstableVector/norm(UnstableVector);
X_mainfold(1,1:4) = orbitPoint(1,1:4)'+epsilon*norm_perturbation;

%para comprobar que esta bien
%cambiar el epsilon por la mitad la segunda vez
for n=2:k  
   %metodo 1
     X_mainfold(n,1:4) = orbitPoint(n,1:4)'+epsilon*norm_perturbation;

   %metodo 3 
%     stm_new_point = reshape(orbitSTM(n,1:16),4,[])*norm_perturbation;
%     norm_perturbation_n =  stm_new_point/norm(stm_new_point);
%     X_mainfold(n,1:4) = orbitPoint(n,1:4)'+epsilon*norm_perturbation_n;
   
   %metodo 2
%    STM = reshape(eye(4),16,[])';
%    X_new = [orbitPoint(n,1:4) STM]';
%    [t, X_new_point] = ode113(@CRTBPLyapunov, [0 periodo],X_new , ode__opt, mu);
%    %obtener la monodromy matrix 
%    mono_new_point = reshape(X_new_point(end,5:end),4,[]);
%    [mono_eigVectors, mono_eigVal]=eigs(mono_new_point);
%    UnstableVector_n = signo*mono_eigVectors(1:4,1);
%    norm_perturbation_n =  UnstableVector_n/norm(UnstableVector_n);
%    X_mainfold(n,1:4) = orbitPoint(n,1:4)'+epsilon*norm_perturbation_n;

end

%if plotGraph is true we plot it
if(plotGraph)
plotUnStableMainfold(X_mainfold,periodo*30,k,mu,'r')
end

end

