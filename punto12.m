% Con las cuatro m´etricas, determine quien del grupo es el m´as parecido a usted y discuta qu´e m´etrica
% es la m´as conveniente para identificarlo. Ensaye introduciendo en la base un par de fotos suyas m´as.
% Construya una vecindad con centro en usted y un radio tal que la vecindad tenga 5 im´agenes. Muestre
% las im´agenes. Explique con buenos argumentos si su imagen es punto interior, punto frontera o punto
% de acumulaci´on del conjunto de im´agenes del grupo

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


%% Image neighborhood

% Sort image distances in ascending order (lower to higher distance)
for ind=1:n(1)
    [ord_1(ind,:), neighborhood_1(ind,:)] = sort(d_1(ind,:));
    [ord_2(ind,:), neighborhood_2(ind,:)] = sort(d_2(ind,:));
    [ord_inf(ind,:), neighborhood_inf(ind,:)] = sort(d_inf(ind,:));
    [ord_frob(ind,:), neighborhood_frob(ind,:)] = sort(d_frob(ind,:));
end


%% Plot 5 most related pictures to my own picture for each distance

my_picture = 17; % Index of my pic in the dataset

figure(1)
imshow(images{my_picture})
title("My picture - Index " + my_picture)

figure("Name", "Distance d_1")
for nb=1:5
    subplot(5,1,nb)
    title("More similar to image " + my_picture)
    imshow(images{neighborhood_1(my_picture,nb+1)})
    xlabel("Picture " + neighborhood_1(my_picture,nb+1) + " - Distance (to " + my_picture + "): " + ord_1(my_picture,nb+1))
end

figure("Name", "Distance d_2")
for nb=1:5
    subplot(5,1,nb)
    title("More similar to image " + my_picture)
    imshow(images{neighborhood_2(my_picture,nb+1)})
    xlabel("Picture " + neighborhood_2(my_picture,nb+1) + " - Distance (to " + my_picture + "): " + ord_2(my_picture,nb+1))
end

figure("Name", "Distance d_inf")
for nb=1:5
    subplot(5,1,nb)
    title("More similar to image " + my_picture)
    imshow(images{neighborhood_inf(my_picture,nb+1)})
    xlabel("Picture " + neighborhood_inf(my_picture,nb+1) + " - Distance (to " + my_picture + "): " + ord_inf(my_picture,nb+1))
end

figure("Name", "Distance d_frob")
for nb=1:5
    subplot(5,1,nb)
    title("More similar to image " + my_picture)
    imshow(images{neighborhood_frob(my_picture,nb+1)})
    xlabel("Picture " + neighborhood_frob(my_picture,nb+1) + " - Distance (to " + my_picture + "): " + ord_frob(my_picture,nb+1))
end


%% Conclusions

% Al tomar mi imagen como centro del conjunto, las imágenes más cercanas
% en la vecindad corresponden a mis otras imágenes.

% Las métricas d2 (euclidea) y Frobenius, para el caso de las imágenes
% representadas como vectores, arrojan el mismo resultado. No obstante, la
% métrica Frobenius puede diferir al tratar las imágenes como matrices.

% Mi imagen no corresponde a un punto interior pues, al ser un conjunto
% discreto con imágenes finitas, toda bola con centro en una imagen y radio
% mayor que cero podrá no encerrar imágenes.

% Mi imagen sí corresponde a un punto frontera pues, al ser un conjunto
% discreto y finito, al definir una bola con centro en mi imagen con radio
% mayor que cero, esta contendrá mi imagen (que es parte del conjunto),
% posiblemente otras imágenes del conjunto, pero a la vez contendrá el
% espacio entre imágenes (que no pertenece al conjunto).


%% General definition of metrics

function [d_1, d_2, d_inf, d_fro] = imageDistance(img_1, img_2)

    difference = double(img_1) - double(img_2);
    d_1 = norm(difference, 1);
    d_2 = norm(difference);
    d_inf = norm(difference, Inf);
    d_fro = norm(difference, 'fro');
end

