# E.8 (20.8): Stallings core graphs for H = <a, (a^-1 b)^2, (a^-2 b^2)^2> and K = <u, aua^-1, v, a^2va^-2>
def fold(words):
    # vertices 0..; edges dict (v,letter) -> w with letter in 'ab' (positive direction)
    edges = {}
    rev = {}
    nxt = [1]
    def newv():
        nxt[0] += 1; return nxt[0]-1
    def add_edge(v, l, w):
        edges[(v,l)] = w; rev[(w,l)] = v
    for word in words:
        v = 0
        for ch in word:
            l = ch.lower(); pos = ch.islower()
            if pos:
                w = edges.get((v,l))
                if w is None:
                    w = newv(); add_edge(v,l,w)
                v = w
            else:
                w = rev.get((v,l))
                if w is None:
                    w = newv(); add_edge(w,l,v)
                v = w
        # close the loop back to base point by identifying v with 0
        union(v, 0, edges, rev)
    return edges
def parent_find(p, x):
    while p[x] != x: p[x] = p[p[x]]; x = p[x]
    return x
def stallings(words):
    # build a bouquet of subdivided loops then fold with union-find
    edges = []   # (u, letter, v)
    p = {0:0}
    nxt = [1]
    def newv():
        v = nxt[0]; nxt[0]+=1; p[v]=v; return v
    for word in words:
        v = 0
        for i, ch in enumerate(word):
            w = 0 if i == len(word)-1 else newv()
            if ch.islower(): edges.append((v, ch, w))
            else: edges.append((w, ch.lower(), v))
            v = w
    def find(x): return parent_find(p, x)
    def union(x,y):
        x,y = find(x), find(y)
        if x != y: p[max(x,y)] = min(x,y)
    changed = True
    while changed:
        changed = False
        seen = {}
        for (u,l,v) in edges:
            u,v = find(u), find(v)
            if (u,l,'out') in seen:
                if find(seen[(u,l,'out')]) != v: union(seen[(u,l,'out')], v); changed = True
            else: seen[(u,l,'out')] = v
            if (v,l,'in') in seen:
                if find(seen[(v,l,'in')]) != u: union(seen[(v,l,'in')], u); changed = True
            else: seen[(v,l,'in')] = u
    E = set(); V = set()
    for (u,l,v) in edges:
        u,v = find(u), find(v); E.add((u,l,v)); V.add(u); V.add(v)
    return len(V), len(E), len(E) - len(V) + 1
def red(w):
    out = []
    for ch in w:
        if out and out[-1].swapcase() == ch: out.pop()
        else: out.append(ch)
    return ''.join(out)
u = red('Ab'*2)          # (a^{-1} b)^2   (upper case = inverse)
v = red('AAbb'*2)        # (a^{-2} b^2)^2
def conj(x, g): return red(g + x + g.swapcase()[::-1])
H = ['a', u, v]
K = [u, conj(u,'a'), v, conj(v,'aa')]
for name, W in [('H', H), ('K', K)]:
    V, E, r = stallings(W)
    print("%s = %s  -> core graph V=%d E=%d rank=%d" % (name, W, V, E, r))
# phi: a -> b, u -> u, v -> v  fixes the four generators of K?
def phi(word_in_H):   # rewrite a word in the basis {a,u,v} - we only need the four generators
    pass
print("b u b^-1 == a u a^-1 :", red('b'+u+'B') == red('a'+u+'A'))
print("b^2 v b^-2 == a^2 v a^-2 :", red('bb'+v+'BB') == red('aa'+v+'AA'))
