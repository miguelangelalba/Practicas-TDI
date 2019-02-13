%% Ejercicio propuestos en clase
clear all, close all, clc
lista = dir('*PNG');
imagenes = [];
FFT_images = [];
modulo_FFT = [];
modulo_FF_contraste = [];
for i= 1:6
    imagenes{i} = rgb2gray(imread(lista(i).name));
    m = size(imagenes{i},1);
    n = size(imagenes{i},2)
    FFT_images{i} = fftshift(fft2(double(imagenes{i}),m,n));
    modulo_FFT{i} = abs(FFT_images{i});
    % for j=1:m
     %   modulo_FF_contraste{i}(j,:)= log(1 + abs(modulo_FFT{i}(j,:))); %% Paso a logratimo para ver mejor
    %end;
    figure,
    subplot(2,1,1), imshow(imagenes{i}),title("Imagen Ejercicio "+i);
    subplot(2,1,2), imshow(modulo_FFT{i}, []), title("Módulo FFT de Ejercicio "+i);
end 


  %% imagenes(i) = imread('Ejercicio'+ i +'.PNG');
  clear all, close all, clc

    imagen = imread('Ejercicio5.PNG');
    EJ1 = rgb2gray(imagen);
    figure, imshow(EJ1);
    m = size(EJ1,1);
    n = size(EJ1,2)
    FFT_image = fftshift(fft2(double(EJ1),m,n));
    modulo_FF = abs(FFT_image);
    for i=1:m
        modulo_FF_contraste(i,:)= log(1 + abs(modulo_FF(i,:)));
    end;
    figure, imshow(modulo_FF_contraste, []), title('MODULO DE X_FFT');
