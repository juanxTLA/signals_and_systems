%%
% Example 0.4c --- Using stem to plot 200 samples of train
%% 
    figure(3)
	n=100:299;
	stem(n,y(100:299)); xlabel('n');ylabel('y[n]') 
	title('Segment of train signal')
	axis([100 299 -0.5 0.5] )