%%
% Example 5.8 -- Modulation
%%
clear all;clf
syms t w 
for ind=1:2,
if ind==1.
    x=exp(-abs(t)); 
    y=x*0.5*exp(-j*10*t)+x*0.5*exp(j*10*t)
    X=fourier(x);
    Y=fourier(y);
    Xm=abs(X);Xa=atan(imag(X)/real(X));
    Ym=abs(Y); Ya=atan(imag(Y)/real(Y));
    figure(1)
else
    m=heaviside(t+5)-heaviside(t)
    m1=heaviside(t)-heaviside(t-5);
    x=(t+5)*m+m1*(-t+5);x=x/5;
    y=x*exp(-j*10*t)/2+x*exp(+j*10*t)/2;
    X=int(x*exp(-j*w*t), t,-5,5);Xm=abs(X);
    Y=int(y*exp(-j*w*t), t,-5,5);Ym=abs(Y);
    figure(2)
end
    subplot(221)
    fplot(x,[-6,6]);grid;axis([-6 6 -0.2 1.2]); title(' '); xlabel('t'); ylabel('x(t)')
    subplot(222)
    fplot(y,[-6,6]);grid;axis([-6 6 -1.2 1.2]); title(' '); xlabel('t'); ylabel('y(t)=x(t)cos(10t)')
    subplot(223)
    fplot(Xm,[-8,8]); grid; axis([-8 8 -0.1 5.5]); title(' ')
    xlabel('\Omega'); ylabel('|X(\Omega)|')
    subplot(224)
    fplot(Ym,[-20,20]); grid; axis([-20 20 -0.1 5.5]); title(' ')
    xlabel('\Omega'); ; ylabel('|Y(\Omega)|')
end