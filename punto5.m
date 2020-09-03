

%Initialising Data
%The variable k is the number of clusters, the variable p_upper_limit is
%the maximum p where p is metric of distance
iterations = 20;
k = 3;
total_errors = [];
p_upper_limit = 10;
for distance_metric=0:p_upper_limit
errors = [];
count = 1;
fprintf('P = %d:\n', distance_metric);
ND = 1000;
mu = zeros(1,10);
sigma = hilb(10);
data = mvnrnd(mu,sigma,ND);
rows = size(data, 1);
cols = size(data, 2);
data = data(1:rows, 1:cols-1);
clusters = randi([1 k], rows, 1);
clustered_data = [data clusters];
mean_matrix = zeros(k, cols-1);
    

%Calculating Mean

for i = 1:k
    index = clustered_data(:, end) == i;
    indexed_data = clustered_data(index, 1:end-1);
    mean_matrix(i, :) = mean(indexed_data);
       
end
    
%Computing Error

error = get_error(clustered_data, mean_matrix, distance_metric);
fprintf('After initialization: error = %.4f \n', error);
    
%Starting Iterations

for p = 1:iterations
    for q = 1:rows
        %Deciding which Cluster data belongs
        dist = get_distance(data(q, :), mean_matrix, distance_metric);
        [minimum_row, minimum_col] = min(dist);
        clusters(q) = minimum_col;
    end
    
    clustered_data = [data, clusters];
       
    %Calculating Mean
    
    for i = 1:k
        index = clustered_data(:, end) == i;
        indexed_data = clustered_data(index, 1:end-1);
        mean_matrix(i, :) = mean(indexed_data);
    end
    
    %Computing Error
    
    prev_error = error;
    error = get_error(clustered_data, mean_matrix, distance_metric);
    fprintf('After iteration %d: error = %.4f \n', p, error);
    errors(p) = error;
    
    if error  == prev_error
        break;
    end
    
    
    
end
    %x = 1:p;
    %plot(x, errors);
    %str = "Sample with p = " + distance_metric;
    %title(str);
    %pause(2);
    total_errors(distance_metric+1) = error;
end

bar(0:p_upper_limit,total_errors);
title("Errors comparation");
xlabel("P Value");
ylabel("Error");