import sys, glob
# exact cover of nonidentity elements by subgroups (equal order); require at least one nonabelian
def solve(fname, n):
    subs = []
    for line in open(fname):
        line = line.strip()
        if not line: continue
        ab, els = line.split(' ')
        S = frozenset(int(x) for x in els.split(',')) - {1}   # identity is element 1 (GAP Position of One?) -- handle below
        subs.append((ab == 'true', S))
    # identify identity: the element common to all subgroups
    common = set.intersection(*[set(s[1] | {1}) for s in subs])
    idn = common
    subs = [(a, frozenset(S - idn)) for a, S in subs]
    universe = frozenset(range(1, n+1)) - idn
    m = len(subs)
    # bitmasks
    masks = [sum(1 << x for x in S) for _, S in subs]
    full = sum(1 << x for x in universe)
    byelem = {x: [i for i in range(m) if x in subs[i][1]] for x in universe}
    best = [None]
    sys.setrecursionlimit(10000)
    def rec(cov, chosen, nonab):
        if cov == full:
            if nonab:
                best[0] = list(chosen); return True
            return False
        # pick uncovered element with fewest candidates
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
    if ok:
        print("  components:", [("A" if subs[i][0] else "N") for i in best[0]])
for f in sorted(glob.glob('/project/work/p17_1/subs_243_*.txt')): solve(f, 243)
for f in sorted(glob.glob('/project/work/p17_1/subs_729_*.txt')): solve(f, 729)
