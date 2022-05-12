%%
% Example 4.12 --- Modulation             
%%
clear all;clf
syms t
T0=2;
m1=heaviside(t)-heaviside(t-T0/2);
x1=m1*sin(pi*t);
x2=x1*cos(20*pi*t);
[X1,w]=fourierseries(x1,T0,60);
[X2,w1]=fourierseries(x2,T0,60);
figure(1)
subplot(221)
fplot(x1,[0 T0]);grid;xlabel('t');ylabel('x_1(t)');title('x_1(t)')
subplot(223)
stem(w,abs(X1));grid;xlabel('\Omega');ylabel('|X_{1k}|')
subplot(222)
fplot(x2,[0 T0]);grid;xlabel('t');ylabel('x_2(t)');title('x_2(t)')
subplot(224)
stem(w1,abs(X2)); grid;xlabel('\Omega');ylabel('|X_{2k}|')
