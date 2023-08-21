clc, clearvars

n=100000;
A = randi([0, 1000] , 1 , n);
A;
Mean = mean(A)
Median = median(A) 
st_dev = std(A)


new_num= -200000000;

Mean_new = Update( Mean , new_num , n )
Median_new= UpdateMedian( Median , new_num , A , n)
Std_new = UpdateStd(Mean , st_dev , Mean_new , new_num , n)


function newMean = Update (OldMean , NewDataValue , n)
    newMean= (OldMean * n  + NewDataValue)/(n+1);
end


function newMedian = UpdateMedian (oldMedian, NewDataValue, A, n)
    A(1 , n+1) = NewDataValue;
    newMedian= median(A);
end


function newStd = UpdateStd (OldMean, OldStd, NewMean, NewDataValue, n)
    sum_sq = (n-1)*(OldStd^2)+ n*(OldMean^2);
    sum_sq_new =sum_sq + NewDataValue^2;
    newStd = sqrt((sum_sq_new - (n+1)*(NewMean^2))/n);
end

