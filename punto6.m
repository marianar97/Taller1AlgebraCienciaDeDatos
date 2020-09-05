ND = 1000;
for n=1:10
    %ill-conditioned matrix
    %D = hilb(n);
    mu = zeros(1,n);
    sigma = hilb(n);
    D = mvnrnd(mu,sigma,ND);
    
    %cov habital
    cov_habital = cov(D);
    det_habital(n) = det(cov_habital);
    cond_habital(n) = cond(cov_habital);
    
    %cov wolf
    [cov_wolf,s] = cov1para(D);
    det_wolf(n) = det(cov_wolf);
    cond_wolf(n)= cond(cov_wolf);
    
    %cov kurt
    [idx,dm,mm,cov_cur,wval0,ndir] = kur_main(D);
    det_cur(n) = det(cov_cur);
    cond_cur(n) = cond(cov_cur);
    

end

%plot habital method
subplot(3,1,1)
plot(cond_habital,'b')
title("Condicion Habital")

% subplot(3,2,2)
% plot(det_habital,'b')
% title("Det Habital")

%plot wolf method
subplot(3,1,2)
plot(cond_wolf, 'g')
title("Condicion Wolf")

% subplot(3,2,4)
% plot(det_wolf, 'g')
% title("Det Wolf")


%plot kurt
subplot(3,1,3)
plot(cond_cur, 'r')
title("Condition Kurt")

% subplot(3,2,6)
% plot(det_cur, 'r')  
% title("Det Kurt")


I_curtos = find(idx >0);
[fi, ci] = size(I_curtos);

% for i=1:10
%   outliers_d(i) = D(i,:);
% end