% Examples 3.18, 3.19 and 3.21
%
% Inverse Laplace transform of 
% example 3.18: X(s)=(2s+3)/(s^2+2s+4) 
% example 3.19: X(s)=4/(s^3+4s^2+4s)
% example 3.21: X(s)=(3s^2+2s-5)/(s^3+6s^2+11s+6) 
%
% To get results in each of the three examples, input the number of the 
% example
%
clear all; clf
number=input(' example 3.(18,19 or 21?)  ')
syms s t w
% numerators and denominators
if number==18,
     num=[0 2 3]; den=[1 2 4]; % example 3.18
    elseif number==19,
   num=[0 0 0 4]; den=[1 4 4 0]; % example 3.19

else
    num=[0 3 2 -5]; den=[1 6 11 6]; % example  3.17
end

figure(1)
subplot(121)
pfeLaplace(num,den);

% inverse Laplace
disp('>>>>> Inverse Laplace <<<<<')

if number==18,  
    x=ilaplace((2*s+3)/(s^2+2*s+4)) % example 3.18
elseif number==19,
    x=ilaplace( 4/(s^3+4*s^2+4*s)) % example 3.19
else
    x=ilaplace((3*s^2+2*s-5)/(s^3+6*s^2+11*s+6)) % example  3.21
end
  subplot(122)
  fplot(x*heaviside(t),[-1,12]); title('x(t)');grid
