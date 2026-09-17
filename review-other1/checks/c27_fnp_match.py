# Check that the functions A,B,E,D,P used in C.27 coincide with the FNP quantities they are attributed to.
from mpmath import mp, mpf, nsum, inf
mp.dps = 30
def Uorder(m, Q):   # |GU(m,Q)|
    r = mpf(Q)**(m*(m-1)//2)
    for i in range(1, m+1): r *= (mpf(Q)**i - (-1)**i)
    return r
def GLorder(m, Q):
    r = mpf(Q)**(m*(m-1)//2)
    for i in range(1, m+1): r *= (mpf(Q)**i - 1)
    return r
def Useries(u, M=40):     # paper's U(u)
    tot = mpf(0)
    for m in range(M):
        p = mpf(1)
        for i in range(1, m+1): p *= (1 - (-u)**i)
        tot += u**(m*m)/p
    return tot
def Lseries(u, M=40):     # paper's L(u)
    tot = mpf(0)
    for m in range(M):
        p = mpf(1)
        for i in range(1, m+1): p *= (1 - u**i)
        tot += u**(m*m)/p
    return tot
def A_fnp(Q, M=40):       # FNP A_{q,d}(1) from its defining series (u = 1)
    tot = 1 - mpf(1)/(Q*(Q+1))
    for m in range(2, M): tot -= (1/(mpf(Q)*Uorder(m-1,Q)) - 1/Uorder(m,Q))
    return tot
def B_fnp(Q, M=40):
    tot = 1 + mpf(1)/(Q*(Q-1))
    for m in range(2, M): tot -= (1/(mpf(Q)*GLorder(m-1,Q)) - 1/GLorder(m,Q))
    return tot
print("%-6s %-22s %-22s %-22s %-22s" % ("Q", "FNP A_{q,d}(1)", "(1-u)U(u), u=1/Q", "FNP B_{q,d}(1)", "(1-u)L(u), u=1/Q"))
for Q in [2,3,4,5,7,8,9,11,16,25]:
    u = mpf(1)/Q
    print("%-6d %-22s %-22s %-22s %-22s" % (Q, mp.nstr(A_fnp(Q),12), mp.nstr((1-u)*Useries(u),12), mp.nstr(B_fnp(Q),12), mp.nstr((1-u)*Lseries(u),12)))
# cyclic factors: A(u) = (1+u-u^2)/(1+u) vs 1 - 1/(q^d(q^d+1)); B(u) = (1-u+u^2)/(1-u) vs 1 + 1/(q^d(q^d-1))
print("\ncyclic factors:")
for Q in [2,3,5,9]:
    u = mpf(1)/Q
    print(Q, mp.nstr((1+u-u**2)/(1+u),12), mp.nstr(1 - 1/(mpf(Q)*(Q+1)),12), "|", mp.nstr((1-u+u**2)/(1-u),12), mp.nstr(1 + 1/(mpf(Q)*(Q-1)),12))
# P(t) vs F(1) = 1 + sum 1/|Sp(2m,q)|
def Sporder(m, Q):
    r = mpf(Q)**(m*m)
    for i in range(1, m+1): r *= (mpf(Q)**(2*i) - 1)
    return r
print("\nP(t) vs 1 + sum 1/|Sp(2m,q)|:")
for Q in [2,3,5]:
    t = mpf(1)/Q
    P = mpf(1)
    for m in range(1, 20):
        p = mpf(1)
        for i in range(1, m+1): p *= (1 - t**(2*i))
        P += t**(m*(2*m+1))/p
    F = 1 + sum(1/Sporder(m,Q) for m in range(1,20))
    print(Q, mp.nstr(P,15), mp.nstr(F,15))
