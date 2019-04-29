clear all, close all, clc

file_name = 'rhinos.avi';
file_info = aviinfo(file_name);
my_movie = VideoReader(file_name);

%%
%my_movie2 = aviread(file_name, frame_nums);
k = 1;
%mov = struct('cdata','colormap',[]);
while hasFrame(my_movie)
    mov(k).cdata=readFrame(my_movie);
    mov(k).colormap=[];
    k = k+1;
end
%% Reproducción del video
movie(mov);

%% Extracción de frame y contaminación con ruido
primerFrame = frame2im(mov(1));
figure, imshow(primerFrame, []), title('Primer frame rino');

frameRuido = imnoise(primerFrame,'salt & pepper');

figure, imshow(frameRuido, []), title('Rino con ruido sal y pimienta');

frameRuidogaus = imnoise(primerFrame,'gaussian');
figure, imshow(frameRuidogaus, []), title('Rino con ruido gaussiano');
%% ruido

movRuidosalypimienta = addnoise(mov,'salt & pepper',[1:k]);
movie(movRuidosalypimienta);

movRuidogauss = addnoise(mov,'gaussian',[1:k]);
movie(movRuidogauss);

%% Filtro de ruido temporal

videoFiltradosyp = tempNoiseFilter(movRuidosalypimienta,20)
movie(videoFiltradosyp);

videoFiltradogauss = tempNoiseFilter(movRuidogauss,20)
movie(videoFiltradogauss);
%% Calculo el error cometido 
x = 1;
while x <115
  ruidosal(x).cdata = videoFiltradosyp(x).cdata - mov(x).cdata;
  ruidosal(x).colormap = videoFiltradosyp(x).colormap - mov(x).colormap;
  ruidogauss(x).cdata = videoFiltradogauss(x).cdata - mov(x).cdata;
  ruidogauss(x).colormap = videoFiltradogauss(x).colormap - mov(x).colormap;
  
  x = x+1;
end
%% 
movie(ruido);
movie(ruidogauss);

%%Acabar elapartado II
