%  Sea Hn(i, j) = 1
% i+j−1
% , llamada la matriz de Hilbert. Realice una gr´afica de n en el eje x con el n´umero
% condici´on en el eje y. Qu´e tipo de comportamiento observa. Haga lo mismo para su determinante.
% Realice lo mismo utilizando el shrinkage de Ledoit and Wolf pero cambiando en la linea 18 de
% cov1para.m sample = (1/t). ∗ (x
% ′ ∗ x); por sample = Hn. Compare los resultados. Haga un an´alsis
% gr´afico y de visualizaci´on donde se observe si al final el shrinkage mejora el n´umero condici´on.

for n=1:500
    
    h = hilb(n);
    h_shrink = cov1para(hilb(n),0.5);
    
    h_cond(n) = cond(h);
    h_det(n) = det(h);
    
    h_shrink_cond(n) = cond(h_shrink);
    h_shrink_det(n) = det(h_shrink);
    
end

subplot(2,2,1)
plot(h_cond, 'r')
title("Hilbert")
xlabel("n")
ylabel("Condition number")

subplot(2,2,2)
plot(h_shrink_cond, 'g')
title("Shrinked Hilbert")
xlabel("n")
ylabel("Condition number")

subplot(2,2,3)
plot(h_det, 'k')
title("Hilbert")
xlabel("n")
ylabel("Determinant")

subplot(2,2,4)
plot(h_shrink_det, 'g')
title("Determinant - Shrinked Hilbert")
xlabel("n")
ylabel("Determinant")


% Al aplicar shrinkage a la matriz de Hilbert, es posible intervenir sus
% número condición y determinante resultantes al realizar modificaciones a
% la matriz, generando una equivalente con mejor aptitud para realizar la
% inversa computacional. Al aplicar un factor de encogimiento de 0.5, su
% número condición pasa del orden de 1e22 a 1e2, lo cual representa una
% mejora sustancial.
