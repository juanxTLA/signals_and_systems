%% 
% Example 0.8 -- Integration of sinc squared
%%
clf; clear all
% symbolic
  syms t z
  for k=1:10,
      z=int(sinc(t)^2,t,0,k);   % integral of sinc^2 from 0 to k
      zz(k)=subs(2*z);          % substitution to numeric value zz
  end
% numeric
  t1=linspace(-4, 4);       % 100 equally spaced points in [-4,4]
  y=sinc(t1).^2;            % numeric definition of the squared sinc function
  
  n=1:10;
  figure(1)
  subplot(211)
  plot(t1,y);grid; title('y(t)=sinc^2(t)');
  xlabel('t')
  subplot(212)
  stem(n(1:10),zz(1:10)); hold on
  plot(n(1:10),zz(1:10),'r');grid;title('\int y(\tau) d\tau'); hold off
  xlabel('k')
  