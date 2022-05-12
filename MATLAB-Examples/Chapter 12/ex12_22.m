%%
% Example 12.22 --- Edge Detection using Prewitt and Sobel
%%
clear all; clf
h1 =fspecial('prewit');   % Prewitt horizontal filter
h2 =fspecial('sobel');  % Sobel horizontal filter
h1 = h1./ max(h1(:));  
h2 = h2./ max(h2(:));  
I = imread('moon.tif');
y1h=filter2(h1,I); y1v=filter2(h1',I);
y2h=filter2(h2,I); y2v=filter2(h2',I);
y1=sqrt(y1h.^2+y1v.^2);
y2=sqrt(y2h.^2+y2v.^2);     
figure(1)
colormap('gray'); imagesc(I,[0 255]); title('Original Image');
figure(2)
colormap('gray');
imagesc(y1,[0 255]); title('Prewitt Filtered Image');
figure(3)
colormap('gray'); 
imagesc(y2,[0 255]); title('Sobel Filtered Image');
