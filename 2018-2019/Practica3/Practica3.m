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
% Propiedades de la FFT

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

%% Filtrado paso bajo en el dominio frecuencial
clear all, close all, clc

I_Triangulo = imread('material/triangulo.bmp');
H10 = lpfilter('ideal', 256, 256, 10);
H30 = lpfilter('ideal', 256, 256, 30);
H50 = lpfilter('ideal', 256, 256, 50);

%Representación 3D de las respuestas en frecuencia de los filtros
%Filtro paso bajo ideal
figure,
subplot(6,2,1), mesh(fftshift(H10));
subplot(6,2,2), imshow(fftshift(H10));
subplot(6,2,3), mesh(fftshift(H30));
subplot(6,2,4), imshow(fftshift(H30));
subplot(6,2,5), mesh(fftshift(H50));
subplot(6,2,6), imshow(fftshift(H50));



%Filtro gaussiano
HG10 = lpfilter('gaussian', 256, 256, 10);
HG30 = lpfilter('gaussian', 256, 256, 30);
HG50 = lpfilter('gaussian', 256, 256, 50);

figure,
subplot(6,2,1), mesh(fftshift(HG10));
subplot(6,2,2), imshow(fftshift(HG10));
subplot(6,2,3), mesh(fftshift(HG30));
subplot(6,2,4), imshow(fftshift(HG30));
subplot(6,2,5), mesh(fftshift(HG50));
subplot(6,2,6), imshow(fftshift(HG50));

%% Filtrado 
F=fft2(double(I_Triangulo));

Filtrada_freq10 = H10.*F;
Filtrada_freq30 = H30.*F;
Filtrada_freq50 = H50.*F;

Filtrada_espacio10=real(ifft2(Filtrada_freq10));
Filtrada_espacio30=real(ifft2(Filtrada_freq30));
Filtrada_espacio50=real(ifft2(Filtrada_freq50));
figure, 
subplot(2,2,1), imshow(I_Triangulo)
subplot(2,2,2), imshow(Filtrada_espacio10, [])
subplot(2,2,3), imshow(Filtrada_espacio30, [])
subplot(2,2,4), imshow(Filtrada_espacio50, [])

Filtrada_freqG10 = HG10.*F;
Filtrada_freqG30 = HG30.*F;
Filtrada_freqG50 = HG50.*F;

Filtrada_espacioG10=real(ifft2(Filtrada_freqG10));
Filtrada_espacioG30=real(ifft2(Filtrada_freqG30));
Filtrada_espacioG50=real(ifft2(Filtrada_freqG50));

figure, 
subplot(2,2,1), imshow(I_Triangulo)
subplot(2,2,2), imshow(Filtrada_espacioG10, [])
subplot(2,2,3), imshow(Filtrada_espacioG30, [])
subplot(2,2,4), imshow(Filtrada_espacioG50, [])

%Revisar los resultados, algunos no los entiendo

%% Filtro paso alto
clear all, close all, clc
I_Triangulo = imread('material/triangulo.bmp');

%Es una imagen con alta frecuecnia por lo que el resultado debería de ser
%muy similar a ala original y el modulo debería de estar alejado del
%centro.
HPB = lpfilter('ideal', 256, 256, 100);
HPA = 1 - HPB;

F=fft2(double(I_Triangulo));
Filtrada_freq = HPA.*F;
FFT_image_Triangulo = fftshift(Filtrada_freq);
FFT_modulo_Triangulo =abs(FFT_image_Triangulo); %Este modulo no me cuadra, duda!!!

Filtrada_espacio=real(ifft2(Filtrada_freq));
FiltroA1 = abs(Filtrada_espacio);

figure,
subplot(2,2,1), imshow(I_Triangulo)
subplot(2,2,2), imshow(Filtrada_espacio, [])
subplot(2,2,3), imshow(FFT_modulo_Triangulo, [])%ahora sí
subplot(2,2,4), imshow(FiltroA1, [])%No entiendo, por qué nos estamos quedando con los contornos?

%% filtro suavizado
clear all, close all, clc
I_Triangulo = imread('material/triangulo.bmp');

%Es una imagen con alta frecuecnia por lo que el resultado debería de ser
%muy similar a ala original y el modulo debería de estar alejado del
%centro.
HPB = lpfilter('gaussian', 256, 256, 100);
HPA = 1 - HPB;

F=fft2(double(I_Triangulo));
Filtrada_freq = HPA.*F;
FFT_image_Triangulo = fftshift(Filtrada_freq);
FFT_modulo_Triangulo =abs(FFT_image_Triangulo); %Este modulo no me cuadra, duda!!!

Filtrada_espacio=real(ifft2(Filtrada_freq));
FiltroA1 = abs(Filtrada_espacio);

figure,
subplot(2,2,1), imshow(I_Triangulo)
subplot(2,2,2), imshow(Filtrada_espacio, [])
subplot(2,2,3), imshow(FFT_modulo_Triangulo, [])%ahora sí
subplot(2,2,4), imshow(FiltroA1, [])%No entiendo, por qué nos estamos quedando con los contornos?
%% No veo el problema
%Filtro paso alto es deribador por lo que tendremos contornos como
%resultado de esta operación.

%%
