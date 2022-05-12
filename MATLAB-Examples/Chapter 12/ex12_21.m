%%
% Example 12.21 --- Averaging and Gaussian low-pass filtering
%%
clear all;clf
h1=fspecial('average',15); % averaging filter
h2=fspecial('gaussian',15,3); % Gaussian filter
h1 = h1./ sum(h1(:));
h2 = h2./ sum(h2(:));
I = imread('cameraman.tif');I=double(I);
y1=filter2(h1,I);
y2=filter2(h2,I);
figure(1)
colormap('gray'); imagesc(I,[0 255]); title('Original Image')
figure(2)
colormap('gray'); imagesc(y1,[0 255]); title('Average Filtered Image')
figure(3)
colormap('gray'); imagesc(y2,[0 255]); title('Gaussian Filtered Image')