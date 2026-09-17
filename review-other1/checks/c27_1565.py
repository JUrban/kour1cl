# C.27 (15.65): numerical facts used in the analytic argument
from fractions import Fraction as Fr
def a(m, r):
    p = Fr(1)
    for i in range(1, m+1): p *= (1 - r**i)
    return r**(m*m) / p
r = Fr(3,5)
s = 1 - a(1,r) + a(2,r) - a(3,r) + a(4,r)
print("1-a1+a2-a3+a4 at r=3/5:", s, "=", float(s), " matches paper:", s == Fr(-1128797279, 26656000000))
# monotonic decrease of a_m(r) for r<=3/5, ratio bound r^3/(1-r^2) at m>=1? check ratio a_{m+1}/a_m = r^(2m+1)/(1-r^(m+1))
for rr in [Fr(1,2), Fr(3,5), Fr(3,7), Fr(13,20)]:
    print("r=",rr," r^3/(1-r^2)=", float(rr**3/(1-rr**2)), " ratios a_{m+1}/a_m m=1..4:", [float(a(m+1,rr)/a(m,rr)) for m in range(1,5)])
print("sum_{m>=1} a_m(3/7) partial (m<=30):", float(sum(a(m,Fr(3,7)) for m in range(1,31))), " vs 210/253 =", 210/253)
# U(-r) = sum (-1)^m a_m(r) ... careful: denominators prod(1-(-u)^i) at u=-r give prod(1-r^i); u^(m^2) = (-r)^(m^2) = (-1)^m r^(m^2)
import mpmath
mpmath.mp.dps = 30
def U(u, M=60):
    tot = mpmath.mpf(0)
    for m in range(M):
        p = mpmath.mpf(1)
        for i in range(1,m+1): p *= (1 - (-u)**i)
        tot += u**(m*m)/p
    return tot
def L(u, M=60):
    tot = mpmath.mpf(0)
    for m in range(M):
        p = mpmath.mpf(1)
        for i in range(1,m+1): p *= (1 - u**i)
        tot += u**(m*m)/p
    return tot
print("U(-1/2) =", U(mpmath.mpf(-0.5)), " (paper: >= 9/56 =", 9/56, ")")
print("U(-3/5) =", U(mpmath.mpf(-0.6)))
z = mpmath.findroot(lambda t: U(t), -0.55)
print("root of U in (-3/5,-1/2):", z)
print("L(-13/20) =", L(mpmath.mpf(-0.65)), " lower bound 1 - r/(1+r) =", 1-0.65/1.65)
# check nonvanishing of U, L on |u| <= 3/7 numerically on a circle grid
mn = min(abs(U(mpmath.mpf(3)/7*mpmath.exp(2j*mpmath.pi*k/400))) for k in range(400))
mnL = min(abs(L(mpmath.mpf(3)/7*mpmath.exp(2j*mpmath.pi*k/400))) for k in range(400))
print("min |U| on |u|=3/7:", mn, "  min |L| on |u|=3/7:", mnL)
# A(u) = (1+u-u^2)/(1+u) first zero alpha=(1-sqrt5)/2 ; t^{2d}/(1+t^d) bound
print("(3/4)^4/(1-(3/4)^2) =", Fr(3,4)**4/(1-Fr(3,4)**2))
