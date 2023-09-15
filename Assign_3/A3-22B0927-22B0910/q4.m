clc, clearvars;
rng(randi(200))
data = sqrt(16) * randn(1000, 1);
T = data(1:750);
V = data(751:end);
sig_vals = [0.001, 0.1, 0.2, 0.9, 1, 2, 3, 5, 10, 20, 100];
LL_values = zeros(size(sig_vals));
D_vals = zeros(size(sig_vals));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(sig_vals)
    sigma = sig_vals(i);
    
    LL = 0;
    for j = 1:length(V)
        xi = V(j);
        kde_estimate = sum(exp(-(T-xi).^2/(2*sigma^2)))/(length(T)*sigma*sqrt(2*pi));
        LL = LL + log(kde_estimate);
    end
    LL_values(i) = LL;
    
    D = 0;
    for j = 1:length(V)
        xi = V(j);
        true_pdf = (1/sqrt(2*pi*16))*exp(-(xi^2)/(2*16));
        kde_estimate = sum(exp(-((T-xi).^2)/(2*sigma^2)))/(length(T)*sigma*sqrt(2*pi));
        D = D + (true_pdf - kde_estimate)^2;
    end
    D_vals(i) = D;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot D vs. log(sigma)
figure;
plot(log(sig_vals), D_vals, 'b', 'LineWidth', 1);
title('Discrepancy (D) vs. Log Sigma');
xlabel('Log Sigma');
ylabel('Discrepancy (D)');
grid on;

% Create a new figure for Log Likelihood vs. Log Sigma
figure;
semilogx(sig_vals, LL_values);
title('Log Likelihood vs. Log Sigma');
xlabel('Log Sigma');
ylabel('Log Likelihood');
grid on;

% Calculate true density, kernel density, and estimated density
Y = -8:0.1:8;
s_val = [];
p_true = zeros(size(Y));
p_kernel = zeros(size(Y));
p_estimated = zeros(size(Y));

best_D = sig_vals(D_vals == min(D_vals)); % Find the best_D value

for i = 1:length(Y)
    x = Y(i);
    p_true(i) = exp(-x^2/32)/(4*sqrt(2*pi));
    p_kernel(i) = sum(exp(-((T-x).^2)/(2*best_D^2)))/(length(T)*best_D*sqrt(2*pi));
    p_estimated(i) = sum(exp(-((T-x).^2)/(2*best_D^2)))/(length(T)*best_D*sqrt(2*pi));
end

% Create a new figure for True Density, Kernel Density, and Estimated Density
figure;
plot(Y, p_true, 'b', 'LineWidth', 1);
hold on;
plot(Y, p_estimated, 'g', 'LineWidth', 1);
title('True Density and Estimated Density');
xlabel('x');
ylabel('Density');
legend('True', 'Estimated');
grid on;
