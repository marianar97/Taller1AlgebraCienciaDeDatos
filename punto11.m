% Env´ıe al grupo 4 im´agenes de su rostro. Pase cada imagen a escala de grises. Para las cuatro normas
% matriciales discutidas en clase (1,2, ∞ y Frobenius). Calcule, con la m´etrica inducida por las normas,
% la distancia de cada persona a todas las personas. Defina un indicador de lejan´ıa del individuo j como
% el promedio de las distancias del individuo j a todos. Un concepto sencillo de imagen mediana ser´ıa
% aquel individuo cuyo indicador de lejan´ıa es el menor. Obtenga con las cuatro m´etricas qui´en de
% ustedes es la mediana, es decir, el m´as t´ıpico.

%% Image pre-processing

photos_path = "FotosGrupo/";
files = dir(photos_path);
files = files(3:end,:);

for i=1:length(files)
   img = imread(strcat(photos_path, '/', files(i).name));
   grayscale_img = rgb2gray(img);
   images{i} = imresize(grayscale_img, [512 512]);
   resized_img = imresize(grayscale_img, [1 512*512]); % Convert to row vector
%    imshow(resized_img) % Plot every image
%    pause(2)
   vectorized_images(i, :) = resized_img;
   
end


%% Determine the Indicator for every picture

n = size(vectorized_images);

for i=1:n(1)
    for j=1:n(1)
        [d_1(i,j), d_2(i,j), d_inf(i,j), d_frob(i,j)] = imageDistance(vectorized_images(i,:), vectorized_images(j,:));
    end
    I_1(i) = mean(d_1(i,:));
    I_2(i) = mean(d_2(i,:));
    I_inf(i) = mean(d_inf(i,:));
    I_frob(i) = mean(d_frob(i,:));
end

%% Determine the most common individual

median_1 = find(I_1 == min(I_1));
median_2 = find(I_2 == min(I_2));
median_inf = find(I_inf == min(I_inf));
median_frob = find(I_frob == min(I_frob));

subplot(2,2,1)
imshow(images{median_1})
xlabel("Distance d_1 - Picture " + median_1)

subplot(2,2,2)
imshow(images{median_2})
xlabel("Distance d_2 - Picture " + median_2)

subplot(2,2,3)
imshow(images{median_inf})
xlabel("Distance d_i_n_f - Picture " + median_inf)

subplot(2,2,4)
imshow(images{median_frob})
xlabel("Distance d_f_r_o_b - Picture " + median_frob)

%% General definition of metrics

function [d_1, d_2, d_inf, d_fro] = imageDistance(img_1, img_2)
    % type: [1, 2, Inf, 'fro']
    difference = double(img_1) - double(img_2);
    d_1 = norm(difference, 1);
    d_2 = norm(difference);
    d_inf = norm(difference, Inf);
    d_fro = norm(difference, 'fro');
end
