function [x,t]=InvFseries(T,X0,c,d,N,alpha,A)
% generates periodic signals in [-T,T] from dc X0 and N Fourier 
% coefficients c,d, amplitude scale A and time scale alpha 
Ts=0.0001; t=-T:Ts:T-Ts;omega0=2*pi;
x=X0*ones(1,length(t));
for k=1:N,
    x=x+2*d(k)*sin(omega0*k*alpha*t)+2*+c(k)*cos(omega0*k*alpha*t);
    
end
x=A*x;