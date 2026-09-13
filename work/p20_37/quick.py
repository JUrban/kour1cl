import sys, random
import networkx as nx
exec(open('fact.py').read().split("random.seed")[0].replace("n, mul, subs = load(sys.argv[1]); a = int(sys.argv[2]); b = n // a","n, mul, subs = load('L28.txt'); a = 12; b = n//a"))
H = [S for S in subs if len(S) == 6][0]
cosetid = [None]*n; reps = []
for g in range(n):
    if cosetid[g] is None:
        C = sorted(mul[x][g] for x in H); cid = len(reps); reps.append(C)
        for c in C: cosetid[c] = cid
m = len(reps)
random.seed(5)
for trial in range(5):
    x = random.randrange(1, n)
    Gr = nx.MultiGraph(); Gr.add_nodes_from(range(m))
    loops = 0
    for bb in range(n):
        u, v = cosetid[bb], cosetid[mul[x][bb]]
        if u == v: loops += 1
        else: Gr.add_edge(u, v)
    M = nx.max_weight_matching(nx.Graph(Gr), maxcardinality=True)
    comps = [len(c) for c in nx.connected_components(Gr)]
    print("x=%d loops=%d edges=%d matching=%d/%d components=%s bipartite=%s" % (x, loops, Gr.number_of_edges(), len(M), m//2, comps, nx.is_bipartite(Gr)))
