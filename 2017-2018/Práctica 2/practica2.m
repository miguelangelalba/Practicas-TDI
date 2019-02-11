%%
%Apartado 1 
clear all;
close all;
I = 128*ones(256,256);
I = uint8(I);
subplot(2,1,1),imshow(I);
subplot(2,1,2),imhist(I);
axis('auto');
M=0;
V=0.02;
J = imnoise(I,'gaussian',M,V);
S_P = imnoise(I,'salt & pepper',V);
S = imnoise(I,'speckle',V);

I_gspeesyp = [J,S_P,S];
figure,imshow(I_gspeesyp);
title('Composición del ruido Gauss(iqda),Granular(med),Sal y Pimienta(der)');

figure
subplot(2,1,1),imshow(J);
subplot(2,1,2),imhist(J);
figure
subplot(2,1,1),imshow(S_P);
subplot(2,1,2),imhist(S_P);
figure
subplot(2,1,1),imshow(S);
subplot(2,1,2),imhist(S);

h = (1/25)*ones(5,5);
h_grande = (1/(35*35))*ones(35,35);
I_gauss_suav = imfilter(J,h);

figure,subplot(2,1,1),imshow(I_gauss_suav),title('Filtro Igauss');
subplot(2,1,2),imhist(I_gauss_suav),title('Filtro Igauss');

I_gauss_suav_same = imfilter(J,h,'symmetric','same');
figure,subplot(2,1,1),imshow(I_gauss_suav_same),title('Filtro Igauss Same');
subplot(2,1,2),imhist(I_gauss_suav_same),title('Filtro Igauss Same');

I_gauss_suav_same = imfilter(J,h_grande,'symmetric','same');
figure,subplot(2,1,1),imshow(I_gauss_suav_same),title('Filtro Igauss Same Grande');
subplot(2,1,2),imhist(I_gauss_suav_same),title('Filtro Igauss Same Grande');

%%
%Para el ruido speckle
clear all;
close all;
I = 128*ones(256,256);
I = uint8(I);
subplot(2,1,1),imshow(I);
subplot(2,1,2),imhist(I);
axis('auto');
M=0;
V=0.02;
J = imnoise(I,'gaussian',M,V);
S_P = imnoise(I,'salt & pepper',V);
S = imnoise(I,'speckle',V);

I_gspeesyp = [J,S_P,S];
figure,imshow(I_gspeesyp);
title('Composición del ruido Gauss(iqda),Granular(med),Sal y Pimienta(der)');

figure
subplot(2,1,1),imshow(S);
subplot(2,1,2),imhist(S);

h = (1/25)*ones(5,5);
h_grande = (1/(35*35))*ones(35,35);
I_speckle_suav = imfilter(S,h);

figure,subplot(2,1,1),imshow(I_speckle_suav),title('Filtro Igauss');
subplot(2,1,2),imhist(I_speckle_suav),title('Filtro Igauss');

I_speckle_suav_same = imfilter(S,h,'symmetric','same');
figure,subplot(2,1,1),imshow(I_speckle_suav_same),title('Filtro Igauss Same');
subplot(2,1,2),imhist(I_speckle_suav_same),title('Filtro Igauss Same');

I_speckle_suav_same = imfilter(S,h_grande,'symmetric','same');
figure,subplot(2,1,1),imshow(I_speckle_suav_same),title('Filtro Igauss Same Grande');
subplot(2,1,2),imhist(I_speckle_suav_same),title('Filtro Igauss Same Grande');

%%
%Filtro no lineal

clear all;
close all;
I = 128*ones(256,256);
I = uint8(I);
subplot(2,1,1),imshow(I);
subplot(2,1,2),imhist(I);
axis('auto');
M=0;
V=0.02;
J = imnoise(I,'gaussian',M,V);
S_P = imnoise(I,'salt & pepper',V);
S = imnoise(I,'speckle',V);

I_gspeesyp = [J,S_P,S];
figure,imshow(I_gspeesyp);
title('Composición del ruido Gauss(iqda),Granular(med),Sal y Pimienta(der)');

figure
subplot(2,1,1),imshow(S_P);
subplot(2,1,2),imhist(S_P);

I_median_S_P = medfilt2(S_P,[5 5],'symmetric');

figure,subplot(2,1,1),imshow(I_median_S_P),title('Filtro Sal y pimienta');
subplot(2,1,2),imhist(I_median_S_P),title('Filtro Sal y Pimienta');

%%
%Imagen de monedas filtro de realce de contornos
clear all;
close all;
coins = imread('coins.png');
coins = double(coins);
h = fspecial('prewitt');
h_t = h';

coins_horizontal = abs(imfilter(coins,h));
coins_vertical = abs(imfilter(coins,h_t));

sumacoins = imadd(coins_horizontal,coins_vertical);
sumacoins = uint8(sumacoins);
figure
imshow(sumacoins);
figure
imhist(sumacoins);
autoumbral = graythresh(sumacoins);
umbral = 50/255;
coins_b_w = im2bw(sumacoins,autoumbral);

figure
imshow(coins_b_w);

coins_mediana =  medfilt2(coins,[5 5],'symmetric');


coins_horizontal = abs(imfilter(coins_mediana,h));
coins_vertical = abs(imfilter(coins_mediana,h_t));

sumacoins_mediana = imadd(coins_horizontal,coins_vertical);
sumacoins_mediana = uint8(sumacoins_mediana);
figure
imshow(sumacoins_mediana);
figure
imhist(sumacoins_mediana);
autoumbral_mediana = graythresh(sumacoins_mediana);
umbral = 50/255;
coins_b_w_mediana = im2bw(sumacoins_mediana,autoumbral_mediana);
figure
imshow(coins_b_w_mediana);

%%
%Filtro Isotrópico
clear all;
close all;
coins = imread('coins.png');
coins = double(coins);

I_median = medfilt2(coins,[11 11],'symmetric');
I_BW = im2bw(I_median,100/255);
h = -ones(3,3);
h(2,2) = 8;
I_BW_realce = imfilter(I_BW,h,'symmetric');
I_BW_realce = uint8(I_BW_realce);
figure
imshow(I_BW_realce);

