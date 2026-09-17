# C.26 (10.32): the Chebyshev-function inequalities used for the prime in (3n/8+1, n/2]
from sympy import primerange
import math
def theta(x):
    x = math.floor(x)
    return sum(math.log(p) for p in primerange(2, x+1))
bad = 0
for n in [1126, 1200, 1500, 2000, 5000, 10000, 50000]:
    lhs = theta(n/2) - theta(3*n/8 + 1)
    print("n=%6d : theta(n/2)-theta(3n/8+1) = %10.3f   n/16 = %10.3f   ok: %s" % (n, lhs, n/16, lhs > n/16))
    if lhs <= n/16: bad += 1
# the two Rosser-Schoenfeld inputs
for x in [563, 1000, 5000]:
    print("theta(%d) = %.3f  vs  x(1 - 1/(2 log x)) = %.3f  ok: %s" % (x, theta(x), x*(1-1/(2*math.log(x))), theta(x) > x*(1-1/(2*math.log(x)))))
for y in [10, 100, 1000, 10000, 100000]:
    print("theta(%d) = %.3f  <  1.01624 y = %.3f : %s" % (y, theta(y), 1.01624*y, theta(y) < 1.01624*y))
# the paper's derivation: 29n/384 - ... > n/16 ?
print("29/384 =", 29/384, " 1/16 =", 1/16, " difference =", 29/384 - 1/16)
print("with the RS bounds: n/2*(1-1/(2 log(n/2))) - 1.01624*(3n/8+1) at n=1126:",
      (1126/2)*(1-1/(2*math.log(1126/2))) - 1.01624*(3*1126/8+1), " vs n/16 =", 1126/16)
print("violations:", bad)
