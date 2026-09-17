# C.33 (14.26): the interpolation polynomials Q_i used for linear independence of the f(i)^k
import sympy as sp
from itertools import combinations
def test(k, R, I):
    zs = sp.symbols('z1:%d' % (k+1))
    Delta = sp.prod([( (zs[x]-zs[y])**2 - dd**2 ) for x,y in combinations(range(k),2) for dd in range(1,R+1)])
    Ck = sp.prod([ (-dd**2) for x,y in combinations(range(k),2) for dd in range(1,R+1)])
    M = len(I)
    out = []
    for i in I:
        Li = sp.prod([ (sp.Symbol('T') - j)/(i - j) for j in I if j != i])
        Qi = sp.expand(Delta/Ck * Li.subs(sp.Symbol('T'), sum(zs)/k))
        # (1) Q_i(j,...,j) = delta_ij
        vals = [sp.simplify(Qi.subs({z: jj for z in zs})) for jj in I]
        # (2) Q_i vanishes when z2 = z1 + d for 1 <= d <= R  (uses the Delta factor)
        van = all(sp.simplify(Qi.subs({zs[1]: zs[0]+dd})) == 0 for dd in range(1, R+1)) if k >= 2 else True
        # (3) degree in each variable
        deg = max(sp.degree(sp.Poly(Qi, z)) for z in zs)
        out.append((i, vals, van, deg))
    return out
for (k,R,I) in [(2,1,[0,1]), (2,2,[0,1,2]), (3,1,[0,1,2])]:
    res = test(k,R,I)
    print("k=%d R=%d I=%s :" % (k,R,I))
    for i, vals, van, deg in res:
        print("   Q_%d(j,..,j) over I = %s  vanishes on z2=z1+d: %s  max degree per variable: %s" % (i, vals, van, deg))
