# C.22 (20.92(a)): the weighted coefficient extraction and the degree bookkeeping
from sympy import n_order, isprime
def check(p, D):
    out = []
    for j in range(1, D+1):
        s = sum(pow(2, i*(j-1), p) for i in range(0, p-1)) % p
        out.append(s)
    return out
bad = 0
for p in [19, 23, 29, 31, 37, 101, 131]:
    d = n_order(2, p)
    for D in range(1, d):          # hypothesis: ord_p(2) > D
        vals = check(p, D)
        want = [(-1) % p] + [0]*(D-1)
        if vals != want:
            bad += 1; print("FAIL", p, D, vals[:5])
    print("p=%3d ord_p(2)=%3d : identity holds for all D < ord_p(2)" % (p, d))
print("violations:", bad)
# degree bookkeeping
for k in range(2, 7):
    E = k*2**(k-2); D = (k-1)*E
    print("k=%d : E = %d, D = %d, 2^D = %s" % (k, E, D, 2**D if D < 60 else "big"))
# p > 2^D forces ord_p(2) > D
for k in [2,3]:
    E = k*2**(k-2); D = (k-1)*E
    ps = [p for p in range(2**D+1, 2**D+400) if isprime(p)][:3]
    print("k=%d, D=%d: primes just above 2^D and their ord_p(2) > D ? %s" % (k, D, [(p, n_order(2,p), n_order(2,p) > D) for p in ps]))
