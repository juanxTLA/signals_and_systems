%
% Example 10.8
%
clear all; clf
syms z Y X H y n x
w0=2*pi/3;x1(1:14)=cos(w0*[0:13])
x=x1(1)*kroneckerDelta(n,0)
for m=2:14,
    x=x+x1(m)*kroneckerDelta(n-m+1,0)
end
X=ztrans(x)
h=[1 1 1];
H=h(1);
for m=1:2,
    H=H+h(m)/z^m;
end
H
Y=H*X
y=iztrans(Y)
y1=conv(x1,h])
n=0:15;
figure(1)
subplot(221)
stem([0:13],x1);grid;axis([0 13 -0.6 1.1])
subplot(222)
stem([0:2],h);axis([0 2 -0.6 1.1]);grid
subplot(223)
stem(n,y1);grid;axis([0 15 -0.6 1.1])