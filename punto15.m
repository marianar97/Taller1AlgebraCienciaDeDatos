%  Considere x = [1 2 3 4 5 6 7 8 9 10 11 12]. Defina b = H12x. Resuelva el sistema con la forma
% x = (H−1)b. Qu´e conclusi´on obtiene. Busque alternativas para resolver el problema observado

%% Original setup

% Variable definition
x = [1 2 3 4 5 6 7 8 9 10 11 12]';
b = hilb(length(x)) * x;

x_res = invhilb(length(x)) * b; % Inverse calculation
h_cond = cond(hilb(length(x)));
h_det = det(hilb(length(x)));
dif = norm(x-x_res); % Calculate distance between theoretical and computed

%% Observaciones:

% A pesar de que el cálculo de x_res es una reversión directa del valor de
% x, y de que teóricamente x debería ser idéntico a x_res, ambos vectores
% resultan distintos (aquí su diferencia se cuantifica como la distancia
% bajo la norma 2), principalmente en los valores por encima de n=4.

% Esto puede deberse a que el cálculo de la inversa de una matriz, en
% términos computacionales, presenta el inconveniente de que la precisión
% numérica hace que algunos cálculos sean inexactos y, al aumentar el
% número de operaciones, estas imprecisiones se van replicando a través de
% ellos. Esto es aún más notorio en las matrices cuyo número de condición
% es muy alto, o recíprocamente, su determinante es muy cercano a 0, pues
% estas condiciones restringen su invertibilidad.


%% Option 1: pseudo-inverse matrix

x_pseudo = [1 2 3 4 5 6 7 8 9 10 11 12]';
b_diag = hilb(length(x_pseudo)) * x_pseudo;

x_res_diag = pinv(hilb(length(x_pseudo))) * b_diag; % Inverse calculation
dif_pseudo = norm(x_pseudo-x_res_diag); % Calculate distance between theoretical and computed

% En algunos casos, el cómputo de la inversa en matrices poco condicionadas
% funciona mejor al usar la operación de pseudo-inversa.
% Computacionalmente, esta utiliza la descomposición en valores singulares
% para retornar, de forma más estable numéricamente, la solución de mínima
% norma usando el método de mínimos cuadrados (muy útil para sistemas de
% ecuaciones lineales).

% Es evidente que, al aplicar la pseudo-inversa a una matriz de rango
% completo, aunque mal condicionada, el resultado de la inversión tiene una
% mejor aproximación:
% 
% 0.0358 (dif_pseudo) < 2.8367 (dif)


%% Option 2: matrix shrinkage L-W

hilb_shrink = cov1para(hilb(12),0.5);

x_shrink = [1 2 3 4 5 6 7 8 9 10 11 12]';
b_shrink = hilb_shrink * x_shrink;

h_cond_shrink = cond(hilb_shrink);
h_det_shrink = det(hilb_shrink);

x_res_shrink = inv(hilb_shrink) * b_shrink; % Inverse calculation
dif_shrink = norm(x_shrink-x_res_shrink); % Calculate distance between theoretical and computed

% Al aplicar shrinkage a la matriz de Hilbert, es posible intervenir sus
% número condición y determinante resultantes al realizar modificaciones a
% la matriz, generando una equivalente con mejor aptitud para realizar la
% inversa computacional. Al aplicar un factor de encogimiento de 0.5, su
% número condición pasa del orden de 1e16 a 1e1, y su distancia respecto al
% vector original se reduce al orden de 1e-14, arrojando un vector resultado casi
% idéntico al original.

% 1.75e-14 (dif_shrink) < 2.8367 (dif)


%% Option 3: Increase diagonal

lambda = 10;
x_diag = [1 2 3 4 5 6 7 8 9 10 11 12]';
hilb_diag = hilb(length(x_diag)) + lambda*eye(length(x_diag));
b_diag = hilb_diag * x_diag;

h_cond_diag = cond(hilb_diag);
h_det_diag = det(hilb_diag);

x_res_diag = inv(hilb_diag) * b_diag; % Inverse calculation
dif_diag = norm(x_diag-x_res_diag); % Calculate distance between theoretical and computed

% Al incrementar considerablemente la diagonal de la matriz, se definen
% mejor las posiciones pivotes en esta y, por ende, su invertibilidad
% mejora. Es decir, entre mayor sea el aumento en la diagonal principal,
% mayor es la reducción en el número condición y el incremento en el
% determinante.
% 
% Para este caso, es la solución que mejor funciona, con un determinante
% del orden de 1e12 y número condición igual a 1.18.

% 3.39e-15 (dif_diag) < 2.8367 (dif)


%% Conclusiones:

% Respecto al cálculo de inversa directa ante una matriz mal condicionada,
% las opciones antes mencionadas pseudo-inversa, shrinkage de L-W, e
% incremento de la diagonal principal mejoran cada vez más el número
% condición de la matriz, respectivamente.
