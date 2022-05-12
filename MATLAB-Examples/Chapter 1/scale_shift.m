	function [z3,t1,t2]=scale_shift (z,gamma,delay,T,Ts)
% perfoms scale and shift of digitized signal 
% gamma positive real with two decimal
% shf positive real
% [-T T] range of signal
% Ts sampling period
    beta1=100;alpha1=round(gamma,2)*beta1;
    g=gcd(beta1,alpha1);beta=beta1/g;alpha=alpha1/g;
    z1=interp(z,beta);z2=decimate(z1,alpha);
    t1=-T/gamma:Ts:T/gamma;
    M=length(t1);
    z3=z2(1:M);
    t2=t1+delay;
