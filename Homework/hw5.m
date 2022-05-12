%3
xn = [0 1 1 1 0];
hn = [1.5 1 0.6];
n = -10:1:10;
y = conv(xn,hn)
figure
stem(y);
%1
a = [-0.2 1 0];
delta = [1 zeros(1,10)];
yn = filter(1,a,delta)
figure
stem(0:1:10,yn)
%2
filtH = filter([0 1 2 3 4 5],1,[1 0 0 0 0 0]);
figure
subplot(2,1,1)
stem(0:5,filtH)
title('Impulse response response');
subplot(2,1,2)
filtu = filter([0 1 2 3 4 5],1,ones(1,6));
stem(0:5,filtu)
title('Step response');

