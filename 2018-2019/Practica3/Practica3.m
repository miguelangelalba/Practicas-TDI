%% Apartado1
clear all, close all, clc

I_Triangulo = imread('material/triangulo.bmp');

FFT_image_Triangulo = fftshift(fft2(double(I_Triangulo),256,256));


FFT_modulo_Triangulo =abs(FFT_image_Triangulo);
FFT_fase_Triangulo = angle(FFT_image_Triangulo);


figure, 
subplot(2,2,1), imshow(I_Triangulo);
subplot(2,2,2), imshow(FFT_modulo_Triangulo,[]);
subplot(2,2,3), imshow(FFT_fase_Triangulo);
subplot(2,2,4), mesh(FFT_modulo_Triangulo);

%% 
componente_continua = max(max(FFT_image_Triangulo))/(256*256) %Valor medio calculado con el modulo de la FFT
Valor_Medio_Espacial_imagen = mean(double(I_Triangulo(:))) %Valor medio dominio espacial
FFT_media=mean(max(FFT_image_Triangulo)) % Lo que no entiendo es el motivo por el cual coinciden 
%creo que es por la distribición espacial de la nergía y en frecuencia, que
%son dos maneras de representar lo mismo

%% Para mejorar la visualización la trasnfomración que debemos aplicar es la logarítmica.


FFT_image_Triangulo_log = log10(1+ FFT_image_Triangulo);
figure,
subplot(2,2,1), imshow(I_Triangulo);
subplot(2,2,2), imshow(FFT_image_Triangulo_log,[]);

%Tiene esa forma coincidiendo con la orientación del triángulo,
%apareciendo en los lados de 45º, 90º y 180º

%% Apartado 2

clear all, close all, clc

I_Triangulo_desp = imread('material/triangulodesp.bmp');
I_TrianguloZoom = imread('material/triangulozoom.bmp');
I_Triangulogirado = imread('material/triangulogirado.bmp');

FFT_image_Triangulo_desp = fftshift(fft2(double(I_Triangulo_desp),256,256));
FFT_image_TrianguloZoom = fftshift(fft2(double(I_TrianguloZoom),256,256));
FFT_image_Triangulogirado = fftshift(fft2(double(I_Triangulogirado),256,256));

FFT_modulo_Triangulo_desp =abs(FFT_image_Triangulo_desp);
FFT_fase_Triangulo_desp = angle(FFT_image_Triangulo_desp);

FFT_modulo_TrianguloZoom =abs(FFT_image_TrianguloZoom);
FFT_fase_TrianguloZoom = angle(FFT_image_TrianguloZoom);

FFT_modulo_Triangulogirado =abs(FFT_image_Triangulogirado);
FFT_fase_Triangulogirado = angle(FFT_image_Triangulogirado);

FFT_image_Triangulo_desp_log = log10(1+ FFT_image_Triangulo_desp);
FFT_image_Triangulo_Zoom_log = log10(1+ FFT_image_TrianguloZoom);
FFT_image_Triangulo_girado_log = log10(1+ FFT_image_Triangulogirado);


% Representar 

figure, 
subplot(2,2,1), imshow(I_Triangulo_desp);
subplot(2,2,2), imshow(FFT_modulo_Triangulo_desp,[]);
subplot(2,2,3), imshow(FFT_fase_Triangulo_desp);
subplot(2,2,4), imshow(FFT_image_Triangulo_desp_log,[]);
figure, 
subplot(2,2,1), imshow(I_TrianguloZoom);
subplot(2,2,2), imshow(FFT_modulo_TrianguloZoom,[]);
subplot(2,2,3), imshow(FFT_fase_TrianguloZoom);
subplot(2,2,4), imshow(FFT_image_Triangulo_Zoom_log,[]);

figure, 
subplot(2,2,1), imshow(I_Triangulogirado);
subplot(2,2,2), imshow(FFT_modulo_Triangulogirado,[]);
subplot(2,2,3), imshow(FFT_fase_Triangulogirado);
subplot(2,2,4), imshow(FFT_image_Triangulo_girado_log,[]);

Maximo_desplazado = max(max(FFT_modulo_Triangulo_desp))
Maximo_zoom = max(max(FFT_modulo_TrianguloZoom))


