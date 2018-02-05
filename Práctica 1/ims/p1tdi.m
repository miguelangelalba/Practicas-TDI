clear all;
close all;
peppers = imread('peppers.png');
coins = imread('coins.png');
cara = imread('cara.tif');
whos peppers;
whos coins;
whos cara;
[peppersind5,mapa5] = rgb2ind(peppers,5);
[peppersind255,mapa255] = rgb2ind(peppers,255);
peppersgray = rgb2gray(peppers);
%imtool(peppers);
%imtool(peppersind5,mapa5);
%imtool(peppersind255,mapa255);
%imtool(peppersgray);
%paletacara = [1,1,0;1,0,0];
autoumbral = graythresh(coins); 
imhist(coins);
I_coins_bw = im2bw(coins,autoumbral);
paletabn = autoumbral/255;
imtool(I_coins_bw,paletabn);
%display (cara);
%%
%Apartado 2 (Me faltan cosas) 
clear all;
close all;
Elena = imread('Lena_512.tif');
Elena128 = imresize(Elena,0.25);

%%
%Apartado3 Ecualización del histograma
clear all;
close all;
I_pout = imread('pout.tif');
imtool(I_pout);
imhist(I_pout);
I_eq = histeq(I_pout);
imtool(I_eq);
imhist(I_eq);

%%
%
clear all;
close all;
peppers = imread('peppers.png');
peppers_R = peppers(:,:,1);
peppers_G = peppers(:,:,2);
peppers_B = peppers(:,:,3);
imtool(peppers_R);
imtool(peppers_G);
imtool(peppers_B);
N_R = 255 - peppers_R;
imtool(N_R);
I2_TC = peppers;
I2_TC(:,:,1) = N_R;
imtool(I2_TC);

