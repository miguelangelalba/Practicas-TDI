
file_name = 'video.avi';
file_info = aviinfo(file_name);
my_movie = VideoReader(file_name);

%%
%my_movie2 = aviread(file_name, frame_nums);
k = 1;
mov = struct('cdata','colormap',[]);
while hasFrame(my_movie)
    mov(k).cdata=readFrame(my_movie);
    k = k+1;
end

%% Visualice 
imshow(mov(1).cdata);
for f = 1:(k-1)
    image_data(:,:,:,f) = mov(f).cdata;
    f = f+1;
end
%montage(image_data);

%%
old_img = frame2im(mov(10));
fn = fspecial('average',7);
new_img = imfilter(old_img, fn);

%% Apartado 2

anchorName = 'foreman69.Y';
targetName = 'foreman72.Y';
frameHeight = 352;
frameWidth = 288;
blockSize = [16,16];


fid = fopen(anchorName,'r');
anchorFrame = fread(fid,[frameHeight,frameWidth]);
anchorFrame = anchorFrame';
fclose(fid);fid = fopen(targetName,'r');
targetFrame = fread(fid,[frameHeight,frameWidth]);
targetFrame = targetFrame';
fclose(fid);

%% Función:
tic[predictedFrame, mv_d, mv_o] = ...
ebma(targetFrame, anchorFrame, blockSize);
time_ebma = toc