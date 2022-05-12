%%
% Example 0.4b --- Listening to/plotting train signal
%%
    sound(y,Fs)
    t=0:1/Fs:(length(y)-1)/Fs;
    figure(2); plot(t,y');grid  
    ylabel('y[n]');xlabel('n')