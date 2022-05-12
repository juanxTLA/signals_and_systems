%
% Examples 4.8 -- Fourier series of derivative of signal
%
clear all
syms t
T0=2;
m=heaviside(t)-heaviside(t-T0/2);
m1=heaviside(t-T0/2)-heaviside(t-T0);
for ind=1:2,
if ind==1
y=(1-t)*m+(t-1)*m1;
[Y,w]= fourierseries(y,T0,20);
figure(1)
subplot(221)
fplot(y,[0 T0]);grid;title('Period');xlabel('t');ylabel('y(t)')
subplot(223)
stem(w,abs(Y));grid;xlabel('\Omega (rad/sec)');ylabel('|Y_k|')
subplot(224)
stem(w,angle(Y));grid;xlabel('\Omega (rad/sec)');ylabel('\angle{Y_k}')
else
x=diff(y,t);    
[X,w]=fourierseries(x,T0,20);
figure(2)
subplot(221)
fplot(x,[0 T0]);grid;title('Period');xlabel('t');ylabel('x(t)')
subplot(223)
stem(w,abs(X)); grid;xlabel('\Omega (rad/sec)');ylabel('|X_k|')
subplot(224)
stem(w,angle(X));grid;xlabel('\Omega (rad/sec)');ylabel('\angle{X_k}')
end
end