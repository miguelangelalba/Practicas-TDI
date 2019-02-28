%% Apartado1
clear all, close all, clc

calculadora = imread('calculadora.TIF');

figure, 
subplot(2,2,1), imtool(calculadora);
subplot(2,2,2), imhist(calculadora);

calculadora_bw = im2bw (calculadora,230/255); % Recuerda que hay que normalizar
imtool(calculadora_bw);
%Blob son las zonas de la imagen.

[Seg_I_U, Nobjetos] = bwlabel(calculadora_bw); %Labes es para etiquetarla
imtool(uint8(Seg_I_U))% Va aumentando el brillo ya que matlaba va asignando niveles según va añadiendo etiquetas
imtool(Seg_I_U,[]);
%Ojo mas sensibles a los cambios de colores que a los cambios de niveles de
%intensidad.
RGB_Segment = label2rgb(Seg_I_U);
figure, imshow(RGB_Segment)

%% Extración de propiedades

Props = regionprops(Seg_I_U, 'Area')
V_Area = [];
for ind_obj=1:Nobjetos
    V_Area = [V_Area Props(ind_obj).Area];
end
figure,stem(V_Area)
xlabel('Numero de obejto'),ylabel('Tamaño');

V_No_Interes = [3 10 40 45 55 56 61]

[n_filas, n_cols] = size(calculadora_bw);

for ind_nfila=1:n_filas
    for ind_ncol=1:n_cols
        if calculadora_bw(ind_nfila,ind_ncol)
            numero_et = Seg_I_U(ind_nfila,ind_ncol);
            if sum(ismember(V_No_Interes,numero_et)) > 0
                calculadora_bw(ind_nfila,ind_ncol) = 0;
            end
        end
    end
end

[Seg_I_U, Nobjetos] = bwlabel(calculadora_bw)
Props = regionprops(Seg_I_U, 'Area')
V_Area = [];
for ind_obj=1:Nobjetos
    V_Area = [V_Area Props(ind_obj).Area];
end
figure,stem(V_Area)
xlabel('Numero de obejto'),ylabel('Tamaño');

figure,imshow(calculadora_bw)% De esta manera filtramos los puntos blancos que
%nos estaban contaminando la imagen (Eliminamos las etiquetas ya que cada punto )

%% Apartado 3

%Filtrado espacial paso bajo
h = 1/(5*5)*ones(5,5);
calculadora_media = imfilter(255*uint8(calculadora_bw),h);
calculadora_media_bw = im2bw(calculadora_media,5/255);
%Mas cerca los de la misms tecla y mas lejos las de las distintas teclas
%Por ello vamos a difuminar los contornos

figure, imshow(calculadora_media_bw);

[Seg_I_U_media, Nobjetos_medias] = bwlabel(calculadora_media_bw); %Labes es para etiquetarla

Props = regionprops(Seg_I_U_media, 'Area')
V_Area = [];

for ind_obj=1:Nobjetos_medias
    V_Area = [V_Area Props(ind_obj).Area];
end
figure,stem(V_Area)
xlabel('Numero de obejto'),ylabel('Tamaño');

imtool(Seg_I_U_media);

%% Borrar píxeles
V_Interes = [5]
for ind_nfila=1:n_filas
    for ind_ncol=1:n_cols
        if calculadora_media_bw(ind_nfila,ind_ncol)
            numero_et = Seg_I_U_media(ind_nfila,ind_ncol);
            if sum(ismember(V_Interes,numero_et)) > 0
                calculadora_media_bw(ind_nfila,ind_ncol) = 1;
            else
                calculadora_media_bw(ind_nfila,ind_ncol) = 0;

            end
        end
    end
end

figure, imshow(calculadora_media_bw)

Final = calculadora .* uint8(calculadora_media_bw);

imtool(Final)
figure, imhist(Final), axis auto;
