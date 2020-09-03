ND = 1000;

for n=1:50
    Data=hilb(n);
    C = cov(Data);
    CR = cov1para(Data);
    
    %Without reducing
    CN(n) = cond(C);
    DN(n) = det(C);
    
    %Reducing
    CNR(n) = cond(CR);
    DNR(n) = det(CR);
    
end

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

%%Definitely shrinkage helped us to reduce the condition number and the
%%determinant nunber now is just close to zero not zero.
