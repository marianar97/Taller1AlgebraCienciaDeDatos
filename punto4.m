ND=10000;
mu=zeros(1,2);
sigma=hilb(2);
Datos=mvnrnd(mu,sigma,ND);
[f c] = size(Datos);
media = mean(Datos);

for i=1:f
    if Datos(i,1)^2 + Datos(i,2)^2 == media(1)^2 + media(2)^2
        d(i) = sqrt((Datos(i,1) - media(1))^2 + (Datos(i,2) - media(2))^2);
    else
        d(i) = sqrt(Datos(i,1)^2 + Datos(i,2)^2) + sqrt(media(1)^2 + media(2)^2);
    end
end

p90 = prctile(d, 90);
I = find(d > p90);
plot(Datos(:,1), Datos(:,2), 'o');
hold on
plot(Datos(I,1), Datos(I,2), 'or');