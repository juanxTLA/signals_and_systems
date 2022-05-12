	%% 
	% Example 11.31---2D-DCT compression
	%%
	clear all; clf
	RGB = imread('cameraman.tif'); I = im2double(RGB);
	J = dct2(I);
	J0=J;
	J(abs(J)<0.1) = 0;
	J1=J;
	K = idct2(J);
	MM=size(J); M=MM(1);
	figure(1)
	subplot(221); imshow(I);title('Original')
	subplot(222); imshow(K); title('Compressed')
	subplot(223),contour(J0);title('DCT of original')
	subplot(224),contour(J1);title('DCT of compressed')
	% mean square error
	esq=(I-K).*(I-K); error2=sum(esq(:))/M^2 
