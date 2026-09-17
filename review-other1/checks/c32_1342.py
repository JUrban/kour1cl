# C.32 (13.42): exact check of the BCH formulas in the free nilpotent Lie algebra of rank 2, class 3,
# realised inside the free associative algebra on X,Y truncated above degree 3.
import sympy as sp
from itertools import product
from collections import defaultdict
a,b,c,d,e,A,B,C,D,E = sp.symbols('a b c d e A B C D E')
def mul(p, q):                      # p,q: dict word(str) -> coeff ; truncate above degree 3
    r = defaultdict(lambda: 0)
    for w1,c1 in p.items():
        for w2,c2 in q.items():
            if len(w1)+len(w2) <= 3: r[w1+w2] += c1*c2
    return {w: sp.expand(v) for w,v in r.items() if sp.expand(v) != 0}
def add(*ps):
    r = defaultdict(lambda: 0)
    for p in ps:
        for w,c in p.items(): r[w] += c
    return {w: sp.expand(v) for w,v in r.items() if sp.expand(v) != 0}
def smul(s,p): return {w: sp.expand(s*c) for w,c in p.items()}
def br(p,q): return add(mul(p,q), smul(-1, mul(q,p)))
one = {'': 1}; Xg = {'X': 1}; Yg = {'Y': 1}
Ug = br(Xg,Yg); Vg = br(Xg,Ug); Wg = br(Yg,Ug)
def expm(z):
    z2 = mul(z,z); z3 = mul(z2,z)
    return add(one, z, smul(sp.Rational(1,2), z2), smul(sp.Rational(1,6), z3))
def logm(g):
    z = add(g, smul(-1, one)); z2 = mul(z,z); z3 = mul(z2,z)
    return add(z, smul(sp.Rational(-1,2), z2), smul(sp.Rational(1,3), z3))
def coords(z):          # write a Lie element in the basis X,Y,U,V,W
    basis = [Xg,Yg,Ug,Vg,Wg]; syms = sp.symbols('c1:6')
    cand = add(*[smul(s,bs) for s,bs in zip(syms,basis)])
    words = set(z) | set(cand)
    eqs = [sp.Eq(sp.expand(z.get(w,0)), sp.expand(cand.get(w,0))) for w in words]
    sol = sp.solve(eqs, syms, dict=True)
    return sol[0] if sol else None
l = add(smul(a,Xg), smul(b,Yg), smul(c,Ug), smul(d,Vg), smul(e,Wg))
h = add(smul(A,Xg), smul(B,Yg), smul(C,Ug), smul(D,Vg), smul(E,Wg))
hinv = smul(-1, h)
conj = logm(mul(mul(expm(hinv), expm(l)), expm(h)))
co = coords(conj); syms = sp.symbols('c1:6')
print("l^h coordinates: X:", sp.simplify(co[syms[0]]), " Y:", sp.simplify(co[syms[1]]), " U:", sp.simplify(co[syms[2]]))
print("paper's claim (a, b, c + aB - bA):", sp.simplify(co[syms[0]]-a)==0, sp.simplify(co[syms[1]]-b)==0, sp.simplify(co[syms[2]]-(c+a*B-b*A))==0)
comm = coords(logm(mul(mul(expm(smul(-1,l)), expm(smul(-1,h))), mul(expm(l), expm(h)))))
vals = [sp.simplify(comm[s]) for s in syms]
print("[l,h] coordinates:", vals)
print("commuting criterion (aB-bA, aC-cA, bC-cB all zero):",
      sp.simplify(vals[2] - (a*B-b*A)) == 0,
      sp.factor(vals[3]), sp.factor(vals[4]))
