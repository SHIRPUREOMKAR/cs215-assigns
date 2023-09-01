clc, clearvars

% declaring the parameters
step = 0.02;
min_lim = -3;
max_lim = 3;
total_pts = (max_lim - min_lim) / step;
f = 0.6;
y_median_error = 0;
y_mean_error = 0;
y_fquartile_error = 0;

% calculating the initial x, y
x = linspace(min_lim, max_lim, total_pts);
y = 6.5 * sin(2.1 * x + pi/3);
y_den = sum(y.^2);


% corrupting values of y into z
vals = randperm(total_pts, round(f * total_pts));
z = y;
for i = 1 : length(vals)
    z(vals(i)) = 100 + rand() * 20;
end

% calculating the y_median, y_mean, and y_f_quartile
y_median = zeros(1, total_pts);
y_mean = zeros(1, total_pts);
y_fquartile = zeros(1, total_pts);

for i = 1 : total_pts
    N = max(1, i - 8) : min(i + 8, total_pts);
    y_median(i) = median(z(N));
    y_median_error = y_median_error + (y_median(i)-y(i))^2;
    y_mean(i) = mean(z(N));
    y_mean_error = y_mean_error + (y_mean(i)-y(i))^2;
    y_fquartile(i) = prctile(z(N), 25);
    y_fquartile_error = y_fquartile_error + (y_fquartile(i)-y(i))^2;
end

% calculating error
y_median_error = y_median_error / y_den;
y_mean_error = y_mean_error / y_den; 
y_fquartile_error = y_fquartile_error / y_den;
disp(['The RMS error of moving median filtering is ', num2str(y_median_error)]);
disp(['The RMS error of moving mean filtering is ', num2str(y_mean_error)]);
disp(['The RMS error of moving quartile filtering is ', num2str(y_fquartile_error)]);

% plotting stuff
plot(x, z, 'Color', 'yellow');
hold on;
plot(x, y_median, 'Color', 'blue');
hold on;
plot(x, y_mean, 'Color', 'green');
hold on;
plot(x, y_fquartile, 'Color', 'black');
hold on;
plot(x, y, 'Color', 'red');
hold off;

xlabel('x');
ylabel('y');
title('Filtering corrupted data using diff methods');
legend('z', 'y-median', 'y-mean', 'y-fquartile', 'y');
