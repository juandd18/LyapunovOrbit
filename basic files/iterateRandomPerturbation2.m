function [concat_lastPoint,concat_numPoints,X_forward_perturbed] = iterateRandomPerturbation2(n,Ap,X_1,mu,X_lastPoint,numSteps)
%iterateRandomPerturbation iterates n times taking an acceleration 
%randomly taking angle theta

ode__opt = odeset('RelTol',1e-13,'AbsTol',1e-14);
tspan=linspace(0, 5,numSteps);

concat_lastPoint = [];
concat_numPoints = [];
%define x and y region of good end
% x: 1 -- 1.1
% y: -0.1 -- 0.1

x1=1.04;
x2=1.08;
y1=0;
y2=0.1;
xv = [x1, x2, x2, x1, x1];
yv = [y1, y1, y2, y2, y1];
%plot(x, y, 'b-');
iter=1;
for c = 1:n
    theta_rand = (2*pi-1).*rand(20,1) + 1;
    theta_idx = 1:20;
    [t,X_forward_perturbed]=ode113(@CRTBPForwardPerturbation,tspan,X_1,ode__opt,mu,Ap,theta_rand,theta_idx,0,0,0,0,true);
    
    X_lastPoint_NoPerturbed = abs(X_lastPoint - X_forward_perturbed(end,:));
    concat_lastPoint = [concat_lastPoint;X_lastPoint_NoPerturbed];
    
    %%find in-range points
    [in_box,on_box] = inpolygon(X_forward_perturbed(end,1),X_forward_perturbed(end,2),xv,yv);
    %num points inside good box
    num_points = numel(X_forward_perturbed(in_box,1));
    concat_numPoints = [concat_numPoints;num_points];
    iter=iter+1
end

end

