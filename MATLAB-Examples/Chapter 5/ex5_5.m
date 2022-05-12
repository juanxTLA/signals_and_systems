%%
% Example 5.5 Fourier Transform
%%
clear all;clf
syms t w
    x=exp(-abs(t))
    X=fourier(x)
    figure(1)
    subplot(221)
    ezplot(x,[-10,10]);grid;axis([-10 10 -0.2 1.2]); title(' ');
    ylabel('x(t)'); xlabel('t (sec)')
    subplot(223)
    ezplot(sqrt((real(X))^2+(imag(X))^2),[-30,30]); grid; axis([-10 10 -0.2 2.2]);
    xlabel('\Omega'); ylabel('|X(\Omega)|'); title(' ');
    subplot(224)
    ezplot(imag(log(X)),[-30,30]); grid; title(' ');
    axis([-10 10 -1.8 1.8]); xlabel('\Omega'); ylabel('<X(\Omega)')
