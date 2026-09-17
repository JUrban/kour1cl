# Check of the 19 printed carpet derivations (Appendix F) against absolute Chevalley constants computed in GAP.
# Coordinates (m,n) = m a + n b, a short (B2, G2).  Constants file rows: [coords r, coords s, [i,j], coords target, |C|]
import ast, sys, math, itertools
def load(fn, swap):
    txt = open(fn).read().replace('\n',' ')
    rows = ast.literal_eval(txt.strip())
    tab = {}
    for r,s,ij,tgt,c in rows:
        if swap: r,s,tgt = (r[1],r[0]),(s[1],s[0]),(tgt[1],tgt[0])
        tab[(tuple(r),tuple(s),tuple(ij))] = (tuple(tgt), c)
    return tab
def check(name, tab, p, req, inits, lines):
    # inits: {var: root}; lines: list of (label, coef, exps(tuple over vars), root, apps) ; apps list of (c, k, pk, l, pl)
    vals = {}
    ok = True
    for lab, coef, exps, root, apps in lines:
        if apps == 'init':
            vals[lab] = (coef, exps, root); continue
        results = []
        for (c, k, pk, l, pl) in apps:
            ck, ek, rk = vals[k]; cl, el, rl = vals[l]
            tgt = (pk*rk[0]+pl*rl[0], pk*rk[1]+pl*rl[1])
            cands = []
            if (rk, rl, (pk,pl)) in tab: cands.append(tab[(rk,rl,(pk,pl))])
            if (rl, rk, (pl,pk)) in tab: cands.append(tab[(rl,rk,(pl,pk))])
            valid = [cc for (t,cc) in cands if t == tgt and cc != 0 and c % cc == 0]
            if not valid:
                print(name, lab, "INVALID application", (c,k,pk,l,pl), "constants available:", cands); ok = False
            value = c * ck**pk * cl**pl
            mono = tuple(pk*a + pl*b for a,b in zip(ek, el))
            if mono != exps or tgt != root:
                print(name, lab, "monomial/root mismatch", mono, exps, tgt, root); ok = False
            results.append(value)
        g = 0
        for v in results: g = math.gcd(g, v)
        if coef % g != 0:
            print(name, lab, "coefficient", coef, "not a multiple of gcd", g, results); ok = False
        vals[lab] = (coef, exps, root)
    # final line must be x^2 * (request monomial) with coefficient dividing requested
    lab, coef, exps, root, apps = lines[-1]
    if root != p or req % coef != 0:
        print(name, "final line root/coef problem", root, coef, req); ok = False
    print(name, "OK" if ok else "FAILED")
    return ok

# ---- transcription of Appendix F (lines: label, coefficient, exponents of (X1,X2,X3), root, applications) ----
I='init'
D = {}
D['A2 req3'] = ('A', (1,1), 1, [
 ('z1',1,(1,0,0),(1,1),I), ('z2',1,(0,1,0),(-1,0),I), ('z3',1,(1,1,0),(0,1),[(1,'z2',1,'z1',1)]),
 ('z4',1,(0,0,1),(0,-1),I), ('z5',1,(1,0,1),(1,0),[(1,'z4',1,'z1',1)]), ('z6',1,(2,1,1),(1,1),[(1,'z5',1,'z3',1)]) ])
D['B2 req6'] = ('B', (1,1), 1, [
 ('z1',1,(1,0,0),(1,0),I), ('z2',1,(0,1,0),(1,1),I), ('z3',1,(0,0,1),(-2,-1),I),
 ('z4',1,(0,2,1),(0,1),[(1,'z3',1,'z2',2)]), ('z5',1,(1,2,1),(1,1),[(1,'z4',1,'z1',1)]) ])
D['B2 req7'] = ('B', (1,1), 1, [
 ('z1',1,(1,0,0),(1,1),I), ('z2',1,(0,1,0),(0,-1),I), ('z3',1,(2,1,0),(2,1),[(1,'z2',1,'z1',2)]),
 ('z4',1,(0,0,1),(-1,0),I), ('z5',1,(2,1,1),(1,1),[(1,'z4',1,'z3',1)]) ])
D['B2 req8'] = ('B', (2,1), 1, [
 ('z1',1,(1,0,0),(0,1),I), ('z2',1,(0,1,0),(2,1),I), ('z3',1,(0,0,1),(-1,-1),I),
 ('z4',1,(0,1,1),(1,0),[(1,'z3',1,'z2',1)]), ('z5',1,(1,2,2),(2,1),[(1,'z1',1,'z4',2)]) ])
D['B2 req9'] = ('B', (2,1), 1, [
 ('z1',1,(1,0,0),(2,1),I), ('z2',1,(0,1,0),(0,-1),I), ('z3',1,(0,0,1),(-1,0),I),
 ('z4',1,(1,0,1),(1,1),[(1,'z3',1,'z1',1)]), ('z5',1,(2,1,2),(2,1),[(1,'z2',1,'z4',2)]) ])
D['B2 req10'] = ('B', (2,1), 2, [
 ('z1',1,(1,0,0),(2,1),I), ('z2',1,(0,1,0),(-1,0),I), ('z3',1,(1,1,0),(1,1),[(1,'z2',1,'z1',1)]),
 ('z4',1,(0,0,1),(-1,-1),I), ('z5',1,(1,0,1),(1,0),[(1,'z4',1,'z1',1)]), ('z6',2,(2,1,1),(2,1),[(2,'z5',1,'z3',1)]) ])
D['G2 req19'] = ('G', (2,1), 1, [
 ('z1',1,(1,0,0),(1,0),I), ('z2',1,(0,1,0),(2,1),I), ('z3',3,(1,1,0),(3,1),[(3,'z2',1,'z1',1)]),
 ('z4',1,(0,0,1),(-3,-1),I), ('z5',1,(0,1,1),(-1,0),[(1,'z4',1,'z2',1)]), ('z6',1,(0,2,1),(1,1),[(1,'z4',1,'z2',2)]),
 ('z7',1,(1,2,1),(2,1),[(1,'z5',1,'z3',1),(2,'z6',1,'z1',1)]) ])
D['G2 req20'] = ('G', (2,1), 1, [
 ('z1',1,(1,0,0),(0,1),I), ('z2',1,(0,1,0),(2,1),I), ('z3',1,(0,0,1),(-1,-1),I),
 ('z4',1,(1,0,1),(-1,0),[(1,'z3',1,'z1',1)]), ('z5',2,(0,1,1),(1,0),[(2,'z3',1,'z2',1)]),
 ('z6',2,(1,1,1),(1,1),[(2,'z2',1,'z4',1)]), ('z7',3,(0,2,1),(3,1),[(3,'z3',1,'z2',2)]),
 ('z8',3,(1,2,1),(3,2),[(1,'z7',1,'z1',1)]), ('z9',1,(1,2,2),(2,1),[(1,'z3',1,'z8',1),(2,'z5',1,'z6',1)]) ])
D['G2 req21'] = ('G', (2,1), 1, [
 ('z1',1,(1,0,0),(1,1),I), ('z2',1,(0,1,0),(2,1),I), ('z3',3,(1,1,0),(3,2),[(3,'z2',1,'z1',1)]),
 ('z4',1,(0,0,1),(-3,-2),I), ('z5',1,(0,1,1),(-1,-1),[(1,'z4',1,'z2',1)]), ('z6',1,(0,2,1),(1,0),[(1,'z4',1,'z2',2)]),
 ('z7',1,(1,2,1),(2,1),[(1,'z5',1,'z3',1),(2,'z6',1,'z1',1)]) ])
D['G2 req22'] = ('G', (2,1), 2, [
 ('z1',1,(1,0,0),(2,1),I), ('z2',1,(0,1,0),(-1,0),I), ('z3',2,(1,1,0),(1,1),[(2,'z2',1,'z1',1)]),
 ('z4',3,(2,1,0),(3,2),[(3,'z2',1,'z1',2)]), ('z5',1,(0,0,1),(-1,-1),I), ('z6',2,(1,0,1),(1,0),[(2,'z5',1,'z1',1)]),
 ('z7',1,(2,1,1),(2,1),[(1,'z5',1,'z4',1),(2,'z6',1,'z3',1)]) ])
D['G2 req23'] = ('G', (2,1), 1, [
 ('z1',1,(1,0,0),(2,1),I), ('z2',1,(0,1,0),(-1,0),I), ('z3',2,(1,1,0),(1,1),[(2,'z2',1,'z1',1)]),
 ('z4',3,(2,1,0),(3,2),[(3,'z2',1,'z1',2)]), ('z5',1,(0,0,1),(0,-1),I), ('z6',2,(1,1,1),(1,0),[(1,'z5',1,'z3',1)]),
 ('z7',3,(2,1,1),(3,1),[(1,'z5',1,'z4',1)]), ('z8',1,(2,2,1),(2,1),[(1,'z2',1,'z7',1),(2,'z3',1,'z6',1)]) ])
D['G2 req32'] = ('G', (3,2), 3, [
 ('z1',1,(1,0,0),(1,0),I), ('z2',1,(0,1,0),(3,2),I), ('z3',1,(0,0,1),(-2,-1),I),
 ('z4',1,(0,1,1),(1,1),[(1,'z3',1,'z2',1)]), ('z5',3,(1,2,2),(3,2),[(3,'z1',1,'z4',2)]) ])
D['G2 req33'] = ('G', (3,2), 1, [
 ('z1',1,(1,0,0),(1,0),I), ('z2',1,(0,1,0),(3,2),I), ('z3',1,(0,0,1),(-3,-1),I),
 ('z4',1,(3,0,1),(0,-1),[(1,'z3',1,'z1',3)]), ('z5',1,(0,1,1),(0,1),[(1,'z3',1,'z2',1)]),
 ('z6',1,(3,1,1),(3,1),[(1,'z2',1,'z4',1)]), ('z7',1,(3,2,2),(3,2),[(1,'z5',1,'z6',1)]) ])
D['G2 req34'] = ('G', (3,2), 1, [
 ('z1',1,(1,0,0),(0,1),I), ('z2',1,(0,1,0),(3,2),I), ('z3',1,(0,0,1),(-1,-1),I),
 ('z4',1,(0,1,3),(0,-1),[(1,'z2',1,'z3',3)]), ('z5',1,(0,2,3),(3,1),[(1,'z2',1,'z4',1)]),
 ('z6',1,(1,2,3),(3,2),[(1,'z5',1,'z1',1)]) ])
D['G2 req35'] = ('G', (3,2), 1, [
 ('z1',1,(1,0,0),(3,1),I), ('z2',1,(0,1,0),(3,2),I), ('z3',1,(0,0,1),(-2,-1),I),
 ('z4',1,(0,1,3),(-3,-1),[(1,'z2',1,'z3',3)]), ('z5',1,(0,2,3),(0,1),[(1,'z2',1,'z4',1)]),
 ('z6',1,(1,2,3),(3,2),[(1,'z5',1,'z1',1)]) ])
D['G2 req36'] = ('G', (3,2), 3, [
 ('z1',1,(1,0,0),(3,2),I), ('z2',1,(0,1,0),(-1,0),I), ('z3',1,(0,0,1),(-1,-1),I),
 ('z4',1,(1,0,1),(2,1),[(1,'z3',1,'z1',1)]), ('z5',3,(2,1,2),(3,2),[(3,'z2',1,'z4',2)]) ])
D['G2 req37'] = ('G', (3,2), 1, [
 ('z1',1,(1,0,0),(3,2),I), ('z2',1,(0,1,0),(-1,0),I), ('z3',1,(0,0,1),(0,-1),I),
 ('z4',1,(1,0,1),(3,1),[(1,'z3',1,'z1',1)]), ('z5',1,(0,3,1),(-3,-1),[(1,'z3',1,'z2',3)]),
 ('z6',1,(1,3,1),(0,1),[(1,'z5',1,'z1',1)]), ('z7',1,(2,3,2),(3,2),[(1,'z4',1,'z6',1)]) ])
D['G2 req38'] = ('G', (3,2), 1, [
 ('z1',1,(1,0,0),(3,2),I), ('z2',1,(0,1,0),(0,-1),I), ('z3',1,(1,1,0),(3,1),[(1,'z2',1,'z1',1)]),
 ('z4',1,(0,0,1),(-3,-1),I), ('z5',1,(1,0,1),(0,1),[(1,'z4',1,'z1',1)]), ('z6',1,(2,1,1),(3,2),[(1,'z5',1,'z3',1)]) ])
D['G2 req39'] = ('G', (3,2), 3, [
 ('z1',1,(1,0,0),(3,2),I), ('z2',1,(0,1,0),(-1,-1),I), ('z3',1,(1,1,0),(2,1),[(1,'z2',1,'z1',1)]),
 ('z4',1,(0,0,1),(-2,-1),I), ('z5',1,(1,0,1),(1,1),[(1,'z4',1,'z1',1)]), ('z6',3,(2,1,1),(3,2),[(3,'z5',1,'z3',1)]) ])

# ---- driver ----
if __name__ == '__main__':
    swaps = {'A': False, 'B': ('--swapB' in sys.argv), 'G': ('--swapG' in sys.argv)}
    tabs = {t: load('chev_%s2.txt' % t, swaps[t]) for t in 'ABG'}
    # sanity: absolute constants depend only on (|r|^2,|s|^2,<r,s>,i,j)?  (Weyl-invariance of the absolute rules)
    allok = True
    for name, (ty, p, req, lines) in D.items():
        allok &= check(name, tabs[ty], p, req, None, lines)
    # coverage of requests for the displayed destination roots: all (r,s,i,j) with i r + j s = -p, gcd-combined
    for name, (ty, p, req, lines) in D.items():
        tab = tabs[ty]
        mp = (-p[0], -p[1])
        reqs = {}
        for (r,s,ij),(tgt,c) in tab.items():
            if tgt == mp:
                key = frozenset([(r, ij[0]), (s, ij[1])])
                reqs[key] = math.gcd(reqs.get(key, 0), c)
        # the request of this derivation: initial variables other than x
        inits = [(l[3], l[2]) for l in lines if l[4] == 'init']
        final_exps = lines[-1][2]
        xs = [k for k,(root,e) in enumerate(inits) if root == p]
        found = False
        for xk in xs:
            others = [(inits[k][0], final_exps[k] - (2 if k == xk else 0)) for k in range(len(inits)) if not (k == xk)]
            if final_exps[xk] != 2: continue
            key = frozenset(others)
            if key in reqs:
                found = True
                print("  %s: request %s has combined constant %d, printed requested coefficient %d -> %s" % (name, sorted(others), reqs[key], req, "match" if reqs[key] == req else "MISMATCH"))
        if not found: print("  %s: request not found among computed requests" % name); allok = False
    print("ALL OK" if allok else "SOME FAILURES")
    for ty, p in [('A',(1,1)),('B',(1,1)),('B',(2,1)),('G',(2,1)),('G',(3,2))]:
        mp = (-p[0], -p[1]); reqs = {}
        for (r,s,ij),(tgt,c) in tabs[ty].items():
            if tgt == mp:
                key = frozenset([(r, ij[0]), (s, ij[1])]); reqs[key] = math.gcd(reqs.get(key, 0), c)
        print("type %s destination %s: %d distinct requests (all requests for -p):" % (ty, p, len(reqs)), sorted([sorted(k) for k in reqs]))
