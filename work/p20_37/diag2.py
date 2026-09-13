import sys, random, itertools, time
exec(open('fact4.py').read().split("for a in mset:")[0].replace("fname = sys.argv[1]; seed = int(sys.argv[2]) if len(sys.argv) > 2 else 1; random.seed(seed)", "fname = sys.argv[1]; random.seed(7)"))
from pysat.solvers import Cadical153
a = int(sys.argv[2]); b = n // a
H = [t for t in subs if t[0] == int(sys.argv[3])][0]; K = [t for t in subs if t[0] == int(sys.argv[4])][0]
h, sg = H; kk, sgk = K; k = a // h; l = b // kk
Hels = elements(h, sg); Kels = elements(kk, sgk)
dcid = {}; m = 0
for g in els:
    if g in dcid: continue
    D = set(mul(mul(x, g), y) for x in Hels for y in Kels)
    assert len(D) == h * kk
    for d in D: dcid[d] = m
    m += 1
seen = set(); yreps = []
for g in els:
    if g in seen: continue
    yreps.append(g)
    for y in Kels: seen.add(mul(g, y))
print("m=%d k=%d l=%d yreps=%d" % (m, k, l, len(yreps)))
for trial in range(int(sys.argv[5])):
    xs = [els[0]] + random.sample(els[1:], k - 1)
    options = {}
    for y in yreps:
        t = tuple(sorted(dcid[mul(x, y)] for x in xs))
        if len(set(t)) < k: continue
        options.setdefault(t, y)
    opts = list(options.keys())
    byv = [[] for _ in range(m)]
    for i, t in enumerate(opts):
        for v in t: byv[v].append(i + 1)
    s = Cadical153()
    for v in range(m):
        s.add_clause(byv[v])
        for x, y in itertools.combinations(byv[v], 2): s.add_clause([-x, -y])
    t0 = time.time(); r = s.solve(); print("trial %d: options=%d %s %.1fs" % (trial, len(opts), "SAT" if r else "UNSAT", time.time() - t0), flush=True)
    s.delete()
