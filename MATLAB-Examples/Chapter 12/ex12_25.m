%%
% Example 12.25 ---  Design of bank of filter with separable filters
%%
% design of separable filters and filtering 
clear all; clf
for in=1:3,
	I = imread('cameraman.tif');I=double(I);
	figure(1)
	colormap('gray'); imagesc(I,[0 255]); title('Original Image')
	if(in==1)
	lp = designfilt('lowpassfir', 'PassbandFrequency', 0.1,...
               'StopbandFrequency', 0.12, 'PassbandRipple',1, ...
              'StopbandAttenuation',60, 'DesignMethod', 'equiripple');
	fvtool(lp)
	h1=lp.Coefficients;
	h1=h1'*h1;
	figure(2)
	H1=fftshift(abs(fft2(h1,124,124)));
	contour(H1,10)
	y1=filter2(h1,I);
	figure(3)
	colormap('gray'); imagesc(y1,[0 255]); title('Low-pass Image')
	elseif(in==2)
	bp=designfilt('bandpassfir', 'PassbandFrequency1',0.13,...
               'StopbandFrequency1',0.11,'PassbandFrequency2', 0.27,...
               'StopbandFrequency2',0.29, 'PassbandRipple',1, ...
              'StopbandAttenuation1',60, 'DesignMethod', 'equiripple');
	fvtool(bp)
	h2=bp.Coefficients;
	h2=h2'*h2;
	figure(4)
	H2=fftshift(abs(fft2(h2,124,124)));
	contour(H2,20)
	y2=filter2(h2,I);
	figure(5)
	colormap('gray'); imagesc(y2,[0 255]); title('Band-pass Image')
	else
	hp= designfilt('highpassfir', 'PassbandFrequency', 0.30,...
              'StopbandFrequency', 0.28, 'PassbandRipple',1, ...
               'StopbandAttenuation',60, 'DesignMethod', 'equiripple');
	fvtool(hp)
	h3=hp.Coefficients;
	h3=h3'*h3;
       figure(6)
       H3=fftshift(abs(fft2(h3,124,124)));
       mesh(H3)
	y3=filter2(h3,I);
	figure(7)
	colormap('gray'); imagesc(y3,[0 255]); title('high-pass Image')
	end
end
% reconstructed image and magnitude response of bank of filters
figure(8)
colormap('gray'); imagesc(y1+y2+y3,[0 255]); title('reconstructed Image')
figure(9)
contour(H1+H2+H3)