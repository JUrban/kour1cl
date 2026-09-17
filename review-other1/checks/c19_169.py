# C.19 (16.9): DP for palindromic length in F2 vs bounded brute force
import itertools
from collections import deque
INV = {'a':'A','A':'a','b':'B','B':'b'}
def red(w):
    out = []
    for c in w:
        if out and out[-1] == INV[c]: out.pop()
        else: out.append(c)
    return ''.join(out)
def dp_pl(w):
    idx = {'a':'1','b':'2'}
    W = ''
    for c in w:
        if c in 'ab': W += idx[c] + '0'
        else: W += '0' + idx[c.lower()]
    def d(V):
        L = len(V)
        D = [[0]*(L+1) for _ in range(L+1)]
        for length in range(1, L+1):
            for i in range(0, L-length+1):
                j = i + length
                best = 1 + D[i+1][j]
                for k in range(i+1, j):
                    if V[k] == V[i]:
                        best = min(best, D[i+1][k] + D[k+1][j])
                D[i][j] = best
        return D[0][L]
    return min(d(W), d(W + '0'))
# brute force: BFS in the Cayley graph w.r.t. palindromes of length <= P, elements of length <= M
P, M, T = 7, 11, 5
letters = 'abAB'
def words(maxlen):
    res = ['']
    frontier = ['']
    for l in range(maxlen):
        nf = []
        for w in frontier:
            for c in letters:
                if w and w[-1] == INV[c]: continue
                nf.append(w+c)
        res += nf; frontier = nf
    return res
pals = [w for w in words(P) if w == w[::-1]]
dist = {'': 0}
q = deque([''])
while q:
    w = q.popleft()
    for p in pals:
        v = red(w + p)
        if len(v) <= M and v not in dist:
            dist[v] = dist[w] + 1; q.append(v)
bad = 0; cnt = 0
for w in words(T):
    cnt += 1
    a = dp_pl(w); b = dist.get(w)
    if a != b: bad += 1; print("MISMATCH", w, "dp", a, "brute", b)
print("words checked", cnt, "palindromes used", len(pals), "mismatches", bad)
print("max pl among checked:", max(dp_pl(w) for w in words(T)))
