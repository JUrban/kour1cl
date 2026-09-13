# 20.37: two-sided construction.  A = H X (right cosets of H), B = Y K (left cosets of K) with all (H,K)-double cosets
# regular (|HgK| = |H||K| for all g).  Then G = AB iff the k-sets {H x_i y K : i} (y in Y) partition Omega = H\G/K.
# Search: random X, exact cover for Y via DLX.  Solutions appended to solb_<n>.txt and verified by direct multiplication.
import sys, random, subprocess, time
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
nodelimit = int(sys.argv[3]) if len(sys.argv) > 3 else 2000000
maxk = int(sys.argv[4]) if len(sys.argv) > 4 else 60
n, deg, mset, gens, subs = load(fname)
els, idx = closure(gens, deg); assert len(els) == n
solname = fname.replace('caseb_', 'solb_')
try: donea = set(int(l.split()[0]) for i, l in enumerate(open(solname)) if i % 3 == 0 and l.strip())
except FileNotFoundError: donea = set()
out = open(solname, 'a')
elcache = {}
def elements(h, sg):
    key = (h, tuple(sg))
    if key not in elcache: elcache[key] = closure(sg, deg)[0]
    return elcache[key]
def attempt(a, h, sg, kk, sgk, trials):
    b = n // a; k = a // h; l = b // kk
    Hels = elements(h, sg); Kels = elements(kk, sgk)
    # double cosets H g K; require regularity
    dcid = {}; m = 0
    for g in els:
        if g in dcid: continue
        D = set(mul(mul(x, g), y) for x in Hels for y in Kels)
        if len(D) != h * kk: return None   # non-regular double coset: skip this pair
        for d in D: dcid[d] = m
        m += 1
    assert m == n // (h * kk)
    # left coset representatives of K
    seen = set(); yreps = []
    for g in els:
        if g in seen: continue
        yreps.append(g)
        for y in Kels: seen.add(mul(g, y))
    for trial in range(trials):
        xs = [els[0]] + random.sample(els[1:], k - 1)
        options = {}
        for y in yreps:
            t = tuple(sorted(dcid[mul(x, y)] for x in xs))
            if len(set(t)) < k: continue
            options.setdefault(t, y)
        opts = list(options.keys())
        inp = "%d\n" % m + "".join("%d %s\n" % (k, " ".join(map(str, t))) for t in opts)
        r = subprocess.run(["./dlx", str(nodelimit), str(random.randrange(1 << 30))], input=inp, capture_output=True, text=True, timeout=7200)
        line = r.stdout.strip()
        if line.startswith("NONE"): continue
        Y = [options[opts[int(i)]] for i in line.split()]
        A = [mul(x, xi) for xi in xs for x in Hels]; B = [mul(y, z) for y in Y for z in Kels]
        prods = set(mul(x, y) for x in A for y in B)
        if len(A) == a and len(B) == b and len(prods) == n: return A, B, k, l, m, trial
        print("verification failed?!", a, h, kk, flush=True)
    return "tried"
for a in mset:
    if a in donea: print("already solved a=%d" % a, flush=True); continue
    b = n // a; found = False
    pairs = []
    for h, sg in subs:
        if a % h: continue
        for kk, sgk in [(1, [])] + subs:
            if b % kk: continue
            if a // h > maxk or (kk > 1 and b // kk > maxk and a // h > 2): continue
            pairs.append((h * kk, h, sg, kk, sgk))
    pairs.sort(key=lambda t: -t[0])
    for hk, h, sg, kk, sgk in pairs:
        res = attempt(a, h, sg, kk, sgk, 5)
        if res is None or res == "tried": continue
        A, B, k, l, m, trial = res
        print("FOUND |G|=%d a=%d b=%d via |H|=%d k=%d |K|=%d l=%d |Omega|=%d trial=%d" % (n, a, b, h, k, kk, l, m, trial), flush=True)
        out.write("%d %d\n" % (a, b)); out.write(" ".join(",".join(map(str, p)) for p in A) + "\n"); out.write(" ".join(",".join(map(str, p)) for p in B) + "\n"); out.flush()
        found = True; break
    if not found: print("NOT FOUND |G|=%d a=%d" % (n, a), flush=True)
print("FINISHED", flush=True)
