%% Pregunta 3
clear all, close all, clc

%Lo que hacemos es pasar la imagen a escala de grises para poder hacer un
%filtrado de media con la intenci�n de difuminar las lineas fins, por ello
%a la hora de crear la mascara del filtro se tendr� que escoger uno que sea
%lo sfucientemente grande como para poder difumiar las lineas pero lo
%suficientemente pequel�o como para que no afecte a las que queramos
%conservar. y el centro en el medio
%Puesto qeu lo que estamos haiendo es eliminar un "contorno" se elige este
%tipo de filtro en vez del de mediana.

I_3 = imread('Captura3.PNG');
h = 1/25*ones(5,5);
I_3_gray = rgb2gray(I_3);
figure,imshow(I_3_gray);
figure,imhist(I_3_gray);

I3_bw = im2bw (I_3_gray,37/255);

I3_gray_bw = uint8(I3_bw.*255);
I3_Filtrada = imfilter(I3_gray_bw,h);

I3_bw = im2bw (I3_Filtrada,240/255);

figure, imhist(I3_Filtrada), axis auto;
imtool(I3_Filtrada),title('Image Mediana');
imtool(I3_bw);

%% Pregunta 5
%En  relaci�n  a  la  transformada  de  Hough,  justifique  razonadamente  
%si  las  siguientes  afirma-ciones son ciertas o falsas
% a) Es un procedimiento robusto a oclusiones de los elementos a detectar
% Verdadero, en caso de tener huecos es capaz de identificar la geometr�a
% del elemento (Aunque no s� si se refiere a esto la verdad...) pero hay
% que tener cuidado con los enmascaramientos. Permite detectar
% alineamientos

% b)El tama�o �ptimo de la matriz acumuladora  (dimensiones del espacio de Hough)
% se ob-tiene conforme a una expresi�n que s�lo depende del tama�o de la imagen.

%FALSO! Depende del n�mero de par�metros desconocidos del problema, en caso
%de una recta ser�n 2 pero por ejemplo un plano seran 3
%Depende del tama�o, resoluci�n del �ngulo 
%(y las dimensiones en este caso no ya que una imagen es de dos dimensiones )

% C)Es posible que algunos m�ximos del espacio de Hough no correspondan con 
%las formas geom�tricas que se desean detectar en la imagen.

%Verdadero, puede darse el caso de tener sobresegmentaciones en imagenes
%con mucho brillo lsa cuales enmascaran la forma geom�trica que se quiera
%detectar (No todos los m�ximos corresponden al espacio transformado)

