x = 0.0:0.01:50;
y1 = x .* log(x);
figure;
plot(x, y1, 'b', 'LineWidth', 1, 'DisplayName', 'x * ln(x)');
xlabel('x');
ylabel('y');
title('E[X^n] vs x');
grid on;
hold off;