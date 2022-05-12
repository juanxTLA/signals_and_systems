[a1,b1] = zp2tf([j*2*pi -j*2*pi]',[-1 -0.5+j*2*pi -0.5-j*2*pi],1);
[w,Hm,Ha] = freqresp_s(a1,b1,10);
figure
plot(w,Hm)

[a2,b2] = zp2tf([-1+j*2*pi -1-j*2*pi 1]',[-1 -1+j*2*pi -1-j*2*pi],1);
[w,Hm,Ha] = freqresp_s(a2,b2,10);
figure
plot(w,Hm)


[a3,b3] = zp2tf(1,[-1 -1+j*2*pi -1-j*2*pi],1);
[w,Hm,Ha] = freqresp_s(a3,b3,10);
figure
plot(w,Hm)


