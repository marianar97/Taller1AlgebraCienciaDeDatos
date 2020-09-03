function [distance_matrix] = get_distance(data, mean_matrix, distance_metric)
    %=======================================
    %           Calculating Euclidean
    %=======================================
    dist = data - mean_matrix;
    dist = dist.^distance_metric;
    dist = sum(dist, 2);
    distance_matrix = sqrt(dist);
end