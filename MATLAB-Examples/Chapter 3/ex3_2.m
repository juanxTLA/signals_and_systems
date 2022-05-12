% Example 3.2
%
% Laplace transforms of unit-step, delta and pulse
%
syms t u d p
% unit-step function
u=heaviside(t)
U=laplace(u)
% delta function
d=dirac(t)
D=laplace(d)
% pulse
p=heaviside(t)-heaviside(t-1)
P=laplace(p)