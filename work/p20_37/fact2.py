# 20.37: realise G = A B for chain-missing factor sizes.  A = H x_1 u ... u H x_k (right cosets), B from an exact
# cover of H\G by the k-sets {H x_i b}.  Permutations as tuples; p*q = apply p then q (GAP convention).
import sys, random, itertools, time
import networkx as nx
from pysat.solvers import Cadical153
def mul(p, q): return tuple(q[i] for i in p)
def load(fname):
    f = open(fname); n, deg = map(int, f.readline().split()); mset = list(map(int, f.readline().split()))
    ng = int(f.readline()); gens = []
    for _ in range(ng):
        l = list(map(int, f.readline().split())); l += list(range(len(l), deg)); gens.append(tuple(l))
    ns = int(f.readline()); subs = []
    for _ in range(ns):
        h, k = map(int, f.readline().split()); sg = []
        for _ in range(k):
            l = list(map(int, f.readline().split())); l += list(range(len(l), deg)); sg.append(tuple(l))
        subs.append((h, sg))
    return n, deg, mset, gens, subs
def closure(gens, deg):
    e = tuple(range(deg)); els = [e]; idx = {e: 0}; i = 0
    while i < len(els):
        for g in gens:
            x = mul(els[i], g)
            if x not in idx: idx[x] = len(els); els.append(x)
        i += 1
    return els, idx
fname = sys.argv[1]; seed = int(sys.argv[2]) if len(sys.argv) > 2 else 1; random.seed(seed)
n, deg, mset, gens, subs = load(fname)
els, idx = closure(gens, deg); assert len(els) == n
out = open(fname.replace('case_', 'sol_'), 'w')
def exact_cover_sat(m, options, limit_s=600):
    # options: list of tuples of vertices; find a subset partitioning range(m)
    byv = [[] for _ in range(m)]
    for i, t in enumerate(options):
        for v in t: byv[v].append(i + 1)
    s = Cadical153()
    for v in range(m):
        if not byv[v]: return None
        s.add_clause(byv[v])
        for x, y in itertools.combinations(byv[v], 2): s.add_clause([-x, -y])
    if s.solve():
        model = s.get_model(); return [i - 1 for i in model if i > 0 and i <= len(options)]
    return None
for a in mset:
    b = n // a; done = False
    for h, sg in sorted(subs, key=lambda t: -t[0]):
        if a % h: continue
        k = a // h
        Hels, _ = closure(sg, deg); assert len(Hels) == h
        # right cosets H g
        cosetid = {}; m = 0
        for g in els:
            if g not in cosetid:
                for x in Hels: cosetid[mul(x, g)] = m
                m += 1
        assert m == n // h
        for trial in range(30):
            xs = [els[0]] + random.sample(els[1:], k - 1)
            edges = {}
            for bb in els:
                t = tuple(sorted(cosetid[mul(x, bb)] for x in xs))
                if len(set(t)) < k: continue
                edges.setdefault(t, bb)
            options = list(edges.keys())
            sol = None
            if k == 2 and m <= 4000:
                Gr = nx.Graph(); Gr.add_nodes_from(range(m)); Gr.add_edges_from(options)
                M = nx.max_weight_matching(Gr, maxcardinality=True)
                if 2 * len(M) == m: sol = [tuple(sorted(e)) for e in M]
            else:
                r = exact_cover_sat(m, options)
                if r is not None: sol = [options[i] for i in r]
            if sol is None: continue
            B = [edges[t] for t in sol]
            A = [mul(y, x) for x in xs for y in Hels]
            prods = set(mul(x, y) for x in A for y in B)
            if len(A) == a and len(B) == b and len(prods) == n:
                print("FOUND |G|=%d a=%d b=%d via |H|=%d k=%d trial=%d" % (n, a, b, h, k, trial), flush=True)
                out.write("%d %d\n" % (a, b)); out.write(" ".join(",".join(map(str, p)) for p in A) + "\n"); out.write(" ".join(",".join(map(str, p)) for p in B) + "\n"); out.flush()
                done = True; break
            else:
                print("verification failed?!", a, h, k, len(prods), flush=True)
        if done: break
    if not done: print("NOT FOUND |G|=%d a=%d" % (n, a), flush=True)
print("FINISHED", flush=True)
