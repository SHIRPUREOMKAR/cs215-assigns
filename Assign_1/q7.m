clc, clearvars

n=100000;
A = randi([0, 1000] , 1 , n);
Mean = mean(A);
Median = median(A); 
st_dev = std(A);


new_num= rand()*5000^2;

disp(["The new number added is" , new_num])
Mean_new = UpdateMean( Mean , new_num , n );
Median_new= UpdateMedian( Median , new_num , A , n);
Std_new = UpdateStd(Mean , st_dev , Mean_new , new_num , n);
disp(['The old mean of the data is : ', num2str(Mean)]);
disp(['The new mean of the data is : ', num2str(Mean_new)]);
disp(['The old median of the data is : ', num2str(Median)]);
disp(['The new median of the data is : ', num2str(Median_new)]);
disp(['The old Standard deviation of the data is : ', num2str(st_dev)]);
disp(['The new Standard devaition of the data is : ', num2str(Std_new)]);


function newMean = UpdateMean (OldMean , NewDataValue , n)
    newMean= (OldMean * n  + NewDataValue)/(n+1);
end


function newMedian = UpdateMedian(oldMedian, NewDataValue, A, n)
    A = [A, NewDataValue];

    %sorting because stated that A is to be assumed to be sorted for
    %calculation of median
    A = sort(A);
    
    n = n + 1;
    if mod(n, 2) == 1
        newMedian = A((n + 1) / 2);
    else
        newMedian = (A(n / 2) + A(n / 2 + 1)) / 2;
    end
end


function newStd = UpdateStd (OldMean, OldStd, NewMean, NewDataValue, n)
    sum_sq = (n-1)*(OldStd^2)+ n*(OldMean^2);
    sum_sq_new =sum_sq + NewDataValue^2;
    newStd = sqrt((sum_sq_new - (n+1)*(NewMean^2))/n);
end



