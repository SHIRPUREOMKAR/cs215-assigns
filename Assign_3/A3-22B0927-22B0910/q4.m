clc, clearvars;
rng(123)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
        kde_estimate = sum(exp(-(T-xi).^2/(2*sigma^2)))/(length(T)*sigma*sqrt(2*pi));
        D = D + (true_pdf - kde_estimate)^2;
    end
    D_vals(i) = D;
end

[~, best_LL_idx] = max(LL_values);
[~, best_D_idx] = min(D_vals);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
semilogx(sig_vals, LL_values);
title('Log Likelihood vs. Log \sigma');
xlabel('Log \sigma');
ylabel('Log Likelihood');
grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


best_LL = sig_vals(best_LL_idx);
best_D = sig_vals(best_D_idx);

fprintf('Best Sigma for LL: %.3f\n', best_LL);
fprintf('Best Sigma for D: %.3f\n', best_D);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_values = -15:0.1:15;
best_est = zeros(size(x_values));
tru_vals = zeros(size(x_values));

for i = 1:length(x_values)
    x = x_values(i);
    best_est(i) = sum(exp(-(T-x).^2/(2*best_LL^2)))/(length(T)*best_LL*sqrt(2*pi));
    tru_vals(i) = (1/sqrt(2*pi*16))*exp(-(x^2)/(2*16));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot(x_values, best_est, 'b', 'LineWidth', 1);
hold on;
plot(x_values, tru_vals, 'r', 'LineWidth', 1);
title('KDE Estimate vs. True PDF');
xlabel('x');
ylabel('Density');
legend('KDE Estimate', 'True PDF');
grid on;
