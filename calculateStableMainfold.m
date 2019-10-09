function X_mainfold = calculateStableMainfold(periodo,X,mu,k,num_steps,plotGraph)
%calculateStableMainfold calcula el stable mainfold de una orbita
%periodioca en este case lyapunov pero podria ser otra, se toma k puntos
%para partir la orbita luego se calcula la matrix monodromy
%se obtiene los eigenvalues y el eigenvectors
%utilizando la formula 4.4.2 y 4.4.3 Koon
%2.62 - 2.65 LOW-ENERGY LUNAR TRAJECTORY DESIGN
%generamos los manifolds

%% generar la orbita periodica
ode__opt = odeset('RelTol',1e-9,'AbsTol',1e-9);
[t, X_periodica] = ode113(@CRTBPLyapunov, [0 periodo],X , ode__opt, mu); 

%% obtener la monodromy matrix 
mono = reshape(X_periodica(end,5:end),4,[]);

%% calcular los eigenvalues y eigenvectors de la monodramy matrix 
[mono_eigVectors, mono_eigVal]=eigs(mono);
mono_eigValues=diag(mono_eigVal);
% en matlab organiza mono_eigVectors de acuerdo a la magnitud de los 
%eigenvalues por esto el stable vector esta en la ultima posicion
stableVector = mono_eigVectors(1:4,4);

%% dividir la orbita periodica en k posiciones
h=round((num_steps-1)/k);
for n=1:k
   orbitPoint(n,1:4)= X_periodica((n-1)*h+1,1:4);
   orbitTimes(n)=t((n-1)*h+1);
end

%% calcular stable mainfold orbit para cada intervalo
epsilon=1e-6;
for n=2:k
   ode__opt = odeset('RelTol',1e-9,'AbsTol',1e-9);
   [t, X_n] = ode113(@CRTBPLyapunov, [0 orbitTimes(n)],X , ode__opt, mu);
   
   mono_n = reshape(X_n(end,5:end),4,[]);
   %perturbationVector = mono*stableVector;
   perturbationVector = mono_n*stableVector;
   norm_perturbation = perturbationVector/norm(perturbationVector);
   X_mainfold(n,1:4) = orbitPoint(n,1:4)'+epsilon*norm_perturbation;
end

%if plotGraph is true we plot it
if(plotGraph)
plotUnStableMainfold(X_mainfold,periodo,k,mu)
end


end

