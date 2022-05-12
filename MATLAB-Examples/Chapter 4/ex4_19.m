    %%
	% Examples 4.19 --Generation of half-wave rectified signals
	%%
	clear all; clf
	T0=1;N=400;omega0=2*pi;T=2;
	% trigonometric coefficients
	c=zeros(1,N); d=c;
 	X0=1/pi; c(1)=0; d(1)=0.25;
	for k=2:2:N
    	d(k)=0;
    	c(k)=1/(pi*(1-k^2));
 	end
	alpha=1;A=pi;
	[x,t]=InvFSeries(T,X0,c,d,N,alpha,A);
	figure(1)
	plot(t,x); axis([min(t) max(t) 1.1*min(x) 1.1*max(x)]);grid
	alpha=10;A=pi;
	[x,t]=InvFSeries(T,X0,c,d,N,alpha,A);
	figure(2)
	plot(t,x); axis([min(t) max(t) 1.1*min(x) 1.1*max(x)]);grid

