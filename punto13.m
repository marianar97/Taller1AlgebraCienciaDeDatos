filename = 'portfolio100.txt';
delimiterIn = ' ';
headerlinesIn = 1;
Data = importdata(filename,delimiterIn);
Data = Data(:,2:end);
C = cov(Data);
[f c] = size(Data);
[a b] = size(C);
con = cond(C);
CLW = cov1para(Data);
NCLW = cond(Data);
err = [];

for n=1:1000
    x = Data + (eye(f, c) * n);
    cov_n = cov(x);
    err(n) = cond(cov_n);
end

disp(max(err));

plot(err);
title(['Condition number: ', num2str(con),' Condition number reduced: ', num2str(err(end))]);
xlabel("Iteration");
ylabel("Condition number");