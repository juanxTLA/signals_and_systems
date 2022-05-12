%%
% Example 12.23 ---  Salt and Pepper noise reduction using median filtering
%%
clear all; clf
im1=imread('peppers.png');         % read in color image 
im2=im2double(im1);                % convert into double precision
im3=rgb2gray(im2);                 % convert color into gray level images
figure(1)
imshow(im3); title('Original image')         % show gray level image
im4=imnoise(im3,'salt & pepper', 0.3);       % add "salt and pepper" noise
figure(2)
imshow(im4); title('Noisy image')          
h=fspecial('gaussian',[5 5],1);  	  % linear filter
im5=filter2(h,im4);          		  % filtering noisy image 
figure(3)
imshow(im5); title('Filtered image with Gaussian filter')       
im9=medfilt2(im4,[5 5]);       		  % 5x5 median filtering
figure(4)
imshow(im9); title('Filtered image with median') 
