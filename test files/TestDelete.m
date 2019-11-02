

for n=1:k
    
    x0=X_mainfold_stable(n,1:4)';
    options=odeset('Events',@limitCriteriaPoincare,'RelTol',1e-13,'AbsTol',1e-22);
    % añadir para parar cuando x = 1-mu  
    [t,X]=ode113(@CRTBPBackward,[0 50],x0,options,mu);
    stable_manifold_end(n,1:4) = X(end,1:4);
end

for n=1:k
    
    x0=X_mainfold_unstable(n,1:4)';
    options=odeset('Events',@limitCriteriaPoincare,'RelTol',1e-13,'AbsTol',1e-22);
    % añadir para parar cuando x = 1-mu 
    [t,X]=ode113(@CRTBPForward,[0 50],x0,options,mu);
    unstable_manifold_end(n,1:4) = X(end,1:4);
end

% [lo , Loci] = ismembertol(abs(stable_manifold_end(:,2)),abs(unstable_manifold_end(:,2)),1e-4);
% y_eq_stable = stable_manifold_end(lo,:);
% y_eq_unstable = unstable_manifold_end(Loci(lo),:);

[lo , ii] = ismembertol(stable_manifold_end(:,4),unstable_manifold_end(:,4),1e-6);
Vy_eq_stable = stable_manifold_end(lo,:);
Vy_eq_unstable = unstable_manifold_end(ii(lo),:);

% [lo , Loci] = ismembertol(stable_manifold_end(:,2:4),unstable_manifold_end(:,2:4),1e-3,'ByRows', true);
% y_eq_stable = stable_manifold_end(lo,:);
% y_eq_unstable = unstable_manifold_end(Loci(lo),:);

