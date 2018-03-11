%%
%Prácica 5 Apartado1
clear all;
close all;
imtool close all;

cormoran = imread('cormoran_rgb.jpg');
cormoran_gray =  rgb2gray(cormoran);

figure,imshow(cormoran_gray);
figure,imhist(cormoran_gray);

%%
%Extracción de cada componente de color en espacio RGB


cormoran_R = cormoran(:,:,1);
cormoran_G = cormoran(:,:,2);
cormoran_B = cormoran(:,:,3);

[nrows, ncols, ndim] = size(cormoran);
cormoran_R_res = reshape(cormoran_R,nrows*ncols,1);
cormoran_G_res = reshape(cormoran_G,nrows*ncols,1);
cormoran_B_res = reshape(cormoran_B,nrows*ncols,1);

figure, plot3(cormoran_R_res,cormoran_G_res ,cormoran_B_res,'.b');

%%
ngrupos = 3;
rgb_res = double ([cormoran_R_res cormoran_G_res cormoran_B_res]);

[cluster_idx cluster_center] = kmeans(rgb_res,ngrupos,'distance','sqEuclidean','Replicates',10);
pixel_labels_rgb = reshape(cluster_idx,nrows,ncols);
figure, plot3(cormoran_R_res,cormoran_G_res ,cormoran_B_res,'.b');
hold on; %No me aparece los cuadrados 
plot3(cluster_center(:,1), cluster_center(:,2), cluster_center(:,3),'sr');

figure, imshow(pixel_labels_rgb,[]);
cormoran_segm = label2rgb(pixel_labels_rgb);
figure, imshow(cormoran_segm);

%Maximiza la distnacia entre distiontos clusters y minimiza la disntacia
%intra cluster.
%%

[lab_imL, l_L, a_L, b_L] = rgb2lab(cormoran);
a_res = reshape(a_L,nrows*ncols,1);
b_res = reshape(b_L,nrows*ncols,1);

ab_res = [a_res b_res];
[cluster_idx cluster_center] = kmeans(rgb_res,ngrupos,'distance','sqEuclidean','Replicates',10);

figure, plot(a_res, b_res,'.')
xlabel('a'), ylabel('b')
hold on 
plot(cluster_center(:,1), cluster_center(:,2),'sr');
pixel_labels_ab = reshape(cluster_idx,nrows,ncols);
cormoran_segm = label2rgb(pixel_labels_ab); %Esto asigna los labels a los colores?
figure, imshow(cormoran_segm);

std(a_res);
std(b_res);
%%
% Normalizamos las dos componentes para que tengan la medaia
ndim = size(ab_res,2);
a_res = reshape(a_L,nrows*ncols,1);
b_res = reshape(b_L,nrows*ncols,1);

ab_res = [a_res b_res];

ab_norm = ab_res;
for ind_dim=1:ndim
datos = ab_res(:,ind_dim);
datos_norm = (datos-mean(datos))/std(datos);
ab_norm(:,ind_dim)=datos_norm;
end

[cluster_idx ,cluster_center] = kmeans(ab_norm,ngrupos,'distance','sqEuclidean','Replicates',10);
pixel_labels_ab_norm = reshape(cluster_idx,nrows,ncols);
cormoran_segm = label2rgb(pixel_labels_ab_norm);

figure, plot(ab_norm(:,1),ab_norm(:,2),'.b');
hold on;
plot(cluster_center(:,1), cluster_center(:,2),'sr');

figure, imshow(pixel_labels_ab_norm,[]);
cormoran_segm = label2rgb(pixel_labels_ab_norm);
figure, imshow(cormoran_segm);

%%
%Apartado 4
%Para sacar las características de textura
S = stdfilt(cormoran_gray,ones(7,7));
imtool(S,[]), title('S')

E = entropyfilt(cormoran_gray,ones(7,7));
imtool(E,[]), title('E')

R = rangefilt(cormoran_gray,ones(7,7));
imtool(R,[]), title('R')

S_res = reshape(S,nrows*ncols,1);
E_res = reshape(E,nrows*ncols,1);

S_E = [S_res E_res];

ndim = size(S_E,2);
SE_norm = S_E;

for ind_dim=1:ndim
datos = S_E(:,ind_dim);
datos_norm = (datos-mean(datos))/std(datos);
SE_norm(:,ind_dim)=datos_norm;
end

[cluster_idx cluster_center] = kmeans(SE_norm,ngrupos,'distance','sqEuclidean','Replicates',10);
pixel_labels_SE_norm = reshape(cluster_idx,nrows,ncols);

Cormoran_segm_SE_norm = label2rgb(pixel_labels_SE_norm);
figure, imshow(Cormoran_segm_SE_norm), title('segm SE norm');

figure, plot(SE_norm(:,1),SE_norm(:,2),'.')
xlabel('S-norm'),ylabel('E-norm')
hold on
plot(cluster_center(:,1), cluster_center(:,2),'sr');

%%
%Apartado 5
%En este apartado tengo que segmentar con el modelo Lab
%Para la componente de textura utilizaremos la entropía ylas dos
%componentes de croma , a y b del modelo lab.
cormoran_lab = rgb2lab(cormoran);

%Normalizamos la componente de entropía
E_norm = E_res;
E_norm(:) = (E_res(:) - mean(E_res(:)))/ std(E_res(:));

%Segmentación
ngrupos_lab_norm = 3;
lab_ent_res_norm = double([ab_norm, E_norm]);
[cluster_idx_lab_ent_norm cluster_center_lab_ent_norm] = kmeans(lab_ent_res_norm,ngrupos_lab_norm,'distance','sqEuclidean','Replicates',10);

%Reprensentación de los centroides en el scatter plot correspondiente.
figure, plot3(cluster_center_lab_ent_norm(:,1), cluster_center_lab_ent_norm(:,2), cluster_center_lab_ent_norm(:,3), 'sr');

%se ve:
pixel_labels_rgb_norm = reshape(cluster_idx_lab_ent_norm, nrows,ncols);
I_segm_ent_norm = label2rgb(pixel_labels_rgb_norm);
figure, imshow(I_segm_ent_norm)

%cómo aún se ve sobresegmentación debemos aplicar un filtro de suavizado

%%
%Apartado 5b

a_suav = medfilt2(a_L,[7 7]);
a_res_suav =  reshape(a_suav,nrows*ncols,1);
b_suav = medfilt2(b_L,[7 7]);
b_res_suav = reshape(b_suav,nrows*ncols,1);
ab_res_suav = [a_res_suav b_res_suav];
ndim_suav = size(ab_res_suav,2);
ab_norm_suav = ab_res_suav;

for ind_dim=1:ndim %Se mueve por toda la dimension
    datos = ab_res_suav(:,ind_dim);
    datos_norm = (datos-mean(datos))/std(datos); %Se le resta la media y se divide entre varianza
    ab_norm_suav(:,ind_dim)=datos_norm; %Construimos una matris ab normalizada
end
ngrupos = 3;
mix_res = double([ab_norm_suav E_norm]);
[cluster_idx_mix_suav cluster_center_mix_suav] = kmeans(mix_res,ngrupos,'distance','sqEuclidean','Replicates',10);
%Representacion de imagen final
pixel_labels_mix_suav = reshape(cluster_idx_mix_suav,nrows,ncols); %Volvemos a dimensionar 
I_segm_mix_suav = label2rgb(pixel_labels_mix_suav); %Tecnica de falso color
figure;
imshow(I_segm_mix_suav);






