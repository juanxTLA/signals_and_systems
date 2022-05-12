%%
% Example 12.24 --- Circular filter design using 'fwind1'
%%
clear all; clf
% filter specifications
N=125; [f1,f2] = freqspace(N,'meshgrid');  Hd = ones(N);  r = sqrt(f1.^2 + f2.^2);
% type of filter
tf=input('type of filter, 1=lp,2=bp,3=hp >>>')
if tf==1,
    Hd(r>0.5)=0; %low-pass
elseif tf==2,
    Hd((r<0.5) | (r>0.8)) = 0; %band-pass
else        
     Hd(r<0.8)=0; %high-pass
end
% type of window
tw=input('type of window 1=hamming, 2=kaiser >>>')
if tw==1,
        h1 = fwind1(Hd,hamming(N));
else
        h1=fwind1(Hd,kaiser(N,4));
end
H=freqz2(h1,124); w1=-1:2/124:1-2/124; w2=w1;     
figure(1)
contour(f1,f2,Hd,20); grid; title('Frequency response of desired filter')
figure(2)
mesh(w1,w2,H); title('Frequency response of designed filter')
figure(3)
contour(w1,w2,H); grid; title('Contour of frequency response of designed filter')
ww=fftshift(fft2(Hd));
