%% Cuesti�n1

%Tenemos dos tipos de receptores fotosensibles, los conos y los bastones.
%Los conos son receptrores espcalizados en el color y los bastones los
%cuales son son sensibles a la presencia o ausencia de luz, responsables de
%la visi�n acromatica y que seamos capaces de ver en condiciones de baja
%luminosidad como la oscuridad. (Hay m�s cantidad que conos.)

%% Cuesti�n 2
clear all, close all, clc

I2 = imread('Cuestion2.png');
figure, subplot(2,2,1), imshow(I2);
subplot(2,2,2), imhist(I2),axis auto;
%La imagen tiene poco contraste causado por un bajo rango din�mico, como se
%puede apreciar en el historgrama.
%Para mejorar el contraste podriamos aumentar el rango din�mico expandiendo
%el histograma mediante una transofrmaci�n punto a punto.
%En este caso yo utilizar�a una transformaci�n de tipo contrst stretching
%ya que permitir�a aumentar los niveles bajos y altos para ecualizar el
%historgrama.
% DUDA CUANDO ECUALIZAMOS LO QUE HACEMOS ES AUMENTAR EL RANGO DIN�MICO??!
I2_ecualizado = histeq(I2);
I2stret = imadjust(I2,stretchlim(I2),[]); 

figure, 
subplot(2,1,1), imshow(I2stret) ;
subplot(2,1,2), imhist(I2stret), axis auto ;% Supuesto contrast streaching

figure, 
subplot (2,1,1), imshow(I2_ecualizado);
subplot (2,1,2), imhist(I2_ecualizado), axis auto; % Ecualizaci�n autom�tica

%Segundo procedimiento con otro tipo de transformaci�n??

%% Cuesti�n 3

%Por niveles de gris si hacemos una segmentaci�nj yo diri� qeu tendr�amos 3
%ya que el historgrama muestra unicamente dos niveles de gris.


