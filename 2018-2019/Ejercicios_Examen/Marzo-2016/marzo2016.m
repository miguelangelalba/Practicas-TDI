% Examen 17 Marzo 2016

%Por ejemplo, dos modelos de color
%RGB --> geometricamente se representa como un cubo. Este modelo es un
%modelo lineal, en el que en la diagonal desde el origen al otro extremo se
%encunetra la escala de grises.
%HSI --> se trada de un modelo de color no lineal en forma de cono , el
%ángulo de la base del cono (H) nos indica el color(tono), la s nos indica la saturazión
% y la I el nivel de intensidad.
% RGB --> aditivo Impresoras
% RGB --> Sustractivo Fotografía?
% YUV --> televisión
% HSI --> Procesamiento de la imagen

%% Ddua en cuestión 2
%pasar los niveles de 6 a 1?

%% Cuestion 3
%Sigueindo las propiedas de las DFT la rotación de la imagen hace que
%su espectro rote el mimsmo ángulo, por lo que la figura d queda
%descartada.
% En los ejes x e y va a tener el mismo nivel de trnasición al ser dos
% cuadrados po lo que debería de quedar como un cuadrado por lo que pienso
% que el resultado es la b

clear all, close all, clc

    imagen = imread('cuestion3.PNG');
    EJ3 = rgb2gray(imagen);
    figure, imshow(EJ3);
    m = size(EJ3,1);
    n = size(EJ3,2)
    FFT_image = fftshift(fft2(double(EJ3),m,n));
    modulo_FF = abs(FFT_image);
    for i=1:m
        modulo_FF_contraste(i,:)= log(1 + abs(modulo_FF(i,:)));
    end;
    figure, imshow(modulo_FF_contraste, []), title('MODULO DE Log');

% Correcto!!!!! ^^