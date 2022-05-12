%general data
amp = 4;
freq = 200;
%signal
t = sym('t');
y = amp*exp(-2*t)*cos(8*t)*heaviside(t);
y2 = amp*exp(-4*t)*cos(8*t)*heaviside(t);
L = laplace(y)
L2 = laplace(y2)
numL=[4 8];denL=[1 4 68];
numL2=[4 16];denL2=[1 8 80];
subplot(2,2,1)
fplot(y,[-2,5]); grid
title('4exp(-2t)cos(8t)u(t)')
subplot(2,2,2)
splane(numL, denL)
subplot(2,2,3)
fplot(y2,[-2,5]); grid
title('4exp(-4t)cos(8t)u(t)')
subplot(2,2,4)
splane(numL2, denL2)



