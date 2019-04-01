clear all, close all, clc
I_celulas = imread('I_celulas.bmp');

figure , imshow(I_celulas), title("Imagen original");


EE_circulo_1 = strel('disk',1);
EE_circulo_2 = strel('disk',2);
EE_circulo_3 = strel('disk',3);

I_open_1 = imopen(I_celulas,EE_circulo_1);
I_cerrado_1 = imclose(I_open_1,EE_circulo_1);

figure,imshow(I_cerrado_1), title("Imagen con disco radio1");
I_open_2 = imopen(I_cerrado_1,EE_circulo_2);
I_cerrado_2 = imclose(I_open_2,EE_circulo_2);

figure,imshow(I_cerrado_2), title("Imagen con disco radio2");


I_open_3= imopen(I_cerrado_2,EE_circulo_3);
I_cerrado_3= imopen(I_open_3,EE_circulo_3);

I_ASF3 = I_cerrado_3;
figure, imshow(I_ASF3),title ('Imagen final')

%% Segmentación watershed

I_neg = 255 - I_ASF3;
EE_circulo_9 = strel('disk',9);

I_marker = imerode(I_neg,EE_circulo_9);
figure, imshow(I_neg), title("Negativo");

figure, imshow(I_marker), title("imagen Erosionada")

%% Reconstrucción

I_rec = imreconstruct(I_marker,I_neg);

figure, imshow(I_rec), title("Imagen reconstruida");

I_max = imregionalmax(I_rec);
figure, imshow(I_max), title("Imagen máximos");

%% Bordes
I_max_reg2 = imclearborder(I_max); %Con esto eliminos los máximos conexos al borde

figure, imshow(I_max_reg2), title("Imagen I_max_2");

%% Filtramso más máximos

I_max_reg3=I_max_reg2;
cc = bwlabel(I_max_reg2);
n_objetos = max(max(cc(:)))
stats = regionprops(cc,I_celulas, 'MeanIntensity');

for nob=1:n_objetos
    if stats(nob).MeanIntensity >= 150
       [r,c] = find(cc == nob);
        I_max_reg3(r,c)=0;
    end
end % for nob

figure, imshow(I_max_reg3), title("Imagen Max3");

%% Marcador externo

I_min = 1- I_max_reg3;
I_dilate = imdilate(logical(I_max_reg3),strel('disk',7));
D = bwdist(I_dilate);

DL = watershed(I_min);
bgm = (DL == 0);

figure, mesh(I_dilate), title("Imagen dilatada");
figure, mesh(D), title("Imagen D");
figure, mesh(DL), title("Imagen DL");
figure, mesh(bgm), title("Imagen bgm");
figure, imshow(imadd(255*uint8(bgm),I_celulas));

%%
 close all
I_minimos = bgm | I_max_reg3;

figure, imshow(I_minimos),title("Imagen minnimos");

hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I_celulas),hy);
Ix = imfilter(double(I_celulas),hx);

I_celulas_grad = sqrt(Ix.^2 + Iy.^2);

figure, imshow(I_celulas_grad,[]),title("gradiente");

I_celulas_grad_mrk = imimposemin(I_celulas_grad,I_minimos);
regmin = imregionalmin(I_celulas_grad_mrk);
figure, imshow(regmin), title ("Celulas gradiente");

L_frontera = watershed(I_celulas_grad_mrk);
frontera = (L_frontera == 0);

figure, imshow(L_frontera,[]), title ("watersher final");
figure, imshow(frontera), title ("watersher final");

figure, imshow(imadd(255*uint8(frontera),I_celulas));

