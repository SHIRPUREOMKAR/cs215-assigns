clc, clearvars

im1 = double(imread("C:\Users\omkar\Desktop\Acads\CS215\cs215-assigns\Assign_2\T1.jpg"));
im2 = double(imread("C:\Users\omkar\Desktop\Acads\CS215\cs215-assigns\Assign_2\T2.jpg"));

%im2 = 255 - im1;
txv = -10:10;
correlation_coefficient = zeros(size(txv));
quadratic_mutual_information = zeros(size(txv));

for idx = 1:length(txv)
    tx = txv(idx);
    shifted_im2 = zeros(size(im2));
    if tx >= 0
        shifted_im2(:, (tx+1):end) = im2(:, 1:(end-tx));
    else
        shifted_im2(:, 1:(end+tx)) = im2(:, (1-tx):end);
    end

    hist = computeJointHistogram(im1, shifted_im2, 10);
    mhist1 = sum(hist, 2);
    mhist2 = sum(hist, 1);

    QMI = 0;
    for i1 = 1:size(hist, 1)
        for i2 = 1:size(hist, 2)
            QMI = QMI + (hist(i1, i2) - mhist1(i1) * mhist2(i2))^2;
        end
    end
    quadratic_mutual_information(idx) = QMI;
    mean_im1 = mean(im1(:));
    mean_shifted_im2 = mean(shifted_im2(:));
    correlation_coefficient(idx) = sum(sum((im1 - mean_im1) .* (shifted_im2 - mean_shifted_im2))) / ...
        sqrt(sum(sum((im1 - mean_im1).^2)) * sum(sum((shifted_im2 - mean_shifted_im2).^2)));
    
    
end

figure;
subplot(2, 1, 1);
plot(txv, correlation_coefficient);
title('Correlation Coefficient vs. tx');
xlabel('tx');
ylabel('Correlation Coefficient');

subplot(2, 1, 2);
plot(txv, quadratic_mutual_information);
title('Quadratic Mutual Information (QMI) vs. tx');
xlabel('tx');
ylabel('QMI');

function JH = computeJointHistogram(im1, im2, binWidth)
    numBins = floor(256 / binWidth);
    JH = zeros(numBins);
    im1 = im1 / 255;
    im2 = im2 / 255;
    for i = 1:size(im1, 1)
        for j = 1:size(im1, 2)
            bin1 = min(max(floor(im1(i, j) * numBins) + 1, 1), numBins);
            bin2 = min(max(floor(im2(i, j) * numBins) + 1, 1), numBins);
            JH(bin1, bin2) = JH(bin1, bin2) + 1;
        end
    end
    JH = JH / sum(JH(:));
end