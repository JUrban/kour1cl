# 20.37: realise G = A B for residual factor sizes.  Try size a and size n/a (by inversion), all subgroups H (largest
# first) dividing the size, A = H x_1 u ... u H x_k, exact cover of H\G by {H x_i b} via DLX (k>=3) / matching (k=2).
import sys, random, subprocess, time
import networkx as nx
def mul(p, q): return tuple(q[i] for i in p)
def inv(p):
    r = [0]*len(p)
    for i, j in enumerate(p): r[j] = i
    return tuple(r)
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
nodelimit = int(sys.argv[3]) if len(sys.argv) > 3 else 3000000
n, deg, mset, gens, subs = load(fname)
els, idx = closure(gens, deg); assert len(els) == n
solname = fname.replace('case_', 'sol_')
try: donea = set(int(l.split()[0]) for i, l in enumerate(open(solname)) if i % 3 == 0 and l.strip())
except FileNotFoundError: donea = set()
out = open(solname, 'a')
cosetcache = {}
def cosets(h, sg):
    if h in cosetcache and cosetcache[h][0] == sg: return cosetcache[h][1], cosetcache[h][2]
    Hels, _ = closure(sg, deg); cosetid = {}; m = 0
    for g in els:
        if g not in cosetid:
            for x in Hels: cosetid[mul(x, g)] = m
            m += 1
    cosetcache[h] = (sg, Hels, cosetid); return Hels, cosetid
def attempt(size, h, sg, trials):
    k = size // h; Hels, cosetid = cosets(h, sg); m = n // h
    for trial in range(trials):
        xs = [els[0]] + random.sample(els[1:], k - 1)
        edges = {}
        for bb in els:
            t = tuple(sorted(cosetid[mul(x, bb)] for x in xs))
            if len(set(t)) < k: continue
            edges.setdefault(t, bb)
        options = list(edges.keys())
        sol = None
        if k == 2 and m <= 6000:
            Gr = nx.Graph(); Gr.add_nodes_from(range(m)); Gr.add_edges_from(options)
            M = nx.max_weight_matching(Gr, maxcardinality=True)
            if 2 * len(M) == m: sol = [tuple(sorted(e)) for e in M]
        else:
            inp = "%d\n" % m + "".join("%d %s\n" % (k, " ".join(map(str, t))) for t in options)
            r = subprocess.run(["./dlx", str(nodelimit), str(random.randrange(1 << 30))], input=inp, capture_output=True, text=True, timeout=3600)
            line = r.stdout.strip()
            if not line.startswith("NONE"): sol = [options[int(i)] for i in line.split()]
        if sol is None: continue
        B = [edges[t] for t in sol]; A = [mul(y, x) for x in xs for y in Hels]
        prods = set(mul(x, y) for x in A for y in B)
        if len(A) == size and len(B) == n // size and len(prods) == n: return A, B, k, trial
        print("verification failed?!", size, h, k, flush=True)
    return None
for a in mset:
    if a in donea: print("already solved a=%d" % a, flush=True); continue
    found = None
    for size in [a, n // a]:
        cands = [(h, sg) for h, sg in subs if size % h == 0 and h < size]
        cands.sort(key=lambda t: -t[0])
        for h, sg in cands:
            k = size // h
            if k > 40: continue
            res = attempt(size, h, sg, 6 if k > 2 else 20)
            if res:
                A, B, k, trial = res
                if size != a: A, B = [inv(b) for b in B], [inv(x) for x in A]   # G = B^-1 A^-1
                assert len(A) == a
                print("FOUND |G|=%d a=%d b=%d via size=%d |H|=%d k=%d trial=%d" % (n, a, n // a, size, h, k, trial), flush=True)
                out.write("%d %d\n" % (a, n // a)); out.write(" ".join(",".join(map(str, p)) for p in A) + "\n"); out.write(" ".join(",".join(map(str, p)) for p in B) + "\n"); out.flush()
                found = True; break
        if found: break
    if not found: print("NOT FOUND |G|=%d a=%d" % (n, a), flush=True)
print("FINISHED", flush=True)
