clc, clearvars
probs = [0.05, 0.4, 0.15, 0.3, 0.1];
sample_sizes = [5, 10, 20, 50, 100, 200, 500, 1000, 5000, 10000];
n = 50;
M = [];

for i = 1:length(sample_sizes)
    N = sample_sizes(i);
    sample = [];
    for j = 1:5000
        rand_values = rand(1, N);
        cum_prob = cumsum(probs);
        rand_value = zeros(size(rand_values));
        for k = 1:N
            rand_value(k) = find(rand_values(k) <= cum_prob, 1);
        end
        m = mean(rand_value);
        sample(end+1, 1) = m;
    end
    mu = mean(sample);
    sigma = std(sample);
    [f, x] = ecdf(sample);
    gaus = normcdf(x, mu, sigma);
    diff = abs(f - gaus);
    M(end+1, 1) = max(diff);
    
    figure(1);
    subplot(2, 5, i);
    plot(x, f);
    hold on
    plot(x, gaus);
    hold off
    xlabel("Value of the Xavg");
    ylabel("CDF");
    title(['Sample Size: ', num2str(N)]);
    
    figure(2);
    subplot(2, 5, i);
    histogram(sample, n);
    xlabel("Value of Xavg");
    ylabel("freq");
    title(['Sample Size: ', num2str(N)]);
end

figure(3);
plot(sample_sizes, M);
xlabel("sample sizes");
ylabel("MAD");
title("Mean Absolute Difference (MAD) vs Sample Size");
