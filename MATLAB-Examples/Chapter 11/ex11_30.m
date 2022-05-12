    %% 
	% Example 11.30
	%%
	clear all; clf
	RGB = imread('cameraman.tif'); i = im2double(RGB);
	h1=[1 2 1;0 0 0;-1 -2 -1];h1=h1/3; h2=h1';
	H1=fft2(h1,300,300); H2=fft2(h2,300,300);
	I=fft2(i,300,300);
	Y=(H1.*I).*H2; y=ifft2(Y);y1=y;
	y=-min(min(y))+y;y=y>1.1;
	w1=-1:2/300:1-2/300;w2=w1;
	H=H1.*H2;
	figure(1)
	colormap('gray')
	subplot(221)
	imshow(i);title('Original')
	subplot(222)
	imshow(y1);title('Filtered')
	subplot(223)
	imshow(y); title('Binarized')
	subplot(224)
	mesh(w1,w2,fftshift(abs(H)));
	title('Magnitude response of filter')
	axis([-1,1,-1,1,0,3])
	xlabel('\omega_1');ylabel('\omega_2');
	zlabel('|H(\omega_1,\omega_2)|')
