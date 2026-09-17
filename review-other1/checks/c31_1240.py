# C.31 (12.40): integer facts for PSL_6(5^a)
def v2(n):
    c=0
    while n%2==0: n//=2; c+=1
    return c
def F(q): return q**5+q**4+q**3+q**2+q-1
print("F(5) =", F(5), " (q^6-1)/(q-1)-2 =", (5**6-1)//4-2)
for a in [1,3,5,7,9,11]:
    q=5**a
    order_2part = sum(v2(q**i-1) for i in range(2,7)) - 1 + 0   # q^15 odd; divide by gcd(6,q-1)=2
    from math import gcd
    print("a=%d gcd(6,q-1)=%d v2 of q^i-1 (i=2..6): %s  -> v2|G| = %d" % (a, gcd(6,q-1), [v2(q**i-1) for i in range(2,7)], sum(v2(q**i-1) for i in range(2,7)) - v2(gcd(6,q-1))))
# construct a with v2(F(5^a)) = k exactly, following the paper's procedure
a=1; found={}
for k in range(3,16):
    assert F(5**a) % 2**k == 0, (k,a)
    b = a + 2**(k-2)
    if F(5**a) % 2**(k+1) == 0:
        found[k]=b; assert v2(F(5**b))==k
    else:
        found[k]=a; assert v2(F(5**a))==k; a=b
        assert F(5**a) % 2**(k+1)==0
print("exponents a with v2(F(5^a)) = k:", {k:(found[k], v2(F(5**found[k]))) for k in found})
print("check 5^(2^(k-2)) = 1+2^k mod 2^(k+1):", all(pow(5,2**(k-2),2**(k+1)) == (1+2**k) % 2**(k+1) for k in range(3,30)))
