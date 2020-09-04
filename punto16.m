ND = 1000;


for n=1:50
    Data=vander(1:n);
    C = cov(Data);
    CR = cov1para(Data);
    
    %Without reducing
    CN(n) = cond(Data);
    DN(n) = det(Data);
    
    %Reducing
    CNR(n) = cond(CR);
    DNR(n) = det(CR);
    
end

x_pseudo = [1 2 3 4 5 6 7 8 9 10 11 12]';
b_pseudo = vander(1:length(x_pseudo)) * x_pseudo;

x_res_pseudo = pinv(vander(1:length(x_pseudo))) * b_pseudo; % Inverse calculation
dif_pseudo = norm(x_pseudo-x_res_pseudo); % Calculate distance between theoretical and computed


vander_shrink = cov1para(vander(1:12),0.5);

x_shrink = [1 2 3 4 5 6 7 8 9 10 11 12]';
b_shrink = vander_shrink * x_shrink;

h_cond_shrink = cond(vander_shrink);
h_det_shrink = det(vander_shrink);

x_res_shrink = inv(vander_shrink) * b_shrink; % Inverse calculation
dif_shrink = norm(x_shrink-x_res_shrink); % Calculate distance between theoretical and computed


% Variable definition
x = [1 2 3 4 5 6 7 8 9 10 11 12]';
b = vander(1:length(x)) * x;

x_res = inv(length(x)) * b; % Inverse calculation
h_cond = cond(vander(1:length(x)));
h_det = det(vander(1:length(x)));
dif = norm(x-x_res); % Calculate distance between theoretical and computed

subplot(2,2,1);
plot(CN);
title("Condition Number");
ylabel("Condition");
subplot(2,2,2);
plot(CNR);
title("Conditon Number with shrinkage");
ylabel("Condition");
subplot(2,2,3);
plot(DN);
title("Determinant Number");
ylabel("Determinant");
subplot(2,2,4);
plot(DNR);
title("Determinant Number with shrinkage");
ylabel("Determinant");