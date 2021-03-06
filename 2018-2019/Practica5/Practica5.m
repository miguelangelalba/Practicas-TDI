%Apartado 1
clear all, close all, clc
cormoran = imread('cormoran_rgb.jpg');
cormoran_gray =  rgb2gray(cormoran);

%Utilizando componentes crom�ticas

cormoran_R = cormoran(:,:,1);
cormoran_G = cormoran(:,:,2);
cormoran_B = cormoran(:,:,3);

figure,
subplot(3,2,1), imshow(cormoran_R);
subplot(3,2,2), imshow(cormoran_G);
subplot(3,2,3), imshow(cormoran_B);

[nrowsr, ncolsr] = size(cormoran_R);
[nrowsg, ncolsg] = size(cormoran_G);
[nrowsb, ncolsb] = size(cormoran_B);


I_R_res = reshape(cormoran_R,nrowsr*ncolsr,1); %HAcemos un redimensionamientpo
I_G_res = reshape(cormoran_G,nrowsg*ncolsg,1); %HAcemos un redimensionamientpo
I_B_res = reshape(cormoran_B,nrowsb*ncolsb,1); %HAcemos un redimensionamientpo

figure, plot3(I_R_res,I_G_res ,I_B_res,'.b');
%% Aplicaci�n del algoritmo k-medias
ngrupos = 3;
rgb_res = double([I_R_res I_G_res I_B_res]);
[cluster_idx cluster_center] = kmeans(rgb_res,ngrupos,'distance','sqEuclidean','Replicates',10); %REplicamos el algoritmo con replicate y el n�mero indica el n�mero de veces que se replica el c�digo
%Esto se hace as� ya que los centroidoes se colocan de manera aleatoria
%Matlab se queda con la mejor (m�nima dsitancia intracluster y m�xima distancia intracluster)
%El primer parametro es el identificador(es de una �nica dimensi�n del tama�o del n�mero total de p�xeles)
%El segundo parametro hace referencia a la posici�n.(coordenadas de los tres centroides)
pixel_label_rgb = reshape(cluster_idx,nrowsr,ncolsr);

figure, plot3(I_R_res,I_G_res ,I_B_res,'.b');
xlabel('R'),ylabel('G'),zlabel('B');
hold on
plot3(cluster_center(:,1), cluster_center(:,2), cluster_center(:,3),'sr');

figure, imshow(pixel_label_rgb,[]);
cormoran_segm = label2rgb(pixel_label_rgb);
figure, imshow(cormoran_segm);

%% Espcio de color ab

[lab_imL, l_L, a_L, b_L] = rgb2lab(cormoran);
a_res = reshape(a_L,nrowsr*ncolsr,1);
b_res = reshape(b_L,nrowsr*ncolsr,1);
figure, plot(a_res, b_res,'.')
xlabel('a'), ylabel('b')

%% 
ab_res = [a_res b_res];
[cluster_idx cluster_center] = kmeans(ab_res,ngrupos,'distance','sqEuclidean','Replicates',10);

pixel_label_ab = reshape(cluster_idx,nrowsr,ncolsr);

figure, plot(a_res,b_res,'.b');
xlabel('a'), ylabel('b')
hold on
plot(cluster_center(:,1), cluster_center(:,2),'sr');

figure, imshow(pixel_label_ab,[]);
cormoran_segm = label2rgb(pixel_label_ab);
figure, imshow(cormoran_segm);
%% 
%%Vamos a normalizar la represnetiaci�n ya que el espacio y es m�s grande
%%que el x

media_A = mean(a_res);
media_B = mean(b_res)

std(a_res);
std(b_res);
%Normalizaci�n de las componentes para que tengan media 0

ab_res = [a_res b_res];
ndim = size(ab_res,2);
ab_norm = ab_res;
for ind_dim=1:ndim
    datos = ab_res(:,ind_dim);
    datos_norm = (datos-mean(datos))/std(datos);
    ab_norm(:,ind_dim)=datos_norm;
end
[cluster_idx_norm cluster_center] = kmeans(ab_norm,ngrupos,'distance','sqEuclidean','Replicates',10);

pixel_label_ab_norm = reshape(cluster_idx_norm,nrowsr,ncolsr);

figure, plot(ab_norm(:,1),ab_norm(:,2),'.');
xlabel('a-norm'), ylabel('b-norm')
hold on
plot(cluster_center(:,1), cluster_center(:,2),'sr');

figure, imshow(pixel_label_ab_norm,[]);
cormoran_segm = label2rgb(pixel_label_ab_norm);
figure, imshow(cormoran_segm);

%% Caracter�sticas de textura
%La textura se saca de la imagen en gris
%Entrop�a valores bajos pixeles muy similares entre si

S = stdfilt(cormoran_gray,ones(7,7));
imtool(S,[]), title('S')
S1 = entropyfilt(cormoran_gray,ones(7,7)); %Descriptor
S2 = rangefilt(cormoran_gray,ones(7,7)); %Descriptor
imtool(S1,[]), title('S1')
imtool(S2,[]), title('S2')


%% Segmentaci�n 
ngrupoa = 3;

I_S_res = reshape(S,nrowsr*ncolsr,1); %HAcemos un redimensionamientpo
I_S1_res = reshape(S1,nrowsr*ncolsr,1); %HAcemos un redimensionamientpo

ab_res = [I_S_res I_S1_res];

ndim = size(ab_res,2);
ES_norm = ab_res;
for ind_dim=1:ndim
    datos = ab_res(:,ind_dim);
    datos_norm = (datos-mean(datos))/std(datos);
    ES_norm(:,ind_dim)=datos_norm;
end

[cluster_idx_norm cluster_center] = kmeans(ES_norm,ngrupos,'distance','sqEuclidean','Replicates',10);

pixel_label_ab_norm_descriptor_S = reshape(cluster_idx_norm,nrowsr,ncolsr);
%Cambio el orden para que se reprensete como se est� reprensentando en
%clase
figure, plot(ES_norm(:,2),ES_norm(:,1),'.');
xlabel('E-norm'), ylabel('S-norm')
hold on
plot(cluster_center(:,2), cluster_center(:,1),'sr');

figure, imshow(pixel_label_ab_norm,[]);
cormoran_segm = label2rgb(pixel_label_ab_norm_descriptor_S);
figure, imshow(cormoran_segm);


%% Combinaci�n de 3 caracter�sticas


abE_res = [a_res b_res I_S1_res]

ndim = size(abE_res,3);
abE_norm = abE_res;
for ind_dim=1:ndim
    datos = ab_res(:,ind_dim);
    datos_norm = (datos-mean(datos))/std(datos);
    abE_norm(:,ind_dim)=datos_norm;
end

[cluster_idx_abE_norm cluster_center] = kmeans(abE_norm,ngrupos,'distance','sqEuclidean','Replicates',10);

pixel_label_abe_norm_descriptor_S = reshape(cluster_idx_abE_norm,nrowsr,ncolsr);
figure, plot3(abE_norm(:,1),abE_norm(:,2),abE_norm(:,3),'.');
xlabel('B-norm'), ylabel('A-norm'),zlabel('E-norm')

hold on
plot3(cluster_center(:,1), cluster_center(:,2),cluster_center(:,3),'sr');

figure, imshow(cluster_idx_abE_norm,[]);
cormoran_segm = label2rgb(pixel_label_abe_norm_descriptor_S);
figure, imshow(cormoran_segm);
% 3 20junio2016 5 20 junio2016 y el 5 17 de marzo 2016
% La representaci�n est� mal es b, a no a, b
 
%Usamos el modelo Lab, ya que trabajamos con distancias la distancia
%eucl�dea pondera por igual ambas distnacias, "buscamos c�culos"
% Normalizar es muy importante! va aentrar en el examen fijo

% La textura depdende variaciones locales del nivel de intensidad, parace
% mas razonable actuar sobre el espacio de color, por lo que es ah� donde
% haremos el suavizado
%% NO sale, tengo que repasar este apartado
mascara = 1/49*ones(7,7);
a_mean = imfilter(a_L,mascara,'symmetric');
b_mean = imfilter(b_L,mascara,'symmetric');

%[lab_imL, l_L, a_L, b_L] = rgb2lab(cormoran);
a_res = reshape(a_mean,nrowsr*ncolsr,1);
b_res = reshape(b_mean,nrowsr*ncolsr,1);


abE_res = [a_res b_res I_S1_res]

ndim = size(abE_res,3);
abE_norm = abE_res;
for ind_dim=1:ndim
    datos = ab_res(:,ind_dim);
    datos_norm = (datos-mean(datos))/std(datos);
    abE_norm(:,ind_dim)=datos_norm;
end

[cluster_idx_abE_norm cluster_center] = kmeans(abE_norm,ngrupos,'distance','sqEuclidean','Replicates',10);

pixel_label_abe_norm_descriptor_S = reshape(cluster_idx_abE_norm,nrowsr,ncolsr);
figure, plot3(abE_norm(:,1),abE_norm(:,2),abE_norm(:,3),'.');
xlabel('B-norm'), ylabel('A-norm'),zlabel('E-norm')

hold on
plot3(cluster_center(:,1), cluster_center(:,2),cluster_center(:,3),'sr');

figure, imshow(cluster_idx_abE_norm,[]);
cormoran_segm = label2rgb(pixel_label_abe_norm_descriptor_S);
figure, imshow(cormoran_segm);

%En general mejor los esquemas supervisados que los no supervisados
%Normalizar caracter�sticas no etiquetas

