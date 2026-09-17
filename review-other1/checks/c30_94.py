# C.30 (9.4): t_{n!}(x,y) = y in every quasigroup of order <= n; and the shift quasigroup violating t_N
import itertools
def latin_squares(n):
    rows = [p for p in itertools.permutations(range(n))]
    def ext(sq):
        if len(sq) == n: yield sq; return
        for r in rows:
            if all(all(r[c] != s[c] for c in range(n)) for s in sq): yield from ext(sq+[r])
    yield from ext([])
import math
for n in [2,3,4]:
    N = math.factorial(n); bad = 0; cnt = 0
    for sq in latin_squares(n):
        cnt += 1
        for x in range(n):
            for y in range(n):
                z = y
                for _ in range(N): z = sq[x][z]       # t_{j+1}(x,y) = x * t_j(x,y)
                if z != y: bad += 1
    print("order %d: %d quasigroups, violations of t_%d(x,y)=y: %d" % (n, cnt, N, bad))
# the paper's counterexample family: A = F_p^m with a*b = a + T(b), T the basis cycle
p, N = 3, 6      # N = n! for n = 3
m = N+1
def tN(x, y):
    z = y
    for _ in range(N):
        z = tuple((a+b) % p for a,b in zip(x, (z[-1],)+z[:-1]))   # x + T(z), T = cyclic shift of basis
    return z
e0 = tuple([1]+[0]*(m-1)); zero = tuple([0]*m)
print("t_%d(0, e_0) = %s   e_%d = %s   different: %s" % (N, tN(zero, e0), N, tuple([0]*N+[1]+[0]*(m-N-1)), tN(zero,e0) != e0))
