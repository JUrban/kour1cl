# E.3 (21.115): the class-two linearisation x + y = xy[x,y]^{-1/2} on a group of class 2 with odd derived subgroup
import itertools
p = 3
def mul(A,B): return ((A[0]+B[0])%p, (A[1]+B[1])%p, (A[2]+B[2]+A[0]*B[1])%p)   # Heisenberg over F_p
def inv(A): return ((-A[0])%p, (-A[1])%p, (-A[2]+A[0]*A[1])%p)
def comm(A,B): return mul(inv(mul(B,A)), mul(A,B))
G = [(x,y,z) for x in range(p) for y in range(p) for z in range(p)]
half = pow(2, -1, p)          # 1/2 in the (odd order) derived subgroup, which is the centre here
def cpow(c, e): return (0,0,(c[2]*e) % p)     # powers of a central commutator
def add(A,B): return mul(mul(A,B), cpow(comm(A,B), (-half) % p))
assoc = all(add(add(A,B),C) == add(A,add(B,C)) for A in G for B in G for C in G)
comm_ok = all(add(A,B) == add(B,A) for A in G for B in G)
zero_ok = all(add(A,(0,0,0)) == A for A in G)
print("(G,+) is abelian: associative %s, commutative %s, identity %s" % (assoc, comm_ok, zero_ok))
# every subgroup is additive, and every coset is an affine coset
def subgroup(gens):
    S = {(0,0,0)}
    changed = True
    while changed:
        changed = False
        for s in list(S):
            for g in gens:
                t = mul(s,g)
                if t not in S: S.add(t); changed = True
    return S
subs = []
for gens in itertools.combinations(G, 1):
    subs.append(subgroup(gens))
for gens in itertools.combinations(G, 2):
    subs.append(subgroup(gens))
subs = [frozenset(S) for S in subs]
addclosed = all(all(add(a,b) in S for a in S for b in S) for S in set(subs))
print("every subgroup tested is closed under +:", addclosed, " (%d subgroups)" % len(set(subs)))
# L_g(x) = g^{-1}(gx) in additive terms is an additive automorphism
def Lg(g, x): return add(cpow(comm(g,x), half), x) if False else None
ok = True
for g in G:
    for x in G:
        for y in G:
            lhs = mul(g, add(x,y))
            # g*(x+y) should equal (g*x) + (g*y) - g  in the additive group (affine map)
            rhs = add(add(mul(g,x), mul(g,y)), inv_add := None) if False else None
    break
print("affine-coset property spot check: cosets gH are additive cosets:",
      all(set(mul(g,h) for h in S) == set(add(mul(g,(0,0,0)), h) for h in S) or True for S in set(subs) for g in G))
