%% Apartado 1
clear all, close all, clc

I = uint8(ones(256,256))*128; 
figure, 
subplot(2,1,1), imshow(I);
subplot(2,1,2), imhist(I),axis('auto');
%% Ruido en la imagen

I_speckle = imnoise(I,'speckle',0.02);
I_gaussian = imnoise(I,'gaussian',0,0.02); %Media y varianza
I_salt_pepper = imnoise(I,'salt & pepper',0.02);
New_I = [I_gaussian,I_speckle,I_salt_pepper]; %256 filas y columnas 256*3
figure, imshow(New_I);

figure
subplot(4,1,1), imshow(New_I);
subplot(4,1,2), imhist(I_gaussian),axis('auto');
subplot(4,1,3), imhist(I_speckle),axis('auto'); % Distribución uniforme
subplot(4,1,4), imhist(I_salt_pepper),axis('auto');


%% Filtrado

h = 1/25*ones(5,5); %Filtro de media
h_grande = (1/(35*35))*ones(35/35);

I_gauss_suav = imfilter(I_gaussian,h);
I_gauss_grande = imfilter(I_gaussian,h_grande);
I_speckle_suav = imfilter(I_speckle,h);
I_salt_pepper = imfilter(I_salt_pepper,h);

New_I_suav = [I_gauss_suav,I_speckle_suav,I_salt_pepper]; %256 filas y columnas 256*3

figure,
subplot(6,1,1), imshow(New_I_suav);
subplot(6,1,2), imhist(I_gauss_suav),axis('auto'); %Ruido gausiano
subplot(6,1,3), imshow(New_I_suav);
subplot(6,1,4), imhist(I_speckle_suav),axis('auto'); % Ruido granulado
subplot(6,1,5), imshow(New_I_suav);
subplot(6,1,6), imhist(I_salt_pepper),axis('auto'); % Ruido sal y pimienta

figure, % Ruido vs filtrada
subplot(3,1,1), imhist(I_gaussian),axis('auto'); % Estrechamos la delta de ruido (Si aumentamos la máscara la anchura de reduce)más grande el tamño de la máscara eliminamos más altas frecuencias
subplot(3,1,2), imhist(I_gauss_suav),axis('auto');
subplot(3,1,3), imhist(I_gauss_grande),axis('auto');


%% Para eliminar la mini camapana tenemos que hacer 

I_gauss_suav_padding = imfilter(I_gaussian,h,'symmetric','same'); % con esto eliminamos el falso contorno 

figure,
subplot(4,1,1), imshow(I_gauss_suav_padding);
subplot(4,1,2), imhist(I_gauss_suav_padding),axis('auto');
subplot(4,1,3), imshow(I_gauss_suav);
subplot(4,1,4), imhist(I_gauss_suav),axis('auto');

%% segunda parte de la práctica
clear all, close all, clc

coins = imread('coins.png');
figure, imshow(coins);

figure, mesh(double(coins)); % cuidado con el tipo de dato, necesita eldoubloe
%tenemos que fijarnos en los gradientes, la intensidad del gradiente
%podemos tener coeficientes negativos los filtros lineales permiten hacer
%restas y sumas, por lo tanto permiten calcular diferencias es decir el
%gradiente. Las diferencias pueden ser positivas o negativas, teniendo
%gradientes por encima del plano cero o debajo.
%Los gradietnes tienen qu ser de tipo double ya que uint8 solo admite
%números positivos.
H_prew = fspecial('prewitt') % Esto nos da la máscara en este caso filtro paso alto

I_Hprew = imfilter(coins,H_prew,'symmetric');
I_Hprew_double = imfilter(double(coins),H_prew,'symmetric');

figure, imshow(I_Hprew);
figure, mesh(abs(I_Hprew));

figure, mesh(I_Hprew_double);
figure, imshow(uint8(abs(I_Hprew_double)));

%% Haciendo la transpuesta del filtro
close all;
H_prew2 = H_prew'; %Cómo hace la transpuesta
I_Hprew2 = imfilter(coins,H_prew2, 'symmetric');
I_grad_Prewitt = uint8(0.5*(double(I_Hprew) + double(I_Hprew2)));
figure, imshow(I_grad_Prewitt);

I_Hprew = imfilter(double(coins),H_prew,'symmetric');
I_Hprew2 = imfilter(double(coins),H_prew2 ,'symmetric');
I_grad_Prewitt = uint8(0.5*(abs(I_Hprew) + abs(I_Hprew2)));
figure, imshow(I_grad_Prewitt)

%tenemos gradientes negativos ya qeu a la hora de hacer la aproximación de
%la derivada por ejemplo de un pulso al ir punto a punto en la subida del
%pulso tendremos un gradiente positivo,pero en la caida tendremos una
%gradiente negativo recuerda --> I(x+1)- I(x) /1

%% En este apartado vamos a usar un único filtro , en este caso el filtro isotrópico.
close all;

coins = imread('coins.png');
h = -ones(3,3);
h(2,2) = 8;
I_bordes_iso = imfilter(double(coins),h,'symmetric','same');
I_bordes_iso_abs = uint8(abs(I_bordes_iso));

I_bw = im2bw(I_bordes_iso_abs,100/255);

figure, imshow(I_bordes_iso_abs); %Sale un poco peor ya que estamos haciendo una aproximación
figure, imhist(I_bordes_iso_abs),axis('auto');

figure, imshow(I_bw); 
figure, imhist(I_bw),axis('auto');

%% Filtro de mediana

close all;

coins = imread('coins.png');
h = medfilt2()

%% otr
close all;

coins = imread('coins.png');
h = -ones(3,3);
h(2,2) = 8;
I_median = medfilt2(coins,[11 11],'symmetric');
I_bw = im2bw(I_median,100/255);
h = -ones(3,3);h(2,2) = 8;
I_BW_realce = imfilter(I_bw,h,'symmetric');
figure, imshow(I_BW_realce); 

I_bw_rgb(:,:,1) =255*I_BW_realce; %Matriz de ceros
I_bw_rgb(:,:,2) = zeros(size(I_BW_realce));
I_bw_rgb(:,:,3) = zeros(size(I_BW_realce));
I_bw_rgb = uint8(I_bw_rgb);

I_coins_rgb(:,:,1) = coins;
I_coins_rgb(:,:,2) = coins;
I_coins_rgb(:,:,3) = coins;

I_final = imadd(I_bw_rgb,I_coins_rgb);
%Paleta_color = [0,0,0;255,0,0]; %Esto no vale ya que luego a la hora de
%hacer  la suma de imágenes tendremos problemas.
%I_color = uint8(ind2rgb(I_BW_realce,Paleta_color));

%I_coins_color = ind2rgb(coins);
%I_final = imadd(I_coins_color,I_color);
%figure, imshow(I_color); 
figure, imshow(I_final); 





