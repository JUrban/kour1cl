# Search for G = A B with |A| = a, |B| = b using A = H x_1 u ... u H x_k (right cosets of a subgroup H, x_1 = 1)
# and B an exact matching: the k-sets {H x_i b : i} (b in G) must partition H\G.
import sys, random, itertools
import networkx as nx
def load(fname):
    with open(fname) as f:
        n = int(f.readline()); mul = [list(map(int, f.readline().split())) for _ in range(n)]
        m = int(f.readline()); subs = [list(map(int, f.readline().split())) for _ in range(m)]
    return n, mul, subs
n, mul, subs = load(sys.argv[1]); a = int(sys.argv[2]); b = n // a
assert a*b == n
inv = [None]*n
for x in range(n):
    for y in range(n):
        if mul[x][y] == 0 and mul[y][x] == 0: inv[x] = y; break
def verify(A, B):
    prods = set(mul[x][y] for x in A for y in B)
    return len(A)*len(B) == n and len(prods) == n
random.seed(int(sys.argv[3]) if len(sys.argv) > 3 else 1)
found = False
for H in sorted(subs, key=len, reverse=True):
    h = len(H)
    if a % h: continue
    k = a // h
    # right cosets H g: index by a canonical representative (min element)
    cosetid = [None]*n
    reps = []
    for g in range(n):
        if cosetid[g] is None:
            C = sorted(mul[x][g] for x in H)
            cid = len(reps); reps.append(C)
            for c in C: cosetid[c] = cid
    m = len(reps)  # = n/h
    assert m % 1 == 0
    for trial in range(200):
        xs = [0] + random.sample(range(1, n), k-1)
        # hyperedges: for b in G: tuple of cosets (H x_i b)
        edges = {}
        for bb in range(n):
            t = tuple(cosetid[mul[x][bb]] for x in xs)
            if len(set(t)) < k: continue
            edges.setdefault(tuple(sorted(t)), bb)
        if k == 2:
            Gr = nx.Graph(); Gr.add_nodes_from(range(m)); Gr.add_edges_from(edges.keys())
            M = nx.max_weight_matching(Gr, maxcardinality=True)
            if 2*len(M) == m:
                B = [edges[tuple(sorted(e))] for e in M]
                A = [mul[y][x] for x in xs for y in H]
                if verify(A, B):
                    print("FOUND a=%d b=%d via |H|=%d k=%d xs=%s" % (a, b, h, k, xs)); print("A =", sorted(A)); print("B =", sorted(B)); found = True; break
        else:
            # exact cover by k-sets: simple DLX-like backtracking (Algorithm X) on m vertices
            options = list(edges.keys())
            byv = [[] for _ in range(m)]
            for idx, t in enumerate(options):
                for v in t: byv[v].append(idx)
            covered = [False]*m; chosen = []
            sys.setrecursionlimit(10000)
            nodes = [0]
            def solve():
                nodes[0] += 1
                if nodes[0] > 2000000: return False
                # pick uncovered vertex with fewest available options
                best = None; bestopts = None
                for v in range(m):
                    if covered[v]: continue
                    opts = [i for i in byv[v] if all(not covered[u] for u in options[i])]
                    if best is None or len(opts) < len(bestopts):
                        best, bestopts = v, opts
                        if len(opts) == 0: return False
                if best is None: return True
                for i in bestopts:
                    for u in options[i]: covered[u] = True
                    chosen.append(i)
                    if solve(): return True
                    chosen.pop()
                    for u in options[i]: covered[u] = False
                return False
            if solve():
                B = [edges[options[i]] for i in chosen]
                A = [mul[y][x] for x in xs for y in H]
                if verify(A, B):
                    print("FOUND a=%d b=%d via |H|=%d k=%d xs=%s" % (a, b, h, k, xs)); print("A =", sorted(A)); print("B =", sorted(B)); found = True; break
    if found: break
if not found: print("no factorization found for a=%d" % a)
