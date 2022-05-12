%%
% Example 11.28
%%
% fft vs dft
clf; clear all
time=zeros(1,12-8+1); time1=zeros(1,12-8+1);
for r=8:12,
N(r)=2^r; i=r-7;
% fft elapsed time
t=tic; X1=fft(ones(1,N(r)),N(r)); time(i)=toc(t);
% dft elapsed time
t=tic; Y1=dft(ones(N(r),1),N(r)); time1(i)=toc(t);
end
% comparison of conv and fft
clear all
time1=zeros(1,10); time2=time1;
for i=1:10,
NN=1000*i; x=ones(1,NN);
% elapsed time for convolution using conv
t1=tic; y=conv(x,x); time1(i)=toc(t1);
% elapsed time for convolution using fft
x=[x zeros(1,NN)]; t2=tic; X=fft(x); X=fft(x); Y=X.*X; y=real(ifft(Y));
time2(i)=toc(t2);
end


