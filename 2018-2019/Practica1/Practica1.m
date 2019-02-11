%% Apartado1 lectura de im�genes

clear all, close all, clc
[cara, MAP_cara] = imread('ims/cara.tif'); % Map es para cargtar la lut de la imgen en el caso de que tenga imagen.
[peppers,MAP_pimientos] = imread('peppers.png');
[coins,MAP_monedas] = imread ('coins.png');
size (cara);

%% Visualizar im�genes
figure, imshow(cara);
figure, imshow(peppers);
figure, imshow(coins);

imtool(cara);
imtool(peppers);
imtool(coins);

%% guardar imagen
imwrite(coins,'m2.tif');

%% conversi�n de tipos de im�genes binaria a rgb

Paleta_color = [255,255,0;255,0,0];

cara_color = ind2rgb(cara,Paleta_color);
figure, imshow(cara_color);
imtool(cara_color);

%% RGB --> escala de grises
Pimientos_grises = rgb2gray(peppers);
imtool(Pimientos_grises);

%% RGB --> Indexada

 [Pimientos_indexados,Map_Pimientos] = rgb2ind(peppers,5); %Necesitamos el mapa para visualizarlo
 [Pimientos_indexados255,Map_Pimientos255] = rgb2ind(peppers,255); %Necesitamos el mapa
% Recuerda el mapa es la lut (La tabla, pelta de colores)
imtool(Pimientos_indexados,Map_Pimientos);
imtool(Pimientos_indexados255,Map_Pimientos255);

%% 
Umbral_Normalizado = 140/255; % Esrto se hace zas� ya que im2bw solo admite valores de 0-1
Monedas_binaria = im2bw(coins,Umbral_Normalizado);
%[Monedas_binaria_Auto,Umbral_auto] = im2bw(coins);

imtool(Monedas_binaria);

%% Modificacion de resoluci�n espacial (diezmado)
[Lena, MAP_Lena] = imread('ims/Lena_512.tif'); % Map es para cargtar la lut de la imgen en el caso de que tenga imagen.
Monedas_redimensionada= imresize(coins,0.25);
Lena_redimensionada_256= imresize(Lena,0.5);
Lena_redimensionada_128= imresize(Lena,0.25);

figure, imshow(Lena_redimensionada_256);
figure, imshow(Lena_redimensionada_128);

%% Ahora queremos vovler al tam�o original (Interpolar)

Lena_redimensionada2original_nearest = imresize(Lena_redimensionada_128,4,'nearest'); % Pilla una columna y la replica 
% lo hace por bloques cercanos (se nota mucho9 en las alltas frecuencias espaciales)
Lena_redimensionada2original_bilinear = imresize(Lena_redimensionada_128,4,'bilinear'); % Aqu� no se hace una r�plixcas
%se hace una comb lineanl

figure, imshow(Lena_redimensionada2original_nearest);
figure, imshow(Lena_redimensionada2original_bilinear);

%% ahora Resoluci�n en cuantificaci�n
%Podemos hacer con una imagen indexada
close all
[Lena_16niveles,MAP_16] = gray2ind(Lena,16); 
[Lena_2niveles,MAP_2] = gray2ind(Lena,2); 
[Lena_8niveles,MAP_8] = gray2ind(Lena,8);

figure, imshow(Lena_16niveles,MAP_16);
figure, imshow(Lena_2niveles,MAP_2);
figure, imshow(Lena_8niveles,MAP_8);

%% Visualizaci�n del histograma
figure
subplot(4,1,1),imhist(Lena);
subplot(4,1,2),imhist(Lena_16niveles,MAP_16);
subplot(4,1,3),imhist(Lena_2niveles,MAP_2);
subplot(4,1,4),imhist(Lena_8niveles,MAP_8);

%%
close all

I = imread ('pout.tif');

figure, imshow(I);
figure, imhist(I), axis auto; % Axix hace un rescalado autoimatico
%%No est� ecualizada ni tiene un buen rango autom�tico

I_ecualizado = histeq(I);
figure, imshow(I);
subplot (2,1,1), imshow(I_ecualizado);
subplot (2,1,2), imhist(I_ecualizado), axis auto;
%Mejramos el contraste

%% Interpretaci�n del color
close all

peppers_r = peppers(:,:,1);%todas las filas,todas las columnas , de la priumera columna
imtool(peppers);
imtool(peppers_r);
%% Transformaci�n punto a punto, negativo o complementaria

%Negativo_peppers_r_a = -peppers_r + 255 % Matlab est� aproximando
%Matlab no permite representar imagenes de tipo double
Negativo_peppers_r_a = 255 -peppers_r % Esta es l�a manera correcta

figure, imshow(Negativo_peppers_r_a);
%% Nueva

NuevaI = peppers;
NuevaI(:,:,1) =Negativo_peppers_r_a;

figure, imshow(NuevaI);
%%
Nuevos_pimientos = uint8(zeros(size(peppers))); %Matriz de ceros
Nuevos_pimientos (:,:,1) = peppers_r;

figure, imshow(Nuevos_pimientos);


%% 

a = uint8(ones(size(peppers)))*100;

figure, imshow(a);
%% Multiplicar elemento a elemento .* 



