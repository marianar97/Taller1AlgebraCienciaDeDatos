


function mahalanobis_d = mahal_function(X,sigma)
    mu = mean(X);
    f = size(X,1);
    mahalanobis_d = size(f,1);
    
    inv_cov = inv(sigma);
    
    for i=1:f
        mahalanobis_d(i) = (X(i,:) - mu) * inv_cov *( X(i,:) - mu).';
    end
end

