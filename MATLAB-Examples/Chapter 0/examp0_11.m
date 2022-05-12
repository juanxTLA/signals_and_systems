%%
% Example 0.11 -- Impulse, unit-step and ramp responses 
%%
clear all; clf
syms y(t)
eqn=diff(y,t,2)+5*diff(y,t)+6*y==1
Dy=diff(y,t);
cond=[y(0)==0, Dy(0)==0];
y(t)=dsolve(eqn,cond)
Dy=diff(y,t)
Iy=int(y,t)
figure(1)
subplot(311)
fplot(y,[0,5]);title('Unit-step response');grid
subplot(312)
fplot(Dy,[0,5]);title('Impulse response');grid
subplot(313)
fplot(Iy,[0,5]);title('Ramp response');grid
