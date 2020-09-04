
clear all
% data import 
importedData = importdata('portfolio100.txt');
D = importedData(:,2:end);
months = importedData(:,1);

%get covariance with different techniques
cov_habital = cov(D);
[cov_wolf,shrinkage]=cov1para(D,0);
[idx,dm,mm,cov_cur,wval0,ndir] = kur_main(D);

x = linspace(0,10,50);

%call mahal function with different cov matrix
d_habital = mahal_function(D,cov_habital);
d_wolf = mahal_function(D,cov_wolf);
d_cur = mahal_function(D,cov_cur);

%find 90 percentile
habital_90 = prctile(d_habital,90);
wolf_90 = prctile(d_wolf,90);
cur_90 = prctile(d_cur,90);
%habital_90 = chi2inv(.95,668)


%find index of outliers
I_habital = find(d_habital> habital_90);
I_wolf = find(d_wolf>wolf_90);
I_cur = find(d_cur>cur_90);

[cf, cc] = size(I_cur);

for i=1:cc
    pos = (I_cur(1,i));
    m = months(pos, 1);
    out_cur(i) = m;
    
    pos = (I_wolf(1,i));
    m = months(pos,1);
    out_wolf(i) = m;
    
    pos = (I_habital(1,i));
    m = months(pos,1);
    out_habital(i) = m;
    
end

out_habital = out_habital';
out_wolf = out_wolf';
out_cur = out_cur';

outliers_cur = find(idx == 1);
[nf, nc] = size(outliers_cur);

for i=1:nf
    disp(i)
    pos = (outliers_cur(i,1))

    m = months(pos,1);
    out_idx(i) = m;
end

out_idx = out_idx'


% plot(D,'o')
% hold on
% plot(D(I_habital,:),'or')
% 
% plot(d_wolf,'o')
% hold on
% plot(d_wolf(1,I_wolf),'or')

subplot(4,1,1)
plot3(D(:,10), D(:,91), D(:,92),'ob')
hold on
plot3(D(I_habital,10), D(I_habital,91), D(I_habital,92), 'or');
title("Outliers usando Mahalanobis covarianza habital");

subplot(4,1,2)
plot3(D(:,10), D(:,91), D(:,92),'ob')
hold on
plot3(D(I_wolf,10), D(I_wolf,91), D(I_wolf,92), 'or');
title("Outliers usando Mahalanobis cov de Lenoit and Wolf");

subplot(4,1,3)
plot3(D(:,10), D(:,91), D(:,92),'ob')
hold on
plot3(D(I_cur,10), D(I_cur,91), D(I_cur,92), 'or');
title("Outliers usando distancia Mahalanobis cov mínima curtosis");

subplot(4,1,3)
plot3(D(:,10), D(:,91), D(:,92),'ob')
hold on
plot3(D(I_cur,10), D(I_cur,91), D(I_cur,92), 'or');
title("Outliers usando distancia Mahalanobis cov mínima curtosis");

subplot(4,1,4)
plot3(D(:,10), D(:,91), D(:,92),'ob')
hold on
plot3(D(outliers_cur,10), D(outliers_cur,91), D(outliers_cur,92), 'or');
title("Outliers usando distancia salida mínima curtosis idx");


% % 
% % hold on
% % 
% % plot(D(I,1), D(I,2), 'or')
% 
% 
% 
% d2 = mahal(D2,D2);
% p290 = prctile(d2,90);
% condd2 = cond(d2);
% 
% 
% I2 = find(d2>p290);
% plot(D(:,1), D(:,2),'o')
% 
% hold on
% 
% plot(D(I2,1), D(I2,2), 'or')


