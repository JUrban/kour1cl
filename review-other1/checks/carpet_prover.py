# Independent saturation prover for the carpet inclusions (5) [19.62] and (6) [19.61, Lemma C.13]
# Calculus: initial variables lie in A at given roots; a Chevalley rule applied to nodes y (root r1) and w (root r2)
# with exponents (i,j) gives C * y^i w^j in B at root i r1 + j r2; equal monomials at equal roots combine by gcd.
import ast, sys, math, itertools
from math import comb
def load(fn, swap):
    rows = ast.literal_eval(open(fn).read().replace('\n',' ').strip())
    tab = {}
    for r,s,ij,tgt,c in rows:
        if swap: r,s,tgt = (r[1],r[0]),(s[1],s[0]),(tgt[1],tgt[0])
        tab[(tuple(r),tuple(s),tuple(ij))] = (tuple(tgt), c)
    return tab
def prove(tab, var_roots, target_exps, target_root, need):
    nv = len(var_roots)
    bound = target_exps
    A = {}   # initial: (exps, root) -> 1
    for k,r in enumerate(var_roots):
        e = tuple(1 if m == k else 0 for m in range(nv))
        if all(e[m] <= bound[m] for m in range(nv)): A[(e, r)] = 1
    B = {}
    rules_by_pair = {}
    for (r,s,ij),(t,c) in tab.items(): rules_by_pair.setdefault((r,s), []).append((ij,t,c))
    changed = True
    while changed:
        changed = False
        nodes = list(A.items()) + list(B.items())
        for (e1,r1),c1 in nodes:
            for (e2,r2),c2 in nodes:
                for (i,j),t,c in rules_by_pair.get((r1,r2), []):
                    e = tuple(i*a + j*b for a,b in zip(e1,e2))
                    if any(e[m] > bound[m] for m in range(nv)): continue
                    val = c * c1**i * c2**j
                    old = B.get((e,t))
                    new = val if old is None else math.gcd(old, val)
                    if new != old:
                        B[(e,t)] = new; changed = True
    got = B.get((tuple(target_exps), target_root))
    return got is not None and need % got == 0, got
def roots_of(tab):
    return sorted(set(k[0] for k in tab) | set(k[1] for k in tab))
if __name__ == '__main__':
    swaps = {'A': False, 'B': True, 'G': False}
    total5 = total6 = fail = 0
    for ty in 'ABG':
        tab = load('chev_%s2.txt' % ty, swaps[ty])
        roots = roots_of(tab)
        # (5): for every root p, every request at -p
        n5 = 0; f5 = 0
        for p in roots:
            mp = (-p[0], -p[1]); reqs = {}
            for (r,s,ij),(t,c) in tab.items():
                if t == mp:
                    key = tuple(sorted([(r, ij[0]), (s, ij[1])])); reqs[key] = math.gcd(reqs.get(key, 0), c)
            for key, c in reqs.items():
                (r,i),(s,j) = key
                ok, got = prove(tab, [p, r, s], (2, i, j), p, c)
                n5 += 1
                if not ok: f5 += 1; print("(5) FAIL", ty, p, key, c, got)
        # (6): for every ordered rule (r,s,i,j) with constant c, both inputs substituted by x + n a^2 b
        reqs6 = {}
        for (r,s,(i,j)),(t,c) in tab.items():
            for k in range(1, i+1):   # first input: variables x,a in A_r, b in A_-r, u in A_s
                key = ('first', r, s, t, (i-k, 2*k, k, j)); reqs6[key] = math.gcd(reqs6.get(key, 0), c*comb(i,k))
            for k in range(1, j+1):   # second input: x in A_r, u,a in A_s, b in A_-s
                key = ('second', r, s, t, (i, j-k, 2*k, k)); reqs6[key] = math.gcd(reqs6.get(key, 0), c*comb(j,k))
        # merge coincident requests: same multiset of (variable root, exponent) and same target root
        merged = {}
        for (kind, r, s, t, ex), c in reqs6.items():
            if kind == 'first':
                vr = [r, r, (-r[0],-r[1]), s]
            else:
                vr = [r, s, s, (-s[0],-s[1])]
            sig = (t, tuple(sorted((vr[m], ex[m]) for m in range(4) if ex[m] > 0)))
            merged[sig] = math.gcd(merged.get(sig, 0), c)
        n6 = 0; f6 = 0
        for (t, items), c in merged.items():
            vr = [it[0] for it in items]; ex = tuple(it[1] for it in items)
            ok, got = prove(tab, vr, ex, t, c)
            n6 += 1
            if not ok: f6 += 1; print("(6) FAIL", ty, t, items, c, got)
        print("type %s2: (5) requests %d, failures %d;  (6) raw requests %d, merged %d, failures %d" % (ty, n5, f5, len(reqs6), n6, f6))
        total5 += n5; total6 += n6; fail += f5 + f6
    print("TOTAL (5) %d, (6) %d, failures %d" % (total5, total6, fail))
