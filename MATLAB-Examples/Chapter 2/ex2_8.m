%%
% Example 2.8 --- Solution of a LTV system
%%
clear all; clf
syms y(t) a(t) x(t) y1(t) x1(t)
Dy=diff(y,t); x=exp(-2*t)*heaviside(t);a=(1+exp(-0.1*t))*heaviside(t);
Dy1=diff(y1,t);
% original input and coefficient
y=dsolve(Dy+a*y == x,y(0)==0)
figure(1)
subplot(311)
fplot(x,[0,6]);grid;title('input x(t)')
subplot(312)
fplot(a,[0,6]);grid;title('coefficient a(t)')
subplot(313)
fplot(y,[0,6]);grid; title('output y(t)')
% shifted input, coefficient
a=a*heaviside(t-6);x1=exp(-2*(t-6))*heaviside(t-6);
y1=dsolve(Dy1+a*y1 == x1,y1(1)==0)
figure(2)
subplot(311)
fplot(x1,[0,12]);grid; title('shifted input x_1(t)=x(t-6)')
subplot(312)
fplot(a,[0,12]);grid;title('coefficient a(t)u(t-6)')
subplot(313)
fplot(y1,[0,12]);grid;title('ouput y_1(t)')
% comparison of solutions
figure(3)
fplot(y,[0,6]);grid
hold on
fplot(y1,[6,12]);title('y(t) vs y_1(t)')
hold off
