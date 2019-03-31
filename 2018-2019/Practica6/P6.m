I = imread('Board_Recorte.tif');
imtool(I);
I_R = I(:,:,1);
I_G = I(:,:,2);
I_B = I(:,:,3);

imtool(I_R);
imtool(I_G);
imtool(I_B);
%¿Considera  que alguna de las componentes podría ser más relevante 
%para segmentar la imagen y obtener únicamente los 7 chips indicados
%anteriormente?Justifique su respuesta.

%Creo que no puesto que al tener los 3 planos la componente de color no se
%podría realizar una segmentación adecuada.

%%
%La función de abajo separa HSI
[h,s,i] = rgb2hsi(I);

imtool(h);
imtool(s);
imtool(i);

%¿Cómo ha determinadoel rango dinámico?.
% El rango dinámico se determina a partir del máximo nivel de intensidad -
% el mínimo nivel de intensidad

%Se pueden diferenciar mucho mejor los chips en la S -> Saturación
imhist(s);

Componente  = s;

%%
%-- Apartado 2 Umbralización y filtrado --

%%
%Umbralizar

imhist(Componente);

%Método de Otsu para calcular el umbral
level = graythresh(Componente)

%Podría meter level pero bueno meto el método directamente
I_BW = im2bw(Componente,graythresh(Componente));
imtool(I_BW);

I_BW_255 = I_BW*255;
imtool(I_BW_255);

I_BW_255u = uint8(I_BW_255);
imtool(I_BW_255u);
imhist(I_BW_255u);

%Aplicamos un filtro de mediana 
I_filt_5x5 = medfilt2(I_BW_255u,[5 5],'symmetric');
imtool(I_filt_5x5);


%%
%-- Apartado 3 Operadores morfológicos --

%%

%Definición del EE con 35 pixeles

EE_cuadrado = strel('square',35);

I_erosion = imerode(I_filt_5x5,EE_cuadrado);
I_dilatacion = imdilate(I_filt_5x5,EE_cuadrado);
I_Apertura = imopen(I_filt_5x5,EE_cuadrado);
I_Cierre = imclose(I_filt_5x5,EE_cuadrado);

imtool(I_erosion);
imtool(I_dilatacion);
imtool(I_Apertura);
imtool(I_Cierre);

figure,subplot(2,4,2), imshow(I_filt_5x5),title('Imagen original'); 
subplot(2,4,5), imshow(I_erosion),title('Imagen Erosionada');
subplot(2,4,6), imshow(I_dilatacion),title('Imagen Dilatada');
subplot(2,4,7), imshow(I_Apertura),title('Imagen Apertura');
subplot(2,4,8), imshow(I_Cierre),title('Imagen Cierre');


%El mejor es el cierre porque los objetos de interes se mantienen a su
%tamaño original
Im_Res_Morf = I_Cierre;

%%
%-- Apartado 4 Segmentación y caracterización de objetos --


%%
%HAY QUE HACER EL NEGATIVO PORQUE SINO PILLA EL FONDO Y NOS INTERESAN LOS
%OBJETOS
I_morf = (1-Im_Res_Morf
[IM_Seg,Num_objetos] = bwlabel(I_morf);
RGB_Segment = label2rgb(IM_Seg);
figure, imshow(RGB_Segment);

%Total de objetos N= 13 no coincide con el número de chips

Num_objetos = max(IM_Seg(:))

Props = regionprops(IM_Seg,'Eccentricity');
imtool(IM_Seg,[])

%Como quiero los que tienen los de mayor area hago esta funcion

V_Excentricidad = [];
for ind_obj=1:Num_objetos
V_Excentricidad = [V_Excentricidad Props(ind_obj).Eccentricity];
end

figure,stem(V_Excentricidad)

%Para conseguir el contorno se debe hacer dilatación menos erosión
%%
EE_cuadrado = strel('square',5);

V_Interes = [1,7,9,12,6,5,11];

%Bucle del averno pruebalo en casa
%
%
[n_filas, n_cols] = size(I_morf);

for ind_nfila=1:n_filas
    for ind_ncol=1:n_cols
        if I_morf(ind_nfila,ind_ncol)
            numero_et = IM_Seg(ind_nfila,ind_ncol);
            if sum(ismember(V_Interes,numero_et)) > 0
                I_morf(ind_nfila,ind_ncol) = 1;
            else
                I_morf(ind_nfila,ind_ncol) = 0;
            end
        end
    end
end

%
%
%


rd=imdilate(Im_Res_Morf,EE_cuadrado);
r_ext=rd&~Im_Res_Morf;

imtool(r_ext)

%Hacer la nueva respresentacion con las de interes y luego pintarlo sobre
%la imagen original

