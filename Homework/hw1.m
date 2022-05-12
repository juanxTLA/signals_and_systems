%general data
amp = 2;
freq = 2;
sampling_freq = 20;
%original signal
t=sym('t');
ye=amp*exp(-t);
y=piecewise(t>=0,ye.*sin(2*pi*freq.*t), t<0, 0);
%shifting portion
time = 0:1/sampling_freq:6; %time data we need
negtime = -4:1/sampling_freq:0; %negative time portion
%funtion
env = amp.*exp(-time);
y0 = env.*sin(2*pi*freq.*time);
y1 = 0.*negtime; %constant portion
%shifting calculations
yshift = zeros(size(negtime));
y1(41:81) = y0(1:41); 
yshift(1:41) = y0(41:81);
yshift(41:81) = y0(81:121);
%portion of time we want to be ploted
shifTime = 0:1/sampling_freq:4;
%original signal with envelopes
figure(1)
fplot(y,[-4,4],'b'); grid
hold on
fplot(ye,[0,4],':r');
fplot(-ye,[0,4],':r');
%shifted signal, note the use of -negtime and -shiftTime
%to mirror the signal
figure(2)
plot(-negtime, y1, 'b', -shifTime, yshift, 'b'); grid


