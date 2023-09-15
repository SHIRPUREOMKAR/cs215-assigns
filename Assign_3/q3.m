clc, clearvars
data = readtable('XYZ.txt');
X = data.Var1;
Y = data.Var2;
Z = data.Var3;
N = length(X); % could also enter 2000
A = [X Y ones(N, 1)];
Coefficients = (A' * A) \ (A' * Z);
a = Coefficients(1);
b = Coefficients(2);
c = Coefficients(3);

predicted_plane = sprintf('z = %.4fx + %.4fy + %.4f', a, b, c);

%%%%%%%%%%%%%%%%%%%%%%%%%%%

%noise calc
residuals = Z - (A * Coefficients);
predicted_noise_variance = var(residuals);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Predicted eq. of the plane : %s\n', predicted_plane);
fprintf('Predicted noise variance : %.4f\n', predicted_noise_variance);

