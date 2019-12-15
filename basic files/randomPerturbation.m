function accRandom = randomPerturbation(Ap)
%randomPerturbation Calcula una perturbacion aleatoria

theta = 2*pi*rand;
ax = Ap*cos(theta);
ay = Ap*sin(theta);

accRandom = [ax ay];
end

