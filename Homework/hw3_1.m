s = sym('s')
Xs = 1/((s+1)^2+4)
xt = ilaplace(Xs)
yt = ilaplace(-0.1*s/(s^2+50))
fplot(yt,[0,2.5])