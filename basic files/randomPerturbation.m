function accRandom = randomPerturbation(Ap,theta)
%randomPerturbation Calcula una perturbacion aleatoria

ax = Ap*cos(theta);
ay = Ap*sin(theta);

accRandom = [ax ay];
end

