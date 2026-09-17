# C.24 (9.45): compare the paper's criterion with brute-force search for orthogonal bases of S(r/m)
import itertools, math
from fractions import Fraction as Fr
def criterion(r, m):
    n = len(r); z = sum(1 for x in r if x == 0); W = set()
    for k in range(1, m):
        base = [(k*x) % m for x in r]
        opts = []
        ties = 0
        for c in base:
            if 2*c < m: opts.append([c])
            elif 2*c > m: opts.append([c - m])
            else: opts.append([c, -c]); ties += 1
        if ties > 2: continue
        for w in itertools.product(*opts):
            w = list(w)
            if all(x == 0 for x in w): continue
            fnz = next(x for x in w if x != 0)
            if fnz < 0: continue
            Q = sum(x*x for x in w)
            if all((m*x) % Q == 0 for x in w) and sum(a*b for a,b in zip(r, w)) % Q == 0:
                W.add(tuple(w))
    return z + len(W) == n
def brute(r, m):
    n = len(r)
    # lattice vectors of norm <= 1 in S = Z^n + Z r/m, scaled by m: integer w with w = k r mod m, |w|^2 <= m^2
    B = m
    vecs = []
    for w in itertools.product(range(-B, B+1), repeat=n):
        if all(x == 0 for x in w) or sum(x*x for x in w) > m*m: continue
        if any(all((w[j] - k*r[j]) % m == 0 for j in range(n)) for k in range(m)):
            fnz = next(x for x in w if x != 0)
            if fnz > 0: vecs.append(w)
    target = m**(n-1)   # |det| of basis (scaled by m) must be m^n / m
    def det(M):
        if len(M) == 1: return M[0][0]
        if len(M) == 2: return M[0][0]*M[1][1]-M[0][1]*M[1][0]
        return sum((-1)**c * M[0][c] * det([row[:c]+row[c+1:] for row in M[1:]]) for c in range(len(M)))
    for combo in itertools.combinations(vecs, n):
        if all(sum(a*b for a,b in zip(u,v)) == 0 for u,v in itertools.combinations(combo, 2)):
            if abs(det([list(v) for v in combo])) == target: return True
    return False
cnt = 0; bad = 0
for n, M in [(2, 12), (3, 7)]:
    for m in range(2, M+1):
        for r in itertools.product(range(m), repeat=n):
            if math.gcd(m, *r) != 1: continue
            c = criterion(list(r), m); b = brute(list(r), m); cnt += 1
            if c != b: bad += 1; print("MISMATCH", n, m, r, "criterion", c, "brute", b)
print("cases", cnt, "mismatches", bad)
print("examples: (1,5,2)/6:", criterion([1,5,2],6), brute([1,5,2],6), " (1,1)/6:", criterion([1,1],6), " (1,1,1)/2:", criterion([1,1,1],2))
