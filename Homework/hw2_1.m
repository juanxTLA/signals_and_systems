%general data
amp = 2;
freq = 200;
sampling_freq = 11025;
%signal
t=0:1/sampling_freq:6;
y = amp.*exp(-t).*sin(2*pi*freq.*t);
y2 = 0.4*amp.*exp(-(t-0.1)).*sin(2*pi*freq.*(t-0.1));
y3 = 0.2*amp.*exp(-(t-0.4)).*sin(2*pi*freq.*(t-0.4));

ysound = y + y2 + y3;

%sound(y)
%sound(ysound)

subplot(2,1,1)
plot(y)
title("x(t)")
subplot(2,1,2)
plot(ysound)
title('y(t)')

o = sym('o')
t = sym('t')
l = sym('l')
j = sym('j')

L = laplace(exp(-j*(o*t+l))*heaviside(t))
L2 = laplace(exp(j*(o*t+l))*heaviside(t))


