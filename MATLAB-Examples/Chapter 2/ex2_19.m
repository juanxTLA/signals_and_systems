%%
% Example 2_19 -Convolution using MATLAB
%%
clear all; clf
Ts=0.01; delay=1; Tend=2.5;
t=0:Ts:Tend;
for n=1:3,
    if n==1,
x=unitstep(t,0)-unitstep(t,-delay);
h=unitstep(t,0)-unitstep(t,-2*delay);
figure(1)
    elseif n==2,
x=ramp(t,1,0)+ramp(t,-2,-1)+ramp(t,1,-2);
h=x;
figure(2)
    else
x=exp(-2*t);
h=2*exp(-10*t);
figure(3)
    end
y=Ts*conv(x,h);
t1=0:Ts:length(y)*Ts-Ts;
subplot(311)
plot(t,x); axis([0 2.5 -0.1 1.2]);grid;ylabel('x_3(t)');
subplot(312)
plot(t,h); axis([0 2.5 -0.1 2.1]);grid;ylabel('h_3(t)'); 
subplot(313)
plot(t1,y);; axis([0 5 -0.01 1.1*max(y)]);grid;ylabel('y_3(t)'); 
end