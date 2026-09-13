import sys, random, time, itertools
exec(open('fact2.py').read().split("for a in mset:")[0].replace("fname = sys.argv[1]; seed = int(sys.argv[2]) if len(sys.argv) > 2 else 1; random.seed(seed)", "fname = sys.argv[1]; random.seed(3)"))
a = int(sys.argv[2])
for h, sg in sorted(subs, key=lambda t: -t[0]):
    if a % h: continue
    k = a // h
    Hels, _ = closure(sg, deg)
    cosetid = {}; m = 0
    for g in els:
        if g not in cosetid:
            for x in Hels: cosetid[mul(x, g)] = m
            m += 1
    for trial in range(3):
        xs = [els[0]] + random.sample(els[1:], k - 1)
        edges = {}
        for bb in els:
            t = tuple(sorted(cosetid[mul(x, bb)] for x in xs))
            if len(set(t)) < k: continue
            edges.setdefault(t, bb)
        options = list(edges.keys())
        t0 = time.time(); r = exact_cover_sat(m, options, budget=2000000); dt = time.time() - t0
        print("a=%d h=%d k=%d m=%d options=%d result=%s time=%.1fs" % (a, h, k, m, len(options), "SAT" if r else ("UNSAT/limit"), dt), flush=True)
