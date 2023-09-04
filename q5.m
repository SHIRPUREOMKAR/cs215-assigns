values = [1, 2, 3, 4, 5];
probabilities = [0.05, 0.4, 0.15, 0.3, 0.1];
sample_sizes = [5, 10, 20, 50, 100, 200, 500, 1000, 5000, 10000];
num_bins = 50;
MAD = [];

for i = 1:1:10
    N = sample_sizes(i);
    arr = [];
    for j = 1:1:3000
        % Generate random samples based on probabilities
        rand_values = rand(1, N);
        cum_prob = cumsum(probabilities);
        rand_value = zeros(size(rand_values));
        for k = 1:N
            rand_value(k) = find(rand_values(k) <= cum_prob, 1);
        end
        
        m = mean(rand_value);
        arr(end+1, 1) = m;
    end
    mu = mean(arr);
    sigma = std(arr);
    [f, x] = ecdf(arr);
    gaus = normcdf(x, mu, sigma);
    diff = abs(f - gaus);
    MAD(end+1, 1) = max(diff);
    
    figure(1);
    subplot(2, 5, i);
    plot(x, f);
    hold on
    plot(x, gaus);
    hold off
    
    figure(2);
    subplot(2, 5, i);
    histogram(arr, num_bins);
    xlabel("value of Xavg");
    ylabel("frequency");
end

figure(3);
plot(sample_sizes, MAD);
xlabel("sample sizes");
ylabel("MAD");
