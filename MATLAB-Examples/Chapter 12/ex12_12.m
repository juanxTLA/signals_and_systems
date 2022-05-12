%%
% Example 12_12 -- Elliptic and Cheby2 filters
%%
clear all; clf
ind=input('elliptic bpf (1) or cheby2 hpf (2)?  ')% Pr 11.39
%
%
clear all; clf
load clown;
A=input('filter? FIR lowpass=1, FIR highpass=2 or separable IIR=3 >>   ');
if A==1,
% nonrecursive low-pass average filter 
    h=zeros(20,20);
    for m=1:10,
        for n=1:10,
            h(m,n)=1/100;
        end
    end
elseif  A==2,
% % high-pass filter
   h=zeros(10,10); h(1,1)=1; h(1,2)=-1;h(2,1)=-1; h(2,2)=1;
else 
% non-recursive separable filter
 [b,a]=butter(3,[0.05,0.95]);
 delta=zeros(200,200);delta(1)=1;
 h1=filter(b,a,delta);
 h=h1*h1';
end
x=X;M=size(x);m=1:M(1);n=1:M(2);
y=conv2(x,h);yy=x-y(1:M(1),1:M(2));
figure(1)
subplot(221)
colormap('gray')
image(m,n,x); title('image')
subplot(222)
stem3(h); title('Impulse response')
%% fft implementation
X=fft2(x,524,524);
H=fft2(h,524,524);
Y=X.*H;
y1=real(ifft2(Y));
% magnitude response of filter
Ha=fftshift(abs(H));w1=-1:2/524:1-2/524; w2=w1;
subplot(223)
mesh(w1,w2,Ha)
xlabel('\omega_1 /\pi'), ylabel('\omega_2 /\pi')
title('Magnitude response of the filter')
Xa=fftshift(abs(X));
subplot(224)
colormap('gray')
image(m,n,y1(1:M(1),1:M(2))), title('Filtered image')

if ind==1,
[b1,a1]=ellip(10,0.1,40,[0.45 0.55]);
else
[b1,a1]=cheby2(10,40, 0.55,'high');
end
[H1,w]=freqz(b1,a1);
figure(1)
subplot(221)
zplane(b1,a1)
mag=abs(H1);
phase=unwrap(angle(H1));
subplot(222)
plot(w/pi,mag)
axis([0 1 -0.1 1.1*max(mag)])
ylabel('Magnitude')
xlabel('w/pi')
grid
thres=3*ones(1,length(w));
thres2=40*ones(1,length(w));
subplot(223)
plot(w/pi,-20*log10(mag),w/pi,thres,'r'); axis([0 1 -10  100])
hold on
plot(w/pi,thres2,'r')
hold off
ylabel('Loss(dB)'); xlabel('w/pi'); grid
subplot(224)
plot(w/pi,phase)
axis([0 1 1.1*min(phase) 1.1*max(phase)])
ylabel('Phase (rad)')
xlabel('w/pi')
grid

