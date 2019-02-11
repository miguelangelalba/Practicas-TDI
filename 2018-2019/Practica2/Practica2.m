%% Apartado 1

I = uint8(ones(256,256))*128; 
figure, 
subplot(2,1,1), imshow(I);
subplot(2,1,2), imhist(I),axis('auto');
%% Ruido en la imagen

I_speckle = imnoise(I,'speckle',0.02);
I_gaussian = imnoise(I,'gaussian',0,0.02); %Media y varianza
I_salt_pepper = imnoise(I,'salt & pepper',0.02);
New_I = [I_gaussian,I_speckle,I_salt_pepper]; %256 filas y columnas 256*3
figure, imshow(New_I);

figure
subplot(4,1,1), imshow(New_I);
subplot(4,1,2), imhist(I_gaussian),axis('auto');
subplot(4,1,3), imhist(I_speckle),axis('auto'); % Distribución uniforme
subplot(4,1,4), imhist(I_salt_pepper),axis('auto');


%% Filtrado

h = 1/25*ones(5,5);
h_grande = (1/(35*35))*ones(35/35);

I_gauss_suav = imfilter(I_gaussian,h);
I_gauss_grande = imfilter(I_gaussian,h_grande);
I_speckle_suav = imfilter(I_speckle,h);
I_salt_pepper = imfilter(I_salt_pepper,h);

New_I_suav = [I_gauss_suav,I_speckle_suav,I_salt_pepper]; %256 filas y columnas 256*3

figure,
subplot(6,1,1), imshow(New_I_suav);
subplot(6,1,2), imhist(I_gauss_suav),axis('auto');
subplot(6,1,3), imshow(New_I_suav);
subplot(6,1,4), imhist(I_speckle_suav),axis('auto');
subplot(6,1,5), imshow(New_I_suav);
subplot(6,1,6), imhist(I_salt_pepper),axis('auto');

figure, % Ruido vs filtrada
subplot(3,1,1), imhist(I_gaussian),axis('auto'); % Estrechamos la delta de ruido (Si aumentamos la máscara la anchura de reduce)
subplot(3,1,2), imhist(I_gauss_suav),axis('auto');
subplot(3,1,3), imhist(I_gauss_grande),axis('auto');


%% Para eliminar la mini camapana tenemos que hacer 

I_gauss_suav_padding = imfilter(I_gaussian,h,'symmetric','same'); % con esto eliminamos el falso contorno 

figure,
subplot(4,1,1), imshow(I_gauss_suav_padding);
subplot(4,1,2), imhist(I_gauss_suav_padding),axis('auto');
subplot(4,1,3), imshow(I_gauss_suav);
subplot(4,1,4), imhist(I_gauss_suav),axis('auto');



