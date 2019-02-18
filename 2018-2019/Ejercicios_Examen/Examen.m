% Examen 5 Adbril 2018
%Cuesti�n 1

clear all, close all, clc
I = imread('Examen1.PNG');
I_bw = double(im2bw(I));
%I_bw = double(rgb2gray(I));

figure, imshow(I_bw);
hx =[-1,0,1;-2,0,2;-1,0,1];

Modulo_I = abs(imfilter(I_bw,hx,'symmetric'));

figure,imshow(Modulo_I),axis auto;
figure,mesh(Modulo_I);
%Me da como resultado una imagen binaria.
%deber�a de tener un degradado? no entiendo muy bien eso hago los c�lculos
%a mano, y sale lo de 4,3,1 pero claro estamos en una imagen binaria
%entonces, como se representa eso???

%% Cuesnti�n 2
%Tenemos una traslaci�n y un cambio de escala. La dtraslaci�n no afecta a
%m�dulo de la DFT pero el cambio de escala si que afecta, en este caso al
%tener una escala m�s peque�a predominar�n las componentes en alta
%frecuencia.
%Energ�a mas dispersa por eso se expande en la trnasformaci�n logar�tmica
clear all, close all, clc


I2a = imread('Examen2a.PNG');
I2c = imread('Examen2c.PNG');

I2a_bw = im2bw(I2a);
I2c_bw = im2bw(I2c);
am = size(I2a_bw,1);
an = size(I2a_bw,2);

cm = size(I2c_bw,1);
cn = size(I2c_bw,2);


 FFT_I2a_bw = fftshift(fft2(double(I2a_bw),am,an));
 FFT_I2c_bw = fftshift(fft2(double(I2c_bw),cm,cn));

 modulo_I2a_bw = abs(FFT_I2a_bw);
 modulo_I2c_bw = abs(FFT_I2c_bw);
 %moduloa_FF_log = log(1+modulo_I2a_bw);
 %moduloc_FF_log = log(1+modulo_I2c_bw);
 
 for i=1:am
        moduloa_FF_log(i,:)= log(1 + modulo_I2a_bw(i,:));
end;
for i=1:cm
   moduloc_FF_log(i,:)= log(1 + modulo_I2c_bw(i,:));
end;

figure,
    subplot(2,1,1), imshow(I2a_bw),title("Imagen original");
    subplot(2,1,2), imshow(moduloa_FF_log,[]),title("FFT original");
figure,

    subplot(2,1,1), imshow(I2c_bw),title("Imagen Trasladada y escalada ");
    subplot(2,1,2), imshow(moduloc_FF_log,[]),title("FFT traladad y escalada");

%viendo los dibujos no sabr�a interpretarlos.....

%% Cuestion 3 (Contestada en las hojas)
%% Cuesti�n 4 
%%Tengo 8 im�genes binarias del mismo tama�o.
%Con uint8 podemos representar valores enteros, en el caso de una image de
%grises podremos representar distintos niveles de intensidad en un rando de
%0-255 distribuidos en plannos de bit. Cada plano de bit tendr� un n�mero
%binario.
%Cada pixel corresponde a un valor de bit por lo que en cada plan0o de bit
%tendremos 30x30 p�xeles con un valor de bit asociado a cada pixel en los distintos planos. 

%Los planos de bit van del 7-0 siendo el 7 el plano con el bit mas significativo y el 0 el menos.
%Si solo tenemos la posibilidad de reconstruir la imagen con la mitad de
%los planos, nos quedar�amos con los planos de bit mas significativos ya que
%ser�n los que m�s infomraci�n tengan de la imagen, es decir del 7-3

%% Cuesti�n 5

%%h = fspecial('average',hsize) returns an averaging filter h of size hsize.
% El negativo es la pendiente unidad, no aumenta el contraste mantiene la
% diferencia.
