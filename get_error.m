function [error] = get_error(data, mean_matrix, distance_metric)
    %=======================================
    %           Computing Error
    %=======================================
    error = 0;
    for j = 1: size(data, 1)
       c = data(j, end);
       dist = get_distance(data(j, 1:end-1), mean_matrix(c, 1:end), distance_metric);
       error = error + dist;
    end
end