% Examen 17 Marzo 2016

%Por ejemplo, dos modelos de color
%Desde un punto de vista geom�trico un modelo de color es una forma
%est�ndaraizada de repsentar distintas tonalidades e intensidades.
%Existen diferentes modelos de color ya que seg�n el uso ejemplo gardware o
%software ser� mas recomendable uno u otro.

%Dependeiendo del modelo de color se representa de una manera u otra:
%RGB --> geometricamente se representa como un cubo. Este modelo es un
%modelo lineal, en el que en la diagonal desde el origen al otro extremo se
%encunetra la escala de grises.
%HSI --> se trada de un modelo de color no lineal en forma de cono , el
%�ngulo de la base del cono (H) nos indica el color(tono), la s nos indica la saturazi�n
%LAb --> modelo de color representado mediante una esfera.
% y la I el nivel de intensidad.
% RGB --> aditivo Impresoras
% RGB --> Sustractivo Fotograf�a?
% YUV --> televisi�n
% HSI --> Procesamiento de la imagen

%% Ddua en cuesti�n 2
%pasar los niveles de 6 a 1?

%% Cuestion 3
%Sigueindo las propiedas de las DFT la rotaci�n de la imagen hace que
%su espectro rote el mimsmo �ngulo, por lo que la figura d queda
%descartada.
% En los ejes x e y va a tener el mismo nivel de trnasici�n al ser dos
% cuadrados po lo que deber�a de quedar como un cuadrado por lo que pienso
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

%% Cuesti�n 5
%Explique c�mo se obtienen las proyeccioneshorizontal y vertical de una 
%imagen binaria I de tama�o 20x80 p�xeles. Para este caso concreto, 
%�cu�l es la longitud del vector asociado a la proyecci�n horizontal?
%�cu�l es el m�ximo valor que se puer?Justifi-que 
%razonadamente sus respuestas.


% Las proyecciones son la suma de niveles de intensidad de cada una de las
% coorcenadas es decir en el caso de una proyecci�n horizontal
% reprensentaremos en el eje x el nivel total de la suma de filas y en el
% eje y ser�n las distintas filas en el caso de una imagen 20X80 el 20 ser�
% el eje y de la proyecci�n horizontal y 80 en el caso de la proyecci�n
% vertical que sumar� el nivel de las columnas.(Yo me entiendo)

%En el caso de la proyecci�n horizontal y siendo una imagen binaria, el
%m�ximo valor al que se podr�a llegar ser�a el de 80. El valor m�ximo del
%vector columna es de 20

%Considere la imagen de la Figura C5, correspondiente a un fragmento de una
%partitura. Justi-fiquerazonadamente qu� procedimiento seguir�a para saber 
%si la p�gina est� rotada utilizan-do una de las proyecciones (a determinar).

%Considerando que se trata de una imagen binaria, pasar�a a primer plano
% el negro de la partitura es decir har�a su negativo posteriormente
% calculadr�a su proyecci�n horizontal  y considerando que coincide el
% comenzo de la imagen con el coinezo y fin de la partitura tendr�a que
% coincidir en n� de p�xeles con la longitud horizonal de la imagen y esto
% tendr�a que coincidir 5 veces al tratarse de un pentagrama.

