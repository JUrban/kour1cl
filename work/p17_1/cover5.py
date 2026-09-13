import sys, glob
sys.setrecursionlimit(100000)
def solve(fname, n):
    subs = []
    for line in open(fname):
        line = line.strip()
        if not line: continue
        ab, els = line.split(' ')
        subs.append((ab == 'true', frozenset(int(x) for x in els.split(','))))
    idn = set.intersection(*[set(S) for _, S in subs])   # identity (common to all subgroups)
    subs = [(a, S - idn) for a, S in subs]
    universe = frozenset(range(1, n+1)) - idn
    m = len(subs)
    masks = [sum(1 << x for x in S) for _, S in subs]
    full = sum(1 << x for x in universe)
    byelem = {x: [i for i in range(m) if x in subs[i][1]] for x in universe}
    best = [None]
    def rec(cov, chosen, nonab):
        if cov == full:
            if nonab: best[0] = list(chosen); return True
            return False
        rem = full & ~cov
        x = None; cands = None
        for e in universe:
            if (rem >> e) & 1:
                c = [i for i in byelem[e] if masks[i] & cov == 0]
                if x is None or len(c) < len(cands):
                    x, cands = e, c
                    if len(c) <= 1: break
        for i in cands:
            chosen.append(i)
            if rec(cov | masks[i], chosen, nonab or not subs[i][0]): return True
            chosen.pop()
        return False
    ok = rec(0, [], False)
    print(fname, "subgroups:", m, "nonabelian:", sum(1 for a,_ in subs if not a), "partition with a nonabelian component:", ok, flush=True)
for f in sorted(glob.glob('/project/work/p17_1/subs5_*.txt')): solve(f, 15625)
print("FINISHED")
