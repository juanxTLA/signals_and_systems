r1 = 1
r2 = 2
c = 1
s = sym('s')


unitResponse = (r1*r2*c*s+r2+r1)/(r1*r2*c*s+r1)*1/s
st = ilaplace(unitResponse)
fplot(st,[0,15])