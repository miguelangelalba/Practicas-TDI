clear all, close all, clc

chips = imread('Board_Recorte.TIF');

figure,imshow(chips);
figure,imhist(chips);

chips_R = chips(:,:,1);
chips_G = chips(:,:,2);
chips_B = chips(:,:,3);
%% 
figure,imhist(chips_R);
figure,imhist(chips_G);
figure,imhist(chips_B);

%% Cambio espacio de color

[h,s,i] = rgb2hsi(chips);

figure,
subplot(3,2,1), imshow(h), title('H');
subplot(3,2,2), imshow(s), title('S');
subplot(3,2,3), imshow(i), title('I');
figure,
subplot(3,2,1), imhist(h), title('Histograma, H');
subplot(3,2,2), imhist(s), title('Histograma, S');
subplot(3,2,3), imhist(i), title('Histograma, I');

%% 
componente = s;

umbral = graythresh(componente); % Me da que ya sale normalizados

componente_bw = im2bw(componente,umbral);
figure, imshow(componente_bw);

componente_escalada = uint8(componente_bw *255);

imtool(componente_escalada);
%% Filtrar (Filtro de medaina por ruido de sal y pimienta)

componente_filtrada = medfilt2(componente_escalada, [5 5],'symmetric');
figure, imshow(componente_filtrada),title("Imagen giltrada con filtro de mediana");

%% Aplicación de elementos morfológicos
%Erosión (instrucción imerode)
%Dilatación (instrucción imdilate)
%Apertura (instrucción imopen)
%Cierre (instrucción imclose)
EE_cuadrado = strel('square',35);

I_erosion = imerode(componente_filtrada,EE_cuadrado);
I_dilatacion = imdilate(componente_filtrada,EE_cuadrado);
I_apertura = imopen(componente_filtrada,EE_cuadrado);
I_cierre = imclose(componente_filtrada,EE_cuadrado);

figure,
subplot(4,2,1), imshow(I_erosion), title('Erosión');
subplot(4,2,2), imshow(I_dilatacion), title('Dilatación, S');
subplot(4,2,3), imshow(I_apertura), title('Apertura');
subplot(4,2,4), imshow(I_cierre), title('Cierre');

figure,imshow(I_cierre);

%% Segmentación
I_morf = (1-I_cierre);

IM_Seg = bwlabel(I_morf);
RGB_Segment = label2rgb(IM_Seg);
figure, imshow(RGB_Segment)
Num_objetos = max(IM_Seg(:));

%% Cuadrado o rectángulo? 

figure, imtool(IM_Seg,[])
Props = regionprops(IM_Seg, 'Eccentricity');
%Props(2).Eccentricity
V_Excentricidad = [];
for ind_obj=1:Num_objetos
    V_Excentricidad = [V_Excentricidad Props(ind_obj).Eccentricity];
end

figure,stem(V_Excentricidad);

V_Interes = [1,7,9,12];

[n_filas, n_cols] = size(I_morf);

for ind_nfila=1:n_filas
    for ind_ncol=1:n_cols
        if I_morf(ind_nfila,ind_ncol)
            numero_et = IM_Seg(ind_nfila,ind_ncol);
            if sum(ismember(V_Interes,numero_et)) > 1
                I_morf(ind_nfila,ind_ncol) = 1;
            else
                I_morf(ind_nfila,ind_ncol) = 0;

            end
        end
    end
end

figure, imshow(I_morf)

%% Delimitación de las fronteras
close all


%Puedo hacer la dilatación y la erosión y hacer la resta entre amabas
EE_cuadrado_final = strel('square',3);
Negativo = 255 - I_cierre;

I_erosion_final = imerode(Negativo,EE_cuadrado_final);
I_dilatacion_final = imdilate(Negativo,EE_cuadrado_final);

I_final = I_dilatacion_final -I_erosion_final;

figure, imshow(I_erosion_final),title("Imagen erosionada");
figure, imshow(I_dilatacion_final),title("Imagen dilatada");
figure, imshow(I_final),title("Contornos");






