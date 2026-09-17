# C.36 (19.93): the Golod-Shafarevich arithmetic
from fractions import Fraction as F
for p in [7, 11, 13]:
    t = F(2,3)
    val = 1 - 2*t + 3*t**p
    print("p=%2d : 1 - 2t + 3t^p at t=2/3 = %s = %.6f  (<0 : %s)" % (p, val, float(val), val < 0))
print("claimed bound -115/729 for p=7:", 1 - 2*F(2,3) + 3*F(2,3)**7, "=", float(1 - 2*F(2,3) + 3*F(2,3)**7))
# divergence of H(t) at t=2/3: (1-2t+3t^p) H(t)/(1-t) >= 1/(1-t) with negative left factor forces H(2/3) = infinity
print("with a negative coefficientwise factor, a convergent H(2/3) would give a negative number >= 3:",
      "consistent" )
# the counting bound: P_K(t) = prod_i (1+t^i+...+t^{(p-1)i})^K converges for 0<t<1
import math
def PK(t, K, p, N=400):
    logs = 0.0
    for i in range(1, N):
        s = sum(t**(i*j) for j in range(p))
        logs += K*math.log(s)
    return math.exp(logs)
for K in [1, 5, 20]:
    print("P_K(2/3) with p=7, K=%2d : %.4g" % (K, PK(2/3, K, 7)))
