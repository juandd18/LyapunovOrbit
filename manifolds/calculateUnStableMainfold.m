function X_mainfold = calculateUnStableMainfold(periodo,X,mu,k,epsilon,plotGraph)
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
num_steps = size(X_periodica,1);


%% obtener la monodromy matrix 
mono = reshape(X_periodica(end,5:end),4,[]);

%% calcular los eigenvalues y eigenvectors de la monodramy matrix 
[mono_eigVectors, mono_eigVal]=eigs(mono);
mono_eigValues=diag(mono_eigVal);
% en matlab organiza mono_eigVectors de acuerdo a la magnitud de los 
%eigenvalues por esto el unstable vector esta en la primera posicion
UnstableVector = mono_eigVectors(1:4,1);

%% dividir la orbita periodica en k posiciones
% cambiar num_steps por numero filas de X_periodica
h=round((num_steps)/k);
for n=1:k
   if ((n-1)*h+1) > num_steps
       index = num_steps;
   else
       index = (n-1)*h+1;
   end
   orbitPoint(n,1:4)= X_periodica(index,1:4);
   orbitTimes(n)=t(index);
end

%% calcular stable mainfold orbit para cada intervalo
norm_perturbation =  UnstableVector/norm(UnstableVector);
X_mainfold(1,1:4) = orbitPoint(1,1:4)'+epsilon*norm_perturbation;

%para comprobar que esta bien
%cambiar el epsilon por la mitad la segunda vez
for n=2:k  
   X_mainfold(n,1:4) = orbitPoint(n,1:4)'+epsilon*norm_perturbation;
end

%if plotGraph is true we plot it
if(plotGraph)
plotUnStableMainfold(X_mainfold,periodo,k,mu)
end

end

